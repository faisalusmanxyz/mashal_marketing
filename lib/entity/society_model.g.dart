// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'society_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocietyModel _$SocietyModelFromJson(Map<String, dynamic> json) => SocietyModel(
      plotSize: json['plotSize'] as String,
      nomineeRelationship: json['nomineeRelationship'] as String,
      typeNomineeCnic: json['typeNomineeCnic'] as String,
      nomineeType: json['nomineeType'] as String,
      nomineeCnic: json['nomineeCnic'] as String,
      nomineeName: json['nomineeName'] as String,
      cnicApplicant: json['cnicApplicant'] as String,
      emailApplicant: json['emailApplicant'] as String,
      mailingAddressApplicant: json['mailingAddressApplicant'] as String,
      mobileApplicant: json['mobileApplicant'] as String,
      nameApplicant: json['nameApplicant'] as String,
      permanentAddressApplicant: json['permanentAddressApplicant'] as String,
      phoneApplicant: json['phoneApplicant'] as String,
      resApplicant: json['resApplicant'] as String,
      typeApplicant: json['typeApplicant'] as String,
      typeApplicantCnic: json['typeApplicantCnic'] as String,
      societyName: (json['societyName'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      uid: json['uid'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$SocietyModelToJson(SocietyModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nameApplicant': instance.nameApplicant,
      'cnicApplicant': instance.cnicApplicant,
      'typeApplicant': instance.typeApplicant,
      'typeApplicantCnic': instance.typeApplicantCnic,
      'mailingAddressApplicant': instance.mailingAddressApplicant,
      'permanentAddressApplicant': instance.permanentAddressApplicant,
      'emailApplicant': instance.emailApplicant,
      'phoneApplicant': instance.phoneApplicant,
      'resApplicant': instance.resApplicant,
      'mobileApplicant': instance.mobileApplicant,
      'nomineeName': instance.nomineeName,
      'nomineeCnic': instance.nomineeCnic,
      'nomineeType': instance.nomineeType,
      'typeNomineeCnic': instance.typeNomineeCnic,
      'nomineeRelationship': instance.nomineeRelationship,
      'plotSize': instance.plotSize,
      'societyName': instance.societyName,
      'date': instance.date,
    };
