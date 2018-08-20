import 'package:firebase_database/firebase_database.dart';

class User {
  String key ,user_name , profile_photo , user_id;


  User(this.user_name , this.profile_photo , this.user_id);

  User.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        user_name = snapshot.value["user_name"],
        profile_photo = snapshot.value["profile_photo"],
        user_id = snapshot.value['user_id'];

  
  User.fromMap(key , value)
      : key = key,
        user_name = value["user_name"],
        profile_photo = value["profile_photo"],
        user_id=value["user_id"];


  toJson() {
    return {
      "user_name": user_name,
      "profile_photo": profile_photo,
      "user_id" : user_id
    };
  }
}