// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermessage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMessageModel _$UserMessageModelFromJson(Map<String, dynamic> json) =>
    UserMessageModel(
      date: json['date'] as String,
      userName: json['userName'] as String,
      uid: json['uid'] as String,
      message: json['message'] as String,
      packageInfo: json['packageInfo'] as Map<String, dynamic>,
      deviceInfo: json['deviceInfo'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$UserMessageModelToJson(UserMessageModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'userName': instance.userName,
      'uid': instance.uid,
      'message': instance.message,
      'packageInfo': instance.packageInfo,
      'deviceInfo': instance.deviceInfo,
    };
