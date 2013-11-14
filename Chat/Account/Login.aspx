<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Chat.Account.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
   <form id="loginForm" runat="server">
    <h2> Form Authentication</h2>
    <br />
    <table cellpadding="0" cellspacing="0">
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
    </form>
</body>
</html>
