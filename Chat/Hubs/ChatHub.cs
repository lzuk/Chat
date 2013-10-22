using System;
using System.Collections.Generic;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;

namespace Chat.Hubs
{
    [HubName("ChatHub")]
    public class ChatHub : Hub
    {
        public void Send(string nickname, string message)
        {
            Clients.All.notifyFromServer(nickname, message);
        }
    }
}