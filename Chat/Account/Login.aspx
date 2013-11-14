<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Chat.Account.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-2.0.3.min.js"></script>
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
                <form class="form-signin" action="#">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Nick name" required autofocus />
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Email" required autofocus />
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="Password" required />
                </div>
                <label class="checkbox">
                <input type="checkbox" value="remember-me" />
                    Keep me signed in
                </label>
                <button class="btn btn-lg btn-block purple-bg" type="submit">
                    Sign in</button>
                </form>
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
       
       

    <h2> Form Authentication</h2>
    <br />
    <table>
    <tr>
    <td>
        <asp:Label ID="lblUser" runat="server" Text="Enter Nickname"></asp:Label>
    </td>
    <td>
        <asp:TextBox ID="txtUser" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
            ErrorMessage="*" ControlToValidate="txtUser" ></asp:RequiredFieldValidator>
    </td>
    <td>
        <asp:Label ID="msg" runat="server" Text=""></asp:Label>
    </td>
    </tr>
    <tr>
    <td>
        <asp:Label ID="lblPassword" runat="server" Text="Enter Password"></asp:Label>
    </td>
    <td>
        <asp:TextBox ID="txtPass" runat="server" TextMode="Password"></asp:TextBox>
    </td>
     <td>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
             ErrorMessage="*" ControlToValidate="txtPass" ></asp:RequiredFieldValidator>
    </td>
    </tr>
    </table><br/>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnSubmit" runat="server" Text="Login"
        onclick="btnSubmit_Click" />
    <asp:Button ID="btnReset" runat="server" Text="Reset"
        onclick="btnReset_Click" />
       <br/>
    </form>
</body>
</html>
