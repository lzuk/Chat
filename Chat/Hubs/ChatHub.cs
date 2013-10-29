using System;
using System.Collections.Generic;
using System.Web.UI;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;

namespace Chat.Hubs
{
    [HubName("ChatHub")]
    public class ChatHub : Hub
    {
        //wiadomosci ogolne
        public void Send(string nickname, string message)
        {
            Clients.All.newMessage(nickname, message);
        }

        public void Register(string nickname)
        {
            if (!clients.Contains(nickname))
            {
                Clients.All.newUserJoined(nickname);
                Clients.Caller.registered = true;
                clients.Add(nickname);
            }
            else
            {
                Clients.Caller.notifyFromServer("nickname already registered");
            }
        }

        public void SendToSpecified(string nickname, string message)
        {
            
        }
        private static HashSet<String> clients = new HashSet<string>();  
    }
}