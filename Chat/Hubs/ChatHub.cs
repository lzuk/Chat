using System;
using System.Collections.Generic;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;

namespace Chat.Hubs
{
    [HubName("ChatHub")]
    public class ChatHub : Hub
    {
        public void Hello(string message)
        {
            Clients.All.hello(message);
        }

        public void Send(string message)
        {
            textList.Add(message);
            Hello(message);
        }
        private static List<String> textList = new List<string>();
    }
}