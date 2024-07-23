import "package:get/get.dart";

class ChatController extends GetxController {
  RxList<Map<String, dynamic>> chats = <Map<String, dynamic>>[
    {
      "id": "1",
      "profilePicUrl":
          "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "name": "Padama Parikh",
      "content": "Did you checkout my resume I uploaded sent yesterday?",
      "type": "TEXT",
      "unseenCound": 2,
      "senderId": "user1",
      "receiverId": "rec1",
      "time": "2024-07-12T04:11:04.874+00:00",
    },
    {
      "id": "2",
      "profilePicUrl":
          "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "name": "Devendra Banik",
      "content": "When?",
      "type": "TEXT",
      "unseenCound": 2,
      "senderId": "rec2",
      "receiverId": "user1",
      "time": "2024-07-12T04:11:04.874+00:00",
    },
    {
      "id": "3",
      "profilePicUrl":
          "https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1760&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "name": "Tushar Dewan",
      "content": "Will do it at the earliest.",
      "type": "TEXT",
      "unseenCound": 0,
      "senderId": "user1",
      "receiverId": "rec2",
      "time": "2024-07-12T04:11:04.874+00:00",
    }
  ].obs;
}
