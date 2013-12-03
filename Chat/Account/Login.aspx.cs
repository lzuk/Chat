using System;
using System.Drawing;
using System.Web.Security;

namespace Chat.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private const String ReturnUrlRegexPattern = @"\?ReturnUrl=.*$";

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Page.Validate();
            if (!Page.IsValid) return;
            string nick = nickName.Value;
            string pass = password.Value;
            bool keepSignedB = keepSigned.Checked;

            if (Membership.ValidateUser(nick, pass))
            {   
                FormsAuthentication.SetAuthCookie(nick, keepSignedB);
                Response.Redirect("/default.aspx");
            }
            else
            {
                msg.Visible = true;
                msg.ForeColor = Color.Red;
                msg.Text = "Invalid Username or Password";
            }
        }
    }
}