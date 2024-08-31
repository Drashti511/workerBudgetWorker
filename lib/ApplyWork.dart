import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:worker_budget_worker/auth.dart';
import 'package:worker_budget_worker/showSnacBar.dart';

import 'ApplyWork2.dart';
import 'LoginScreen.dart';

class ApplyWork extends StatefulWidget {
  const ApplyWork({Key? key}) : super(key: key);

  @override
  State<ApplyWork> createState() => _ApplyWorkState();
}

class _ApplyWorkState extends State<ApplyWork> {

  final formKey = GlobalKey<FormState>();
  String dropdownvalue = 'Cleaning';

  // List of items in our dropdown menu
  var items = [
    'Cleaning',
    'ApplianceRepair',
    'QuickHomeRepair',
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('WorkerData').doc(Auth.getUid()).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData || !snapshot.data.exists) {
            return const Text("No data ");
          }
        var userDocument = snapshot.data!.data();
        String fname = userDocument["FirstName"];
        String lname = userDocument["LastName"];
        String contact = userDocument["contact"];
        String email = userDocument["email"];
        String age = userDocument["age"];
        String gender = userDocument["gender"];
        String imgUrl = userDocument["imgUrl"];

    return Scaffold(
      backgroundColor : HexColor('#ffe6e6'),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          reverse: true,
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(children:  [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(imgUrl),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Name : ""$fname $lname",
                    // focusNode: myFocusNode,
                    style: GoogleFonts.alata(
                      color: HexColor('#0B4360'),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Age : $age",
                    // focusNode: myFocusNode,
                    style: GoogleFonts.alata(
                      color: HexColor('#0B4360'),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Gender : $gender",
                    // focusNode: myFocusNode,
                    style: GoogleFonts.alata(
                      color: HexColor('#0B4360'),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Contact : $contact",
                    // focusNode: myFocusNode,
                    style: GoogleFonts.alata(
                      color: HexColor('#0B4360'),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Email : $email",
                    // focusNode: myFocusNode,
                    style: GoogleFonts.alata(
                      color: HexColor('#0B4360'),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Choose for the work options ',
                        style: GoogleFonts.alata(
                          color: HexColor('#0B4360'),
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                         ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child:  DropdownButton(
                          value: dropdownvalue,
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items ,
                                style: GoogleFonts.alata(
                                  color: HexColor('#0B4360'),
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          }).toList(),
                          dropdownColor: HexColor('#ffe6e6'),
                          onChanged: (String? newVal){
                            setState(() {
                              dropdownvalue = newVal!;
                            });
                          }
                      ),
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection(dropdownvalue).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Text("Loading");
                        }
                        return ListView(
                          shrinkWrap: true,
                            children : snapshot.data!.docs.map((DocumentSnapshot document){
                              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                            return ListTile(
                              title: Text(data['title'],
                                style: GoogleFonts.alata(
                                color: HexColor('#0B4360'),
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                ),
                              ),
                              leading: CircleAvatar(backgroundImage: NetworkImage(data['image']),backgroundColor: Colors.white60,),
                              onTap: (){
                                String workName = data['title'];
                                String workDBName = data['dbName'];
                                String workImg = data['image'];
                                Navigator.push(context , MaterialPageRoute(builder: (context) => ApplyWork2(
                                    firstName : fname , lastName : lname ,w_age : age , w_gender: gender,  w_contact : contact , w_email : email , w_imgUrl : imgUrl , w_dropdownvalue : dropdownvalue , w_workName : workName ,w_workDBName : workDBName ,w_workImg : workImg
                                  ),
                                ));
                              },
                            );
                          },).toList() );
                        },
                      ),
                    ],
                  ),
                ),
              ],),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
              child: const Text(
                'Sign out',
              ),
            )
          ].reversed.toList(),
        ),
      ),
    );});
  }
}
