<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Chat.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chat</title>
    <script type="text/javascript" src="/Scripts/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="/Scripts/jquery.signalR-2.0.0.min.js"></script>
    <script type="text/javascript" src="http://localhost:27205/signalr"></script>
    <script type="text/javascript">
        /*
        (function () {
            //create signal hub connection
            $.connection.hub.url = 'http://localhost:27205/signalr/';
            myChatHub = $.connection.ChatHub;
            $.connection.hub.start(function () {
                myChatHub.Send("dupa");
                alert("komunikat poszedl");
            });
        })(); 
        */
    </script>
</head>
<body>
    <form id="form1" runat="server">
    </form>
</body>
</html>
