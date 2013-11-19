﻿using System.Collections;
using System.Collections.Concurrent;
using System.Collections.Generic;
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
            Clients.All.newMessage(username, message);

            Task saveMsg = new Task(() => DatabaseAccessor.Instance.SaveMsgToDatabase(Membership.GetUser(username), message));
            saveMsg.Start();
        }


        public void SendToSpecified(string nickname, string message)
        {
            string username = HttpContext.Current.User.Identity.Name; 
            Task saveMsg = new Task(() => DatabaseAccessor.Instance.SaveMsgToDatabase(Membership.GetUser(username), Membership.GetUser(nickname), message));
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
                Clients.Caller.newMessage(msg.Sender.UserName, msg.Msg); //only freshly connected node, not client
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