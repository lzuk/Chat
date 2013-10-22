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
        myChatHub.client.notifyFromServer = function (nickname, message) {
            var chatResponsesJs = document.getElementById('chatResponses');
            chatResponsesJs.value += nickname + " - " + message + '\r\n';
        };
        $.connection.hub.start();

        function onSendButtonClick() {
            var message = document.getElementById('chatTextBox').value;
            var nickName = document.getElementById('nickBox').value;
            myChatHub.server.send(nickName, message);
        }
       
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input id="nickBox" type="text" />
        <label >Nick</label>
        <br/>
        <input id="chatTextBox" type="text" />
        <input id="sendButton" type="button" value="Send" onclick="onSendButtonClick()"/>
        <br/>
        <textarea id="chatResponses" cols="20" rows="2" readonly="readonly"></textarea>

    </form>   
</body>
</html>
