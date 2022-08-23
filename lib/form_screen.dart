import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:marshall_marketing/entity/society_model.dart';
import 'package:marshall_marketing/signIn_screen.dart';

import 'common.dart';

List<String> society = [
  "Blue world City",
  "Capital Smart City Islamabad",
  "Faisal Town Islamabad"
];

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  bool isShowProgressIndicator = false;
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final names = List<Map<String, dynamic>>.generate(
      society.length, (i) => {"name": society[i], society[i]: false});
  List<String> selectSociety = [];

  bool secondValue = false;
  bool thirdValue = false;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameApplicantController = TextEditingController();
  TextEditingController personalCnicApplicantController =
      TextEditingController();

  TextEditingController personalCnicSoController = TextEditingController();

  TextEditingController personalMalingAddressController =
      TextEditingController();
  TextEditingController personalParmanentAddressController =
      TextEditingController();
  TextEditingController personalEmailController = TextEditingController();
  TextEditingController personalPhoneController = TextEditingController();
  TextEditingController personalResController = TextEditingController();
  TextEditingController personalMobileController = TextEditingController();

  TextEditingController nomineeNameController = TextEditingController();
  TextEditingController nomineeCnicController = TextEditingController();
 // TextEditingController nomineeSoController = TextEditingController();
  TextEditingController nomineeCnicSoController = TextEditingController();
  TextEditingController nomineeRelationshipController = TextEditingController();
  TextEditingController plotAreaController = TextEditingController();
  String personalGroupValue = "S/O";
  String nomineeGroupValue = "S/O";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isShowProgressIndicator
          ? const Center(child: CircularProgressIndicator())
          : ProgressHUD(
              child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Form(
                      key: formKey,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "PERSONAL INFORMATION",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText:
                                          'Name Applicant field is required'),
                                  MinLengthValidator(3,
                                      errorText:
                                          'Name Applicant must be at least 3 charecter long'),
                                ]),
                                controller: nameApplicantController,
                                decoration: textFieldDecoration(
                                    label: "Name of Applicant")),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: RequiredValidator(
                                  errorText:
                                      "CNIC Applicant field is Required"),
                              controller: personalCnicApplicantController,
                              keyboardType: TextInputType.number,
                              decoration: textFieldDecoration(
                                  label: "CNIC of Applicant"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(children: [
                              Row(
                                children: [
                                  const Text("S/O"),
                                  Radio(
                                      value: "S/O",
                                      groupValue: personalGroupValue,
                                      onChanged: (value) {
                                        setState(() {
                                          personalGroupValue = value.toString();
                                        });
                                      }),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("D/O"),
                                  Radio(
                                      value: "D/O",
                                      groupValue: personalGroupValue,
                                      onChanged: (value) {
                                        setState(() {
                                          personalGroupValue = value.toString();
                                        });
                                      })
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("W/O"),
                                  Radio(
                                      value: "W/O",
                                      groupValue: personalGroupValue,
                                      onChanged: (value) {
                                        setState(() {
                                          personalGroupValue = value.toString();
                                        });
                                      })
                                ],
                              ),
                            ]),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                controller: personalCnicSoController,
                                keyboardType: TextInputType.number,
                                decoration: textFieldDecoration(
                                    label: "CNIC of S/O, D/O, W/O ")),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                validator: RequiredValidator(
                                    errorText:
                                        "Maling Address field is Required"),
                                controller: personalMalingAddressController,
                                decoration: textFieldDecoration(
                                    label: "Maling Address ")),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                validator: RequiredValidator(
                                    errorText:
                                        "parmanent Address field is Required"),
                                controller: personalParmanentAddressController,
                                decoration: textFieldDecoration(
                                    label: "Permanent Address ")),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: MultiValidator([
                                EmailValidator(errorText: "Invalid Email"),
                                RequiredValidator(
                                    errorText: "Email field is Required"),
                              ]),
                              controller: personalEmailController,
                              decoration: textFieldDecoration(label: "Email"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: RequiredValidator(
                                  errorText: "Phone field is Required"),
                              controller: personalPhoneController,
                              decoration:
                                  textFieldDecoration(label: "Phone No"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: RequiredValidator(
                                  errorText: "Res field is Required"),
                              controller: personalResController,
                              decoration: textFieldDecoration(label: "Res"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: RequiredValidator(
                                  errorText: "Mobile field is Required"),
                              controller: personalMobileController,
                              decoration: textFieldDecoration(label: "Mobile"),
                            ),
                            ExpansionTile(
                              tilePadding: const EdgeInsets.only(right: 10),
                              title: const Text(
                                "CHOSE SOCIETY",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              children: [
                                Container(
                                  height: 150,
                                  child: ListView.builder(
                                      itemCount: names.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            Checkbox(
                                                value: names[index]
                                                    [society[index]],
                                                onChanged: (valu) {
                                                  names[index][society[index]] =
                                                      valu;
                                                  setState(() {});
                                                }),
                                            Text(names[index]['name']),
                                          ],
                                        );
                                      }),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("NOMINEE INFORMATION",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              validator: RequiredValidator(
                                  errorText: "Nominee Name field is Required"),
                              controller: nomineeNameController,
                              decoration:
                                  textFieldDecoration(label: "Nominee Name"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: RequiredValidator(
                                  errorText: "Nominee CNIC field if Required"),
                              controller: nomineeCnicController,
                              decoration:
                                  textFieldDecoration(label: "Nominee CNIC"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // TextFormField(
                            //   controller: nomineeSoController,
                            //   decoration:
                            //       textFieldDecoration(label: "S/O, D/O, W/O"),
                            // ),
                            Row(children: [
                              Row(
                                children: [
                                  const Text("S/O"),
                                  Radio(
                                      value: "S/O",
                                      groupValue: nomineeGroupValue,
                                      onChanged: (value) {
                                        setState(() {
                                          nomineeGroupValue = value.toString();
                                        });
                                      }),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("D/O"),
                                  Radio(
                                      value: "D/O",
                                      groupValue: nomineeGroupValue,
                                      onChanged: (value) {
                                        setState(() {
                                          nomineeGroupValue = value.toString();
                                        });
                                      })
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("W/O"),
                                  Radio(
                                      value: "W/O",
                                      groupValue: nomineeGroupValue,
                                      onChanged: (value) {
                                        setState(() {
                                          nomineeGroupValue = value.toString();
                                        });
                                      })
                                ],
                              ),
                            ]),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: nomineeCnicSoController,
                              decoration: textFieldDecoration(
                                  label: "CNIC of S/O, D/O, W/O"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: RequiredValidator(
                                  errorText:
                                      "Relationship with Applicant field is Required"),
                              controller: nomineeRelationshipController,
                              decoration: textFieldDecoration(
                                  label: "Relationship with Applicant "),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Plot Size",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                                validator: RequiredValidator(
                                    errorText:
                                        "Area (Marla) field is Required"),
                                controller: plotAreaController,
                                decoration:
                                    textFieldDecoration(label: "Area (Marla)")),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      formValidate();
                                    },
                                    child: const Text("Submit"))),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ),
    );
  }

  Future<void> formValidate() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    selectSociety.clear();
    for (var i = 0; i < names.length; i++) {
      if (names[i][society[i]] == true) {
        selectSociety.add(names[i]['name']);
      }
    }
    SocietyModel societyForm = SocietyModel(
        nameApplicant: nameApplicantController.text.trim(),
        cnicApplicant: personalCnicApplicantController.text.trim(),
        typeApplicant: personalGroupValue,
        typeApplicantCnic: personalCnicSoController.text.trim(),
        mailingAddressApplicant: personalMalingAddressController.text.trim(),
        permanentAddressApplicant:
            personalParmanentAddressController.text.trim(),
        emailApplicant: personalEmailController.text.trim(),
        phoneApplicant: personalPhoneController.text.trim(),
        resApplicant: personalResController.text.trim(),
        mobileApplicant: personalMobileController.text.trim(),
        nomineeName: nomineeNameController.text.trim(),
        nomineeCnic: nomineeCnicController.text.trim(),
        nomineeType: nomineeGroupValue,
        typeNomineeCnic: nomineeCnicSoController.text.trim(),
        nomineeRelationship: nomineeRelationshipController.text.trim(),
        plotSize: plotAreaController.text.trim(),
        societyName: selectSociety,
        uid: "",
        date: currentDate);

    try {
clearTextField();
      //FirebaseFirestore.instance.collection("societyForm").add(map);
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SignInScreen(
                      societyModelObj: societyForm,
                    )));
        return;
      }

      societyForm.uid = FirebaseAuth.instance.currentUser!.uid;

      setState(() {
        isShowProgressIndicator = true;
      });
      await SocietyModel.collection().add(societyForm);
      setState(() {
        isShowProgressIndicator = false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Form successfully stored'),
        ));
      });
    } on FirebaseException catch (e) {
      print(e.code.toString());
    }
    print("ok");
  }

  void clearTextField(){
    nameApplicantController.clear();
    personalCnicApplicantController.clear();
    personalCnicSoController.clear();
    personalMalingAddressController.clear();
    personalParmanentAddressController.clear();
    personalEmailController.clear();
    personalPhoneController.clear();
    personalResController.clear();
    personalMobileController.clear();
    nomineeNameController.clear();
    nomineeCnicController.clear();
   // nomineeSoController.clear();
    nomineeCnicSoController.clear();
    nomineeRelationshipController.clear();
    plotAreaController.clear();
  }


  void selected() {
    selectSociety.clear();
    for (var i = 0; i < names.length; i++) {
      if (names[i][society[i]] == true) {
        selectSociety.add(names[i]['name']);
      }
    }
    print(selectSociety);
  }
}
