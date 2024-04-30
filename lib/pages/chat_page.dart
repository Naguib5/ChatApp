import 'package:chatapp/constants.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/widgets/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  static const String id = 'chat_page';
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  TextEditingController controller = TextEditingController();
  List<Message> messageList = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: messages.get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            print(snapshot.data!.docs[0]['message']);
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(klogo, height: 50),
                  const Text(
                    'Chat',
                    style: TextStyle(color: Colors.white),
                  )
                ]),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return ChatBuble(
                            message: messageList[index],
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          'message': data,
                        });
                        controller.clear();
                      },
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                          hintText: 'Send Message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          )),
                    ),
                  )
                ],
              ),
            );
          } else {
            return CircularProgressIndicator(
              color: kPrimaryColor,
            );
          }
        });
  }
}
