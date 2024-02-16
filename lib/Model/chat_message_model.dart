class ChatMessage {
  String messageContent;
  String messageType;
  String imgURL;
  ChatMessage({
    required this.messageContent,
    required this.messageType,
    required this.imgURL,
  });
}

List<ChatMessage> messages = [
  ChatMessage(
    messageContent: "Hello, Will",
    messageType: "receiver",
    imgURL: "assets/images/profile.png",
  ),
  ChatMessage(
      messageContent: "How have you been?",
      messageType: "receiver",
      imgURL: "assets/images/profile.png"),
  ChatMessage(
    messageContent: "Hey Kriss, I am doing fine dude. wbu?",
    imgURL: "assets/images/profile2.png",
    messageType: "sender",
  ),
  ChatMessage(
    messageContent:
        " dlklka dklalkdlk alkdlk alkdlkd akdlklkd alkdlklka dkakllkd dlklka dlkalkdlklkd alkdlklkdkld alkdlklkd adlkd",
    messageType: "receiver",
    imgURL: "assets/images/profile.png",
  ),
  ChatMessage(
    messageContent: "Is there any thing wrong?",
    messageType: "sender",
    imgURL: "assets/images/profile2.png",
  ),
  ChatMessage(
    messageContent: "Hello, Will",
    messageType: "receiver",
    imgURL: "assets/images/profile.png",
  ),
  ChatMessage(
      messageContent: "How have you been?",
      messageType: "receiver",
      imgURL: "assets/images/profile.png"),
  ChatMessage(
    messageContent: "Hey Kriss, I am doing fine dude. wbu?",
    imgURL: "assets/images/profile2.png",
    messageType: "sender",
  ),
];
