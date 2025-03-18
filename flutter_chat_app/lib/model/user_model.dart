import 'dart:core';

class UserModel{

  String? uid;
  String? name;
  num? mobile;
  String? email;
  String? profileImg;
  var timeStamp;

  UserModel({
    this.uid,
    this.name,
    this.mobile,
    this.email,
    this.profileImg,
    this.timeStamp
  });

  ///Data from server parsing
  factory UserModel.fromMap(Map map){
    return UserModel(
      uid: map['uid'],
      name:map['name'],
      mobile:map['mobile'],
      email:map['email'],
      profileImg:map['profileImg'],
      timeStamp:map['timeStamp'],

    );
  }

  ///Sending data to the server
  Map<String,dynamic> toMap(){
    return {
      'uid':uid,
      'name':name,
      'mobile':mobile,
      'email':email,
      'profileImg':profileImg,
      'timeStamp':timeStamp,
    };
  }

}