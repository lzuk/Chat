<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Chat.aspx.cs" Inherits="Chat.Chat.Chat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Content/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="/Content/login.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="../Scripts/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery.signalR-2.0.0.min.js"></script>
    <script type="text/javascript" src="../signalr/hubs"></script>
    <script type="text/javascript" src="../Scripts/bootstrap.min.js"></script>
    <script type="text/javascript">

        var myChatHub = $.connection.ChatHub;
        syncBoxesSize = function () {
            var chatResponsesJs = document.getElementById('chatResponses');
            var chatUserList = document.getElementById('chatUsers');
            var result = Math.max(chatResponsesJs.rows, chatUserList.rows);
            chatUserList.rows = result;
            chatResponsesJs.rows = result;
        };

        addMsg = function (msg) {
            var chatResponsesJs = document.getElementById('chatResponses');
            chatResponsesJs.rows = chatResponsesJs.rows + 1;
            chatResponsesJs.scrollTop = chatResponsesJs.scrollHeight;
            chatResponsesJs.value += msg + '\r\n';
            syncBoxesSize();
        };

        myChatHub.client.newMessage = function (nickname, message) {
            var msg = nickname + " - " + message;
            addMsg(msg);    
        };

        myChatHub.client.newUserList = function(userList) {
            var chatUserList = document.getElementById('chatUsers');
            chatUserList.value = "";
            chatUserList.rows = userList.length;
            for (var x = 0 ; x < userList.length; x++) {
                chatUserList.value += userList[x] + '\r\n';
            }
            syncBoxesSize();
        };

        myChatHub.client.userDisconnected = function (nickname) {
            var msg = nickname + " has left";
            addMsg(msg);
        };

        myChatHub.client.newUserJoined = function (nickname) {
            var msg = nickname + " has joined the chat";
            addMsg(msg);
        };

        myChatHub.client.notifyFromServer = function (message) {
            window.Alert(message);
        };

        $.connection.hub.start();

        function onSendButtonClick() {
            var message = document.getElementById('chatTextBox').value;
            myChatHub.server.send(message);
        }

        $(document).ready(function() {
            $('form input').keydown(function (event) {
                if (event.keyCode == 13) {
                    event.preventDefault();
                    return false;
                }
            });
        } );
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="alert alert-success">
        Hello <% %>! Start chating...
        <div style="float: right; align-self: center">
            <asp:Button ID="singOutButton" class="btn btn-danger" type="button" OnClick="Signout_Click" Text="Sign Out" runat="server" />
        </div>    
    </div>
    <div data-bind="visible: isInPrivateChat" class="alert alert-info">
        You are in a private chat with @@<span data-bind="text: privateChatUser"></span>! <a href="#" data-bind=" click: exitFromPrivateChat">Exit from private chat?</a>
    </div>

    <div>
        <textarea id="chatUsers" cols="20" rows="5" readonly="readonly"></textarea> 
        <textarea id="chatResponses" cols="50" rows="5" readonly="readonly"></textarea>
        
        <br/>
        <div class="row">
  <div class="col-lg-6">
    <div class="input-group">
      <input  id="chatTextBox" type="text" class="form-control" onkeydown="if (event.keyCode == 13) document.getElementById('sendButton').click(); "/>
      <span class="input-group-btn">
        <button id="sendButton" class="btn btn-info" type="button" onclick="onSendButtonClick()">Go!</button>
      </span>
    </div><!-- /input-group -->
  </div><!-- /.col-lg-6 -->
</div><!-- /.row -->
    </div>
    </form>
</body>
</html>
