import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'common.dart';
import 'editSocietyForm_screen.dart';

class ShowSocietyForm extends StatefulWidget {
  final DocumentSnapshot showForm;

  ShowSocietyForm({Key? key, required this.showForm}) : super(key: key);

  @override
  State<ShowSocietyForm> createState() => _ShowSocietyFormState();
}

class _ShowSocietyFormState extends State<ShowSocietyForm> {
  late DocumentSnapshot edit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    edit = widget.showForm;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 0.04 * height, left: 0.03 * width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "PERSONAL INFORMATION",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                // SizedBox(
                //   height: 0.02 * height,
                // ),
                Text(
                  "Name of Applicant: ${edit['nameApplicant']}",
                  style: editSocietyForm,
                ),
                SizedBox(
                  height: 0.02 * height,
                ),
                Text("CNIC of Applicant: ${edit['cnicApplicant']}",
                    style: editSocietyForm),
                SizedBox(
                  height: 0.02 * height,
                ),
                Text("Type of Applicant: ${edit['typeApplicant']}",
                    style: editSocietyForm),
                SizedBox(
                  height: 0.02 * height,
                ),
                Text(
                    "${edit['typeApplicant']} Cnic: ${edit['typeApplicantCnic']}",
                    style: editSocietyForm),
                SizedBox(
                  height: 0.02 * height,
                ),
                Text("Malling Address: ${edit['mailingAddressApplicant']}",
                    style: editSocietyForm),
                SizedBox(
                  height: 0.02 * height,
                ),
                Text("Permanent Address: ${edit['permanentAddressApplicant']}",
                    style: editSocietyForm),
                SizedBox(
                  height: 0.02 * height,
                ),
                Text("Email: ${edit['emailApplicant']}",
                    style: editSocietyForm),
                SizedBox(
                  height: 0.02 * height,
                ),
                Text("Phone No: ${edit['phoneApplicant']}",
                    style: editSocietyForm),
                SizedBox(
                  height: 0.02 * height,
                ),
                Text("Res: ${edit['resApplicant']}", style: editSocietyForm),
                SizedBox(
                  height: 0.02 * height,
                ),
                Text("Mobile: ${edit['mobileApplicant']}",
                    style: editSocietyForm),
                SizedBox(
                  height: 0.02 * height,
                ),
                const Text("NOMINEE INFORMATION",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Divider(),
                // SizedBox(
                //   height: 0.02 * height,
                // ),
                Text("Nominee Name: ${edit['nomineeName']}",
                    style: editSocietyForm),
                SizedBox(
                  height: 0.02 * height,
                ),
                Text("Nominee CNIC: ${edit['nomineeCnic']}",
                    style: editSocietyForm),
                SizedBox(
                  height: 0.02 * height,
                ),
                Text("Nominee Type: ${edit['nomineeType']}",
                    style: editSocietyForm),
                SizedBox(
                  height: 0.02 * height,
                ),
                Text("${edit['nomineeType']} Cnic: ${edit['typeNomineeCnic']}",
                    style: editSocietyForm),
                SizedBox(
                  height: 0.02 * height,
                ),
                Text(
                    "Relationship with Applicant: ${edit['nomineeRelationship']}",
                    style: editSocietyForm),
                SizedBox(
                  height: 0.02 * height,
                ),
                Text("Area (Marla): ${edit['plotSize']}",
                    style: editSocietyForm),
                SizedBox(
                  height: 0.02 * height,
                ),
                //  Text(edit['SocietyName'].length.toString()),
                const Text("Society Name",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Divider(),
                // SizedBox(
                //   height: 0.02 * height,
                // ),
                Container(
                  width: width,
                  height: 30.0 * edit['SocietyName'].length,
                  child: ListView.builder(
                      itemCount: edit['SocietyName'].length,
                      itemBuilder: (context, index) {
                        return Text(
                          edit['SocietyName'][index].toString(),
                          style: editSocietyForm,
                        );
                      }),
                ),
                SizedBox(
                  height: 0.02 * height,
                ),
                Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: () {
                          print(edit.runtimeType);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditSocietyForm(
                                        editForm: edit,
                                      )));
                        },
                        child: const Text("Edit"))),
                SizedBox(
                  height: 0.05 * height,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
