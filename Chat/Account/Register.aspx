<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Chat.Register" %>
<%@ Register TagPrefix="asp" Namespace="Chat" Assembly="Chat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="../Scripts/jquery-2.0.3.min.js"></script>
    <link href="/Content/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="/Content/login.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <form id="form1" runat="server">
        
               <div class="container">
                   
    <div class="row">
        <div class="col-md-3 col-md-offset-4">
            <div class="account-box">
                <div class="logo ">
                    <img src="http://placehold.it/90x38/fff/6E329D&text=LOGO" alt=""/>
                </div>
                <div class="form-group">
                    <input type="text" id="nickBox" runat="server" class="form-control" placeholder="Nick name" required autofocus />
                </div>
                <div class="form-group">
                    <input type="text" id="mailBox" runat="server" class="form-control" placeholder="Email" required />
                </div>
                <div class="form-group">
                    <input type="password" id="passwordBox" runat="server" class="form-control" placeholder="Password" required />
                </div>
                <asp:Label id="msg" runat="server" Text="" Visible="false"></asp:Label>
                <asp:Button class="btn btn-lg btn-block purple-bg" runat="server" onclick="btnSave_Click" Text="Register">
                    </asp:Button>
            </div>
        </div>
    </div>
</div>
    </form>
</body>

</html>
