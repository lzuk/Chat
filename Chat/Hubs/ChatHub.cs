using System.Collections;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
using System;
using Chat.Chat;
using System.Web.Security;

namespace Chat.Hubs
{
    [HubName("ChatHub"), Authorize]
    public class ChatHub : Hub
    {
        public void Send(string message)
        {
            if (HttpContext.Current.User == null && !HttpContext.Current.User.Identity.IsAuthenticated)
                return;
            string username = HttpContext.Current.User.Identity.Name;
            if (message.StartsWith("\\"))
            {
                string receiver;
                try
                {
                    string[] words = message.Split(' ');
                    if (words[0].StartsWith("\\") && words[0].Length > 1) //to prevent \ user_name
                    {
                        receiver = words[0];
                        int iterations = 0;
                        while (receiver.StartsWith("\\"))
                        {
                            receiver = receiver.Replace("\\", "");
                            iterations += 2;
                        }
                        message = message.Remove(0, receiver.Length + iterations); //missing \ and space after username
                        Clients.Caller.newPrivMessageTo(DateTime.Now.ToString(CultureInfo.InvariantCulture), receiver,
                           message);
                        SendToSpecified(receiver, message);
                    }
                    else
                    {
                        Clients.Caller.notifyFromServer("Wrong message format");
                    }
                }
                catch (NullReferenceException)
                {
                    Clients.Caller.notifyFromServer("Wrong message format");
                    return;
                }
                catch (ArgumentOutOfRangeException)
                {
                    Clients.Caller.notifyFromServer("Wrong message format");
                    return;
                }
            }
            else
            {
                Clients.All.newMessage(DateTime.Now.ToString(CultureInfo.InvariantCulture), username, message);
            }
            Task saveMsg = new Task(() => DatabaseAccessor.Instance.SaveMsgToDatabase(Membership.GetUser(username), message));
            saveMsg.Start();
        }


        private void SendToSpecified(string receiver, string message)
        {
            if (HttpContext.Current.User == null && !HttpContext.Current.User.Identity.IsAuthenticated)
                return;
            string sender = HttpContext.Current.User.Identity.Name;

            User user;
            Users.TryGetValue(receiver, out user);

            if (user != null)
            {
                Clients.Clients(user.ConnectionIds.ToList()).newPrivMessage(DateTime.Now.ToString(CultureInfo.InvariantCulture), sender, message);
            }

            //Clients.Client() aaaaaaaaaaa
            Task saveMsg = new Task(() => DatabaseAccessor.Instance.SaveMsgToDatabase(Membership.GetUser(sender), Membership.GetUser(receiver), message));
            saveMsg.Start();
        }

        public void RefreshUsersList()
        {
            ArrayList list = new ArrayList();
            foreach (KeyValuePair<string, User> user in Users)
            {
                list.Add(user.Key);
            }
            Clients.All.newUserList(list);
        }
        public override Task OnConnected()
        {
            AddNewUserAndConnection();
            RefreshUsersList();
            SendLastMessages();
            return base.OnConnected();
        }
        private void SendLastMessages()
        {
            string username = Context.Request.GetHttpContext().User.Identity.Name;

            foreach (Message msg in DatabaseAccessor.Instance.LastMessages(Membership.GetUser(username), 20))
            {
                if (msg.Receiver == null)
                {
                    Clients.Caller.newMessage(msg.DateTime.ToString(CultureInfo.InvariantCulture), msg.Sender.UserName, msg.Msg); //only freshly connected node, not client
                }
                else
                {
                    Clients.Caller.newPrivMessage(msg.DateTime.ToString(CultureInfo.InvariantCulture), msg.Sender.UserName, msg.Msg);
                }
                
            }
        }
        public override Task OnDisconnected()
        {
            string userName = "";
            try
            {
                userName = Context.User.Identity.Name;
            }
            catch (NullReferenceException)
            {
                base.OnDisconnected();
            }
            string connectionId = Context.ConnectionId;

            User user;
            Users.TryGetValue(userName, out user);
            if (user != null)
            {
                lock (user.ConnectionIds)
                {
                    user.ConnectionIds.RemoveWhere(cid => cid.Equals(connectionId));
                    if (!user.ConnectionIds.Any())
                    {

                        User removedUser;
                        Users.TryRemove(userName, out removedUser);

                        Clients.Others.userDisconnected(userName);
                    }
                }
            }
            RefreshUsersList();
            return base.OnDisconnected();
        }
        public override Task OnReconnected()
        {
            AddNewUserAndConnection();
            RefreshUsersList();
            return base.OnReconnected();
        }

        private void AddNewUserAndConnection()
        {
            string userName = Context.User.Identity.Name;
            string connectionId = Context.ConnectionId;
            var user = Users.GetOrAdd(userName, new User
            {
                Name = userName,
                ConnectionIds = new HashSet<string>()
            });

            lock (user.ConnectionIds)
            {
                user.ConnectionIds.Add(connectionId);
                Clients.AllExcept(user.ConnectionIds.ToArray()).newUserJoined(userName);
            }
        }
        private static readonly ConcurrentDictionary<string, User> Users = new ConcurrentDictionary<string, User>();
    }

    class User
    {
        public string Name { get; set; }
        public HashSet<string> ConnectionIds { get; set; }
    }
}