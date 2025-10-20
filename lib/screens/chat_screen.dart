import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/screens/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});
  static String id = 'ChatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollection,
  );

  final scrollController = ScrollController();

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments ;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kMainColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/11539827.png",
                    height: 70,
                    color: Colors.white,
                  ),

                  Text(
                    "Chat",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email ? ChatBubble(message: messagesList[index])
                      : ChatBubbleFriend(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        kMessage: data,
                        kCreatedAt: DateTime.now(),
                        'id' : email
                      });
                      controller.clear();
                      scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: Duration(seconds: 1),
                        curve: Curves.easeOut,
                      );
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.send, color: kMainColor),
                      hintText: "send message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: kMainColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text("Loading...");
        }
      },
    );
  }
}
