import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';

import 'common.dart';
import 'displaySocietyForm_screen.dart';
import 'entity/society_model.dart';

List<String> society = [
  "Blue world City",
  "Capital Smart City Islamabad",
  "Faisal Town Islamabad"
];

class EditSocietyForm extends StatefulWidget {
  final DocumentSnapshot editForm;

  const EditSocietyForm({Key? key, required this.editForm}) : super(key: key);

  @override
  State<EditSocietyForm> createState() => _EditSocietyFormState();
}

class _EditSocietyFormState extends State<EditSocietyForm> {
  //late DocumentSnapshot editFormData;
  bool isShowProgressIndicator = false;
  GlobalKey<FormState> formKey = GlobalKey();
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<String> selectSociety = [];
  TextEditingController nameApplicantController = TextEditingController();
  TextEditingController personalCnicApplicantController =
      TextEditingController();

  TextEditingController personalCnicSoController = TextEditingController();

  TextEditingController personalMallingAddressController =
      TextEditingController();
  TextEditingController personalParmanentAddressController =
      TextEditingController();
  TextEditingController personalEmailController = TextEditingController();
  TextEditingController personalPhoneController = TextEditingController();
  TextEditingController personalResController = TextEditingController();
  TextEditingController personalMobileController = TextEditingController();

  TextEditingController nomineeNameController = TextEditingController();
  TextEditingController nomineeCnicController = TextEditingController();
  TextEditingController nomineeSoController = TextEditingController();
  TextEditingController nomineeCnicSoController = TextEditingController();
  TextEditingController nomineeRelationshipController = TextEditingController();
  TextEditingController plotAreaController = TextEditingController();
  String personalGroupValue = "S/O";
  String nomineeGroupValue = "S/O";
  bool progressIndicator = true;
  late var names;
  late DocumentSnapshot editFormData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isShowProgressIndicator
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: ProgressHUD(
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
                                          'Name Applicant must be at least 3  character long'),
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
                                        "Malling Address field is Required"),
                                controller: personalMallingAddressController,
                                decoration: textFieldDecoration(
                                    label: "Malling Address ")),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                validator: RequiredValidator(
                                    errorText:
                                        "permanent Address field is Required"),
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
                                SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                      itemCount: names.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            Checkbox(
                                                value: names[index]
                                                    [society[index]],
                                                onChanged: (val) {
                                                  names[index][society[index]] =
                                                      val;
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
                                      formValidate(context);
                                    },
                                    child: const Text("Submit"))),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    editFormData = widget.editForm;
    societyName();
    assignValueFromTextField();
  }

  void societyName() {
    print(editFormData['SocietyName'].length);
    names = List<Map<String, dynamic>>.generate(society.length, (i) {
      return {"name": society[i], society[i]: false};
    });
    for (var b = 0; b < editFormData['SocietyName'].length; b++) {
      for (var c = 0; c < society.length; c++) {
        if (editFormData['SocietyName'][b] == society[c]) {
          names[c][society[c]] = true;
        }
      }
    }
  }

  void assignValueFromTextField() {
    nameApplicantController.text = editFormData['nameApplicant'].toString();
    personalCnicApplicantController.text =
        editFormData['cnicApplicant'].toString();
    personalCnicSoController.text =
        editFormData['typeApplicantCnic'].toString();
    personalMallingAddressController.text =
        editFormData['mailingAddressApplicant'].toString();
    personalParmanentAddressController.text =
        editFormData['permanentAddressApplicant'].toString();
    personalEmailController.text = editFormData['emailApplicant'].toString();
    personalPhoneController.text = editFormData['phoneApplicant'].toString();
    personalResController.text = editFormData['resApplicant'].toString();
    personalMobileController.text = editFormData['mobileApplicant'].toString();
    nomineeNameController.text = editFormData['nomineeName'].toString();
    nomineeCnicController.text = editFormData['nomineeCnic'].toString();
    nomineeGroupValue = editFormData['nomineeType'].toString();
    nomineeCnicSoController.text = editFormData['typeNomineeCnic'].toString();
    nomineeRelationshipController.text =
        editFormData['nomineeRelationship'].toString();
    plotAreaController.text = editFormData['plotSize'].toString();
    personalGroupValue = editFormData['typeApplicant'];

  }

  Future<void> formValidate(context) async {
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
        mailingAddressApplicant: personalMallingAddressController.text.trim(),
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
        uid: FirebaseAuth.instance.currentUser!.uid.toString(),
        date: currentDate);

    societyForm.uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      clearTextField();

      Map<String, dynamic> map = societyForm.toJson();
      setState(() {
        isShowProgressIndicator = true;
      });
      await FirebaseFirestore.instance
          .collection("societyForm")
          .doc(editFormData.reference.id)
          .set(map);
      DocumentSnapshot updateSnapshot = await FirebaseFirestore.instance
          .collection("societyForm")
          .doc(editFormData.reference.id)
          .get();
      setState(() {
        isShowProgressIndicator = false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Form successfully updated'),
        ));
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShowSocietyForm(
                    showForm: updateSnapshot,
                  )));
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.code.toString()),
      ));
    }
    print("ok");
  }

  void clearTextField() {
    nameApplicantController.clear();
    personalCnicApplicantController.clear();
    personalCnicSoController.clear();
    personalMallingAddressController.clear();
    personalParmanentAddressController.clear();
    personalEmailController.clear();
    personalPhoneController.clear();
    personalResController.clear();
    personalMobileController.clear();
    nomineeNameController.clear();
    nomineeCnicController.clear();
    nomineeSoController.clear();
    nomineeCnicSoController.clear();
    nomineeRelationshipController.clear();
    plotAreaController.clear();
  }
}
