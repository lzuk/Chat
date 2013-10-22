<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Chat.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chat</title>
    <script type="text/javascript" src="/Scripts/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="/Scripts/jquery.signalR-2.0.0.min.js"></script>
    <script type="text/javascript" src="http://localhost:27205/signalr/hubs"></script>
    <script type="text/javascript">

        var myChatHub = $.connection.ChatHub;
        myChatHub.client.hello = function(message) {
            alert(message);
        };
        $.connection.hub.start().done(function() {
            myChatHub.server.send("dupa");
        });

       
    </script>
</head>
<body>
    <form id="form1" runat="server">
    </form>
</body>
</html>
