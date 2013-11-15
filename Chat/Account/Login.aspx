<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Chat.Account.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-2.0.3.min.js"></script>
    </script>
    <link href="/Content/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="/Content/login.css" rel="stylesheet" type="text/css">
    
</head>
<body>
   <form id="loginForm" runat="server">
       <div class="container">
    <div class="row">
        <div class="col-md-3 col-md-offset-4">
            <div class="account-box">
                <div class="logo ">
                    <img src="http://placehold.it/90x38/fff/6E329D&text=LOGO" alt=""/>
                </div>
                <div class="form-group">
                    <input id="nickName" runat="server" type="text" class="form-control" placeholder="Nick name" required autofocus />
                </div>
                <div class="form-group">
                    <input id="password" type="password" runat="server" class="form-control" placeholder="Password" required />
                </div>
                <label class="checkbox">
                <input id="keepSigned" type="checkbox" runat="server" value="remember-me" />
                    Keep me signed in
                </label>
                <asp:Label id="msg" runat="server" Text="" Visible="false"></asp:Label>
                <asp:Button class="btn btn-lg btn-block purple-bg" runat="server" onclick="btnSubmit_Click" Text="Sign in">
                    </asp:Button>
                <a class="forgotLnk" href="http://www.jquery2dotnet.com">I can't access my account</a>
                <div class="or-box row-block">
                    <div class="row">
                        <div class="col-md-12 row-block">
                            <a href="/Account/Register.aspx" class="btn btn-primary btn-block">Create New Account</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
       
    </form>
</body>
</html>
