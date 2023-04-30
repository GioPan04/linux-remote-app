import 'dart:convert';

class Message {
  final String target;
  final dynamic payload;

  const Message(this.target, [this.payload]);

  factory Message.fromJson(Map<String, dynamic> data) {
    return Message(data['target'], data['payload']);
  }

  factory Message.fromBytes(List<int> data) {
    final string = String.fromCharCodes(data).trim();
    return Message.fromJson(jsonDecode(string));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {'target': target};

    if (payload is MessagePayload) {
      json['payload'] = (payload as MessagePayload).toJson();
    } else {
      json['payload'] = payload;
    }

    return json;
  }

  List<int> toBytes() => utf8.encode('${jsonEncode(toJson())}\n');
}

abstract class MessagePayload {
  Map<String, dynamic>? toJson();
}
