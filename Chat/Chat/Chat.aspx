<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Chat.aspx.cs" Inherits="Chat.Chat.Chat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <script type="text/javascript" src="http://code.jquery.com/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/signalr/jquery.signalr-1.1.3.min.js"></script>
    <script type="text/javascript" src="../signalr/hubs"></script>
    <script type="text/javascript">

        var myChatHub = $.connection.ChatHub;
        myChatHub.client.newMessage = function (nickname, message) {
            var chatResponsesJs = document.getElementById('chatResponses');
            chatResponsesJs.rows = chatResponsesJs.rows + 1;
            chatResponsesJs.scrollTop = chatResponsesJs.scrollHeight;
            chatResponsesJs.value += nickname + " - " + message + '\r\n';
        };
        myChatHub.client.newUserList = function(userList) {
            var chatUserList = document.getElementById('chatUsers');
            chatUserList.value = "";
            chatUserList.rows = userList.length;
            for (var x = 0 ; x < userList.length; x++) {
                chatUserList.value += userList[x] + '\r\n';
            }
        };

        myChatHub.client.userDisconnected = function (nickname) {
            var chatResponsesJs = document.getElementById('chatResponses');
            chatResponsesJs.rows = chatResponsesJs.rows + 1;
            chatResponsesJs.value += nickname + " has left" + '\r\n';
        };

        myChatHub.client.newUserJoined = function (nickname) {
            var chatResponsesJs = document.getElementById('chatResponses');
            chatResponsesJs.rows = chatResponsesJs.rows + 1;
            chatResponsesJs.value += nickname + " has joined the chat" + '\r\n';
        };

        myChatHub.client.notifyFromServer = function (message) {
            window.Alert(message);
        };

        $.connection.hub.start();

        function onSendButtonClick() {
            var message = document.getElementById('chatTextBox').value;

            myChatHub.server.send(message);
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <input id="chatTextBox" type="text" />
        <input id="sendButton" type="button" value="Send" onclick="onSendButtonClick()"/>
        <br/>
        <textarea id="chatResponses" cols="20" rows="1" readonly="readonly"></textarea>
        <textarea id="chatUsers" cols="20" rows="1" readonly="readonly"></textarea>
        <asp:Button ID="singOutButton" OnClick="Signout_Click"
        Text="Sign Out" runat="server" />
    </div>
    </form>
</body>
</html>
