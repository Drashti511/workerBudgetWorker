import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:worker_budget_worker/FirebaseFunctions.dart';
import 'package:worker_budget_worker/showSnacBar.dart';
import  'package:intl/intl.dart';
import 'Approval.dart';

class ApplyWork2 extends StatelessWidget {

  final String firstName ,lastName ,w_age , w_gender , w_contact , w_email , w_imgUrl , w_dropdownvalue , w_workName , w_workDBName , w_workImg;
  final formKey = GlobalKey<FormState>();
  ApplyWork2({super.key, required this.firstName , required this.lastName , required this.w_contact , required this.w_email , required this.w_imgUrl , required this.w_dropdownvalue , required this.w_workName , required this.w_workDBName , required this.w_workImg, required this.w_gender, required this.w_age});
  String exp = "", brief = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : HexColor('#ffe6e6'),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          reverse: true,
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white60,
                    backgroundImage: NetworkImage(w_workImg),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  child: Text(
                    "Work chosen  : $w_dropdownvalue, $w_workName",
                    style: GoogleFonts.alata(
                      color: HexColor('#0B4360'),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Card(
                  color: HexColor('#ffe6e6'),
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 15,
                  margin: const EdgeInsets.all(30),
                  shadowColor: HexColor('#0B4360'),
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.all(25),
                      child: Text(
                        'Since how many years you have worked in this field ? *',
                        style: GoogleFonts.alata(
                          color: HexColor('#0B4360'),
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(25),
                      child: TextFormField(
                        style: GoogleFonts.alata(),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calendar_month_rounded, color: HexColor('#0B4360'),),
                          labelText: "1/2/5 years",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Please fill out this field";
                          }
                          else{
                            return null;
                          }
                        },
                        onSaved: (value){
                          exp = value!;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(25),
                      child: Text(
                        'Please give a brief description about your skills in this work field *',
                        style: GoogleFonts.alata(
                          color: HexColor('#0B4360'),
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(25),
                      child: TextFormField(
                        style: GoogleFonts.alata(),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.abc_sharp, color: HexColor('#0B4360'),),
                          labelText: "Brief yourself",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                          maxLines: 10,
                          minLines: 2,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Please fill out this field";
                          }
                          else{
                            return null;
                          }
                        },
                        onSaved: (value){
                          brief = value!;
                        },
                      ),
                    ),
                    Container(
                      height: 90.0,
                      width: 200.0,
                      padding: const EdgeInsets.all(25),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(shape: const StadiumBorder(), backgroundColor: HexColor('0B4360')),
                        onPressed: () async {
                          if(formKey.currentState!.validate()){
                            formKey.currentState!.save();
                            String datOfApp = DateFormat("MMMM, dd, yyyy").format(DateTime.now());
                            String status = 'Waiting for approval';
                            String WorkerUID = "";
                            FirestoreServices2.applyWork(firstName, lastName, w_age, w_gender, w_contact, w_email, w_imgUrl, w_dropdownvalue, w_workName, w_workDBName, w_workImg , brief , exp , datOfApp , status , WorkerUID);
                            showSnacBar(context, "Thankyou for applying !");
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Approval()));
                          }
                          else{
                            showSnacBar(context, "Error");
                          }
                        },
                        child: Text(
                          "Apply",
                          style: GoogleFonts.alata(),
                        ),
                      ),
                    ),
                  ],),
                ),
              ],),
            ),
          ],
        ),
      ),
    );
  }
}
