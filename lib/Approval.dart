import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:worker_budget_worker/showSnacBar.dart';

import 'auth.dart';

class Approval extends StatefulWidget {
  const Approval({Key? key}) : super(key: key);

  @override
  State<Approval> createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('WorkerData').doc(Auth.getUid()).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData || !snapshot.data.exists) {
          return const Text("No data ");
        }
        var userDocument = snapshot.data!.data();
        String email = userDocument["email"];
    return Scaffold(
      backgroundColor : HexColor('#ffe6e6'),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          reverse: true,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(30),
              child: Text(
                'Your Applications',
                style: GoogleFonts.alata(
                  textStyle: Theme.of(context).textTheme.headlineMedium,
                  fontSize: 22,
                  color: HexColor('#0B4360'),
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Expanded(
                child: SizedBox(
                  height: 700,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("WorkerApplication").where("email" , isEqualTo: email).snapshots(),
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
                            if(data['status'] == 'Approved'){
                              return AlertDialog(
                                backgroundColor: HexColor('#ffe6e6'),
                                title: Text('Approval message' ,
                                  style: GoogleFonts.alata(
                                    color: HexColor('#0B4360'),
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      Text(
                                        'Congratulations , your application was approved' ,
                                         style: GoogleFonts.alata(
                                           color: HexColor('#0B4360'),
                                           fontStyle: FontStyle.normal,
                                                // fontWeight: FontWeight.bold,
                                           fontSize: 15,
                                              ),
                                        ),
                                      Text(
                                        '\nYour profile will now get displayed in '+data['WorkType']+" "+data['WorkerOpted'] ,
                                        style: GoogleFonts.alata(
                                          color: HexColor('#0B4360'),
                                          fontStyle: FontStyle.normal,
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK' ,
                                      style: GoogleFonts.alata(
                                      color: HexColor('#0B4360'),
                                      fontStyle: FontStyle.normal,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),),
                                    onPressed: () {
                                      FirebaseFirestore.instance.collection('WorkerApplication').doc(data['uid']).delete();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            }
                            if(data['status'] == 'Disapproved'){
                              return AlertDialog(
                                backgroundColor: HexColor('#ffe6e6'),
                                title: Text('Disapproval message' ,
                                  style: GoogleFonts.alata(
                                    color: HexColor('#0B4360'),
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      Text(
                                        'Sorry , your application was not approved' ,
                                        style: GoogleFonts.alata(
                                          color: HexColor('#0B4360'),
                                          fontStyle: FontStyle.normal,
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK' ,
                                      style: GoogleFonts.alata(
                                        color: HexColor('#0B4360'),
                                        fontStyle: FontStyle.normal,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),),
                                    onPressed: () {
                                      FirebaseFirestore.instance.collection('WorkerApplication').doc(data['uid']).delete();
                                      Navigator.of(context).pop();

                                    },
                                  ),
                                ],
                              );
                            }
                            if(data['status'] == 'Waiting for approval'){
                              return Container(
                                padding: const EdgeInsets.all(10),
                                child: Card(
                                  color: HexColor('#ffe6e6'),
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  elevation: 8,
                                  margin: const EdgeInsets.all(10),
                                  shadowColor: HexColor('#0B4360'),
                                  child: Column(children: [
                                  Container(
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.topRight,
                                  child: Card(
                                    color: HexColor('#ffe6e6'),
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    elevation: 8,
                                    margin: const EdgeInsets.all(10),
                                    shadowColor: HexColor('#0B4360'),
                                    child: TextButton.icon(
                                      onPressed: () {
                                        showSnacBar(context, "Your application is still in waiting state once approved status will get updated.");
                                      },
                                      label: Text(
                                        data['status'],
                                        style: GoogleFonts.alata(
                                          color: HexColor('#0B4360'),
                                          fontStyle: FontStyle.normal,
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      icon: Icon(Icons.timelapse_sharp , color: HexColor('#0B4360')),
                                    ),
                                  ),
                                ), Container(
                                      padding: const EdgeInsets.all(20),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Application for : '+'\n\n'+data['WorkType']+", "+data['WorkerOpted'],
                                        style: GoogleFonts.alata(
                                          color: HexColor('#0B4360'),
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.bottomLeft,
                                      child: IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance.collection('WorkerApplication').doc(data['uid']).delete();
                                        },
                                        icon: Icon(Icons.delete_outlined ,  color: HexColor('#0B4360')),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        'Date : '+data['ApplicationDate'],
                                        style: GoogleFonts.alata(
                                          color: HexColor('#0B4360'),
                                          fontStyle: FontStyle.normal,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],),
                                ),
                              );
                            }
                            return Container(
                              padding: const EdgeInsets.all(10),
                              child: Card(
                                color: HexColor('#ffe6e6'),
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                elevation: 8,
                                margin: const EdgeInsets.all(10),
                                shadowColor: HexColor('#0B4360'),
                                child: Column(children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Application for : '+'\n\n'+data['WorkType']+", "+data['WorkerOpted'],
                                      style: GoogleFonts.alata(
                                        color: HexColor('#0B4360'),
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.bottomLeft,
                                    child: IconButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance.collection('WorkerApplication').doc(data['id']).delete();
                                      },
                                      icon: Icon(Icons.delete_outlined ,  color: HexColor('#0B4360')),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      'Date : '+data['ApplicationDate'],
                                      style: GoogleFonts.alata(
                                        color: HexColor('#0B4360'),
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],),
                              ),
                            );
                          },).toList() );
                        },
                    ),
                  ),
              ),
            ].reversed.toList(),
          ),
        ),
      );});
    }

  }

