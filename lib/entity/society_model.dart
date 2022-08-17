import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'society_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SocietyModel {
    String uid="";
  final String nameApplicant;
  final String cnicApplicant;
  final String typeApplicant;
  final String typeApplicantCnic;
  final String mailingAddressApplicant;
  final String permanentAddressApplicant;
  final String emailApplicant;
  final String phoneApplicant;
  final String resApplicant;
  final String mobileApplicant;

// Nominee variable
  final String nomineeName;
  final String nomineeCnic;
  final String nomineeType;
  final String typeNomineeCnic;
  final String nomineeRelationship;

// plot size variable
  final String plotSize;
  final List<String> SocietyName;

  SocietyModel(
      {
        required this.plotSize,
      required this.nomineeRelationship,
      required this.typeNomineeCnic,
      required this.nomineeType,
      required this.nomineeCnic,
      required this.nomineeName,
      required this.cnicApplicant,
      required this.emailApplicant,
      required this.mailingAddressApplicant,
      required this.mobileApplicant,
      required this.nameApplicant,
      required this.permanentAddressApplicant,
      required this.phoneApplicant,
      required this.resApplicant,
      required this.typeApplicant,
      required this.typeApplicantCnic,
      required this.SocietyName, required String uid});

  factory SocietyModel.fromJson(Map<String, dynamic> json) =>
      _$SocityModelFromJson(json);

  Map<String, dynamic> toJson() => _$SocityModelToJson(this);


  static CollectionReference<SocietyModel> collection() {
    return FirebaseFirestore.instance.collection('societyForm').withConverter<SocietyModel>(
        fromFirestore: (snapshot, _) => SocietyModel.fromJson(snapshot.data()!),
        toFirestore: (callCenter, _) => callCenter.toJson());
  }

}