using System;
using System.Drawing;
using System.Web.Security;
using System.Web.UI;

namespace Chat
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            msg.ForeColor = Color.Red;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string nick = nickBox.Value;
            if (Membership.GetUser(nick) != null)
            {
                msg.Visible = true;
                msg.Text = "User name already taken";      
            }
            else
            {
                string mail = mailBox.Value;
                string password = passwordBox.Value;
                
                Membership.CreateUser(nick, password, mail);
                if (Membership.ValidateUser(nick, password))
                {
                    FormsAuthentication.RedirectFromLoginPage(nick, true);
                }
                else
                {
                    msg.Visible = true;
                    msg.Text = "Invalid error";
                }
            }          
        }
    }
}