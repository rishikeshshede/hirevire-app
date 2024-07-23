import 'package:flutter/material.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/user_interface/presentation/chat/components/chat_card.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: false,
        title: Text(
          'Messages',
          style: AppTextThemes.subtitleStyle(context),
        ),
      ),
      body: const Column(
        children: [
          ChatCard(),
          ChatCard(),
          ChatCard(),
        ],
      ),
    );
  }
}
