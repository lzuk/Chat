using System.Collections;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;

namespace Chat.Hubs
{
    [HubName("ChatHub"), Authorize]
    public class ChatHub : Hub
    {
        public void Send(string message)
        {
            if (HttpContext.Current.User == null && !HttpContext.Current.User.Identity.IsAuthenticated)
                return;
            Clients.All.newMessage(HttpContext.Current.User.Identity.Name, message);
        }

        public void SendToSpecified(string nickname, string message)
        {

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
            return base.OnConnected();
        }
        public override Task OnDisconnected()
        {
            string userName = Context.User.Identity.Name;
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
                //Clients.AllExcept(user.ConnectionIds.ToArray()).refreshUserList();
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