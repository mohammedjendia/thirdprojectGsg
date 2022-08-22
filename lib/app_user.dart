
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AppUser {

  String? id;
  String? password;
  String email ;
  String userName;
  String phone ;
  String city ;


  AppUser({
    this.id ,
    required this.userName ,
    this.password ,
    required this.email ,
    required this.phone ,
    required this.city ,

});

  Map<String , dynamic> toMap(){
    return{
      'email': email,
      'userName': userName,
      'phone': phone,
      'city': city,
    };
  }

factory AppUser.fromMap(Map<String , dynamic>map){
    return AppUser(
        email: map['email']??'',
        userName: map['userName']??'',
        phone: map['phone']??'',
        city: map['city']??'',
    );
}

String toJson()=>json.encode(toMap());
}