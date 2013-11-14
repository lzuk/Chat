using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Chat.Chat
{
    public partial class Chat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected void Signout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect(@"Account\Login.aspx");
        }
    }
}