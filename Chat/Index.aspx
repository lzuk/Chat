<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Chat.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chat</title>
    <script type="text/javascript" src="http://fp-pc1598.fp.lan:27205/Scripts/jquery-2.0.3.js"></script>
    <script type="text/javascript" src="http://fp-pc1598.fp.lan:27205/Scripts/jquery.signalR-2.0.0.js"></script>
    <script type="text/javascript" src="signalr/hubs"></script>
    <script type="text/javascript">

        var myChatHub = $.connection.ChatHub;
        myChatHub.client.hello = function (message) {
            var chatResponsesJs = document.getElementById('chatResponses');
            chatResponsesJs.value += message;
            chatResponsesJs.value += '\r\n';
        };
        $.connection.hub.start();

        function onSendButtonClick() {
            var valueToSend = document.getElementById('chatTextBox').value;
            myChatHub.server.send(valueToSend);
        }
       
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input id="chatTextBox" type="text" />
        <input id="sendButton" type="button" value="Send" onclick="onSendButtonClick()"/>
        <br/>
        <textarea id="chatResponses" cols="20" rows="2" readonly="readonly"></textarea>

    </form>   
</body>
</html>
