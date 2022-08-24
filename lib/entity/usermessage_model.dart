import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'usermessage_model.g.dart';
@JsonSerializable(explicitToJson: true)
class UserMessageModel{
  final String date;
  final String userName;
  final String uid;
  final String message;
  final Map<String,dynamic> packageInfo;
  final Map<String,dynamic> deviceInfo;
  UserMessageModel({required this.date,required this.userName,required this.uid,required this.message,required this.packageInfo,required this.deviceInfo});

  factory UserMessageModel.fromJson(Map<String, dynamic> json) =>
      _$UserMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserMessageModelToJson(this);


  static CollectionReference<UserMessageModel> collection() {
    return FirebaseFirestore.instance.collection('userMessage').withConverter<UserMessageModel>(
        fromFirestore: (snapshot, _) => UserMessageModel.fromJson(snapshot.data()!),
        toFirestore: (callCenter, _) => callCenter.toJson());
  }
}