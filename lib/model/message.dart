import 'package:firebase_database/firebase_database.dart';

class Message {
  String key, text, user_id;
  DateTime time_created;

  Message(this.key ,this.user_id, this.text) {
    time_created = DateTime.now();
  }

  Message.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        user_id = snapshot.value["user_id"],
        text = snapshot.value["text"],
        time_created = DateTime.parse(snapshot.value["time_created"]);

  String getTimeCreated() {
    int newMessageHour = time_created.hour;
    int newMessageMinute = time_created.minute;
    String hour = newMessageHour.toString().length == 2
        ? newMessageHour.toString()
        : ' ' + newMessageHour.toString();
    String minute = newMessageMinute.toString().length == 2
        ? newMessageMinute.toString()
        : ' ' + newMessageMinute.toString();

    return hour + '.' + minute;
  }

  toJson() {
    return {
      "user_id": this.user_id,
      "text": this.text,
      "time_created": time_created.toIso8601String()
    };
  }
}
