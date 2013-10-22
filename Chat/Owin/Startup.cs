using Microsoft.AspNet.SignalR;
using Microsoft.Owin;
using Owin;

[assembly: OwinStartup(typeof(Chat.Owin.Startup))]

namespace Chat.Owin
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            // For more information on how to configure your application, visit http://go.microsoft.com/fwlink/?LinkID=316888
            var config = new HubConfiguration
            {
                EnableJSONP = true,
                EnableJavaScriptProxies = true,
                EnableDetailedErrors = true
            };
            app.MapSignalR(config);
        }
    }
}
