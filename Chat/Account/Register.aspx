<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Chat.Register" %>
<%@ Register TagPrefix="asp" Namespace="Chat" Assembly="Chat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:TextBox ID="nickBox" runat="server" MaxLength="50"></asp:TextBox>
        <asp:TextBox ID="passwordBox" runat="server" MaxLength="50"></asp:TextBox>
        <asp:TextBox ID="mailBox" runat="server" MaxLength="100"></asp:TextBox>
    </div>
        ><asp:Button ID="sendButton" runat="server" Text="Button" onclick="btnSave_Click"/>
    </form>
</body>

</html>
