using System;
using System.Web.Security;
using System.Web.UI;

namespace Chat
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Membership.GetUser(nickBox.Text) != null)
            {
                
            }
            else
            {
                string nick = nickBox.Text;
                string password = passwordBox.Text;
                
                Membership.CreateUser(nick, password, mailBox.Text);
                if (Membership.ValidateUser(nick, password))
                {
                    FormsAuthentication.RedirectFromLoginPage(nick, true);
                }
                else
                {
                    //msg.Text = "Invalid error";
                }
            }          
        }
    }
}