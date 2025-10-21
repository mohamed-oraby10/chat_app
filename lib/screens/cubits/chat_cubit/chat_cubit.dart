import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollection,
  );
        List<Message> messageList = [];
  void sendMessage({required String message, required String id}) {
    messages.add({kMessage: message, kCreatedAt: DateTime.now(), 'id': id});
  }

  void getMessage() {
    messages.orderBy(kCreatedAt).snapshots().listen((event) {
      for (var doc in event.docs) {
        messageList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messages: messageList));
    });
  }
}
