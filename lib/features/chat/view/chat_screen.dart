import 'package:alsewar/features/chat/view/chat_body.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({super.key, this.isOther=false, this.index=-1, });
  final bool? isOther;
  final int index;
  @override
  Widget build(BuildContext context) {
    return ChatBody(isOther: isOther!,index: index,);
  }
}
