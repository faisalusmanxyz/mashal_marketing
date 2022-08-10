import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
//import 'package:marshall_marketing/society_form_model.dart';
import 'package:marshall_marketing/society_model.dart';
import 'commen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
List<String> soiety=["Blue world City","Capital Smart City Islamabad","Faisal Town Islamabad"];
class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();

}

class _FormScreenState extends State<FormScreen> {
  final names=List<Map<String,dynamic>>.generate(soiety.length, (i)=>{"name":soiety[i],soiety[i]:false});
  List<String>  select_soiety=[];
  void salected(){
    select_soiety.clear();
    for(var i=0; i<names.length;i++){
      if(names[i][soiety[i]]==true){
      select_soiety.add( names[i]['name']);


      }
    }
  print(select_soiety);
  }
  bool secondvalue=false;
  bool therdvalue=false;
 // List<String> soiety=["Blue world City","Capital Smart City Islamabad","Capital Smart City Islamabad"];
  GlobalKey<FormState> formkey=GlobalKey();
  TextEditingController name_applicant_controller=TextEditingController();
  TextEditingController personal_cnic_applicant_controller=TextEditingController();
  //TextEditingController personal_so_controller=TextEditingController();
  TextEditingController personal_cnic_so_controller=TextEditingController();

  TextEditingController personal_maling_address_controller=TextEditingController();
  TextEditingController personal_parmanent_address_controller=TextEditingController();
  TextEditingController personal_email_controller=TextEditingController();
  TextEditingController personal_phone_controller=TextEditingController();
  TextEditingController personal_res_controller=TextEditingController();
  TextEditingController personal_mobile_controller=TextEditingController();
// Nominee information controller
  TextEditingController nominee_name_controller=TextEditingController();
  TextEditingController nominee_cnic_controller=TextEditingController();
  TextEditingController nominee_so_controller=TextEditingController();
  TextEditingController nominee_cnic_so_controller=TextEditingController();
  TextEditingController nominee_relationship_controller=TextEditingController();
  TextEditingController plot_area_controller=TextEditingController();
  String personal_group_value="S/O";

  void formValidate(){
if(formkey.currentState!.validate()){
  select_soiety.clear();
  for(var i=0; i<names.length;i++){
    if(names[i][soiety[i]]==true){
      select_soiety.add( names[i]['name']);
    }
  }
  SocityModel society_form=SocityModel(nameApplicant: name_applicant_controller.text.trim(),
      cnicApplicant: personal_cnic_applicant_controller.text.trim(),
      typeApplicant: personal_group_value,
      typeApplicantCnic: personal_cnic_so_controller.text.trim(),
      mailingAddressApplicant:personal_maling_address_controller.text.trim(),
      permanentAddressApplicant:personal_parmanent_address_controller.text.trim(),
      emailApplicant:personal_email_controller.text.trim(),
      phoneApplicant:personal_phone_controller.text.trim(),
      resApplicant:personal_res_controller.text.trim(),
      mobileApplicant:personal_mobile_controller.text.trim(),
      nomineeName:nominee_name_controller.text.trim(),
      nomineeCnic:nominee_cnic_controller.text.trim(),
      nomineeType:nominee_so_controller.text.trim(),
      typeNomineeCnic:nominee_cnic_so_controller.text.trim(),
      nomineeRelationship:nominee_relationship_controller.text.trim(),
      plotSize:plot_area_controller.text.trim(), SocietyName: select_soiety
  );
  Map<String,dynamic> map=society_form.toJson();
  try {
    name_applicant_controller.clear();personal_cnic_applicant_controller.clear();
    personal_cnic_so_controller.clear();personal_maling_address_controller.clear();
    personal_parmanent_address_controller.clear();personal_email_controller.clear();
    personal_phone_controller.clear();personal_res_controller.clear();
    personal_mobile_controller.clear();nominee_name_controller.clear();
    nominee_cnic_controller.clear();nominee_so_controller.clear();
    nominee_cnic_so_controller.clear();nominee_relationship_controller.clear();
    plot_area_controller.clear();
    FirebaseFirestore.instance.collection("societyForm").add(map);
    ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
      content: Text('Form successfully stored'),));
  }catch(e){print(e.toString());}
  print("ok");
}else{print("no");}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Form(
            key: formkey,
            child: Center(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,

                children: [const Text("PERSONAL INFORMATION",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 15,),
              TextFormField(
                validator:MultiValidator([RequiredValidator(errorText: 'Name Applicant field is required'),
                  MinLengthValidator(3, errorText: 'Name Applicant must be at least 3 charecter long'),  ]),
                controller: name_applicant_controller,
                decoration: my_decoration(my_label: "Name of Applicant")
              ),
                  const SizedBox(height: 10,),
              TextFormField(
                validator: RequiredValidator(errorText: "CNIC Applicant field is Required"),
                controller: personal_cnic_applicant_controller,
                keyboardType: TextInputType.number,
                decoration: my_decoration(my_label: "CNIC of Applicant"),
              ),
                   SizedBox(height: 10,),
             Row(
                    children: [
                      Row(
                      children: [
                        Text("S/O"),
                        Radio(value: "S/O", groupValue: personal_group_value, onChanged: (value){
                          setState((){personal_group_value=value.toString();});
                        }
                        ),
                      ],
                    ),
                      Row(
                        children: [
                          Text("D/O"),Radio(value: "D/O", groupValue: personal_group_value, onChanged: (value){

                            setState((){ personal_group_value=value.toString();});
                          })
                        ],
                      ),
                      Row(
                        children: [
                          Text("W/O"),Radio(value: "W/O", groupValue: personal_group_value, onChanged: (value){

                            setState((){  personal_group_value=value.toString();

                            });
                          })
                        ],
                      ),
                      ]),

                  const SizedBox(height: 10,),
            TextFormField(
              controller: personal_cnic_so_controller,
              keyboardType: TextInputType.number,
              decoration:  my_decoration(my_label: "CNIC of S/O, D/O, W/O ")
            ),
                  const SizedBox(height: 10,),
            TextFormField(
              validator: RequiredValidator(errorText: "Maling Addres field is Required"),
              controller: personal_maling_address_controller,
              decoration: my_decoration(my_label: "Maling Addres ")
            ),
                  const SizedBox(height: 10,),
            TextFormField(
              validator: RequiredValidator(errorText: "Parmanent Address field is Required"),
              controller:personal_parmanent_address_controller,
              decoration:  my_decoration(my_label: "Parmanent Address ")
            ),
                  const SizedBox(height: 10,),
                  const SizedBox(height: 10,),
            TextFormField(
              validator: MultiValidator([
                EmailValidator(errorText: "Invalid Email"),
                RequiredValidator(errorText: "Email field is Required"),
              ]),
              controller: personal_email_controller,
              decoration: my_decoration(my_label:"Email"),
            ),
                  const SizedBox(height: 10,),
          TextFormField(
 validator: RequiredValidator(errorText: "Phone field is Required"),
            controller: personal_phone_controller,
             decoration: my_decoration(my_label: "Phone No"),

          ),
                  const SizedBox(height: 10,),
          TextFormField(
            validator: RequiredValidator(errorText: "Res field is Required"),
            controller:personal_res_controller,
            decoration: my_decoration(my_label: "Res"),

          ),
                  const SizedBox(height: 10,),
          TextFormField(
            validator:RequiredValidator(errorText: "Mobile field is Required"),
            controller:personal_mobile_controller,
            decoration:   my_decoration(my_label: "Mobile"),
          ),
                 ExpansionTile(tilePadding: EdgeInsets.only(right: 10),title: Text("CHOSE SOCIETY",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  children: [

                    Container(height: 150,
                      child: ListView.builder(itemCount: names.length,
                          itemBuilder: (context,index){
                            return  Row(
                              children:  [
                                Checkbox(value: names[index][soiety[index]], onChanged: (valu){
                                  names[index][soiety[index]]=valu;
                                  setState((){});
                                }),
                                Text(names[index]['name']),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
                  const SizedBox(height: 10,),

                  const SizedBox(height: 10,),
                  const Text("NOMINEE INFORMATION",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15,),
          TextFormField(
            validator: RequiredValidator(errorText: "Nominee Name field is Required"),
            controller:nominee_name_controller,
            decoration:   my_decoration(my_label: "Nominee Name"),
          ),
                  const SizedBox(height: 10,),
          TextFormField(
            validator: RequiredValidator(errorText: "Nominee CNIC field if Required"),
            controller:nominee_cnic_controller,
            decoration:  my_decoration(my_label: "Nominee CNIC"),
          ),
                  const SizedBox(height: 10,),
          TextFormField(

            controller:nominee_so_controller,
            decoration:   my_decoration(my_label: "S/O, D/O, W/O"),
          ),
                  const SizedBox(height: 10,),
          TextFormField(
            controller:nominee_cnic_so_controller,
            decoration:  my_decoration(my_label: "CNIC of S/O, D/O, W/O"),
          ),
                  const SizedBox(height: 10,),
                  const SizedBox(height: 10,),
          TextFormField(
            validator: RequiredValidator(errorText: "Relationship with Applicant field is Required"),
            controller: nominee_relationship_controller,
            decoration:  my_decoration(my_label: "Relationship with Applicant "),
          ),
                  const SizedBox(height: 10,),
                  const Text("Plot Size",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15,),
          TextFormField(
            validator: RequiredValidator(errorText: "Area (Marla) field is Required"),
            controller: plot_area_controller,
            decoration:  my_decoration(my_label: "Area (Marla)")
          ),
                  const SizedBox(height: 10,),


Center(child: ElevatedButton(onPressed: (){
  formValidate();
}, child: Text("Submit"))),
                  const SizedBox(height: 15,),
                ],
              ),
            ),
          )
        ),
      )
    );
  }
}
