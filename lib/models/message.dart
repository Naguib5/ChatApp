import 'package:chatapp/constants.dart';

class Message {
  final String message;
  final String id;
  Message(this.id, this.message);

  factory Message.fromJson(jsonData) {
    return Message(
      jsonData[kId],
      jsonData[kMessage],
    );
  }
}
