import 'package:get/get.dart';
import 'package:hirevire_app/user_interface/presentation/chat/controllers/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController(), tag: 'chatController');
  }
}
