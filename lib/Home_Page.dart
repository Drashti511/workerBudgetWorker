import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:worker_budget_worker/Bookings.dart';
import 'package:worker_budget_worker/showSnacBar.dart';

import 'auth.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
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
          String email = userDocument['email'];
          String img = userDocument['imgUrl'];

          return Scaffold(
            backgroundColor : HexColor('#ffe6e6'),
            body: Center(
              child: ListView(
                shrinkWrap: true,
                reverse: true,
                children: [
                  Card(
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
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(20),
                        child: CircleAvatar(
                          backgroundColor: Colors.white60,
                          backgroundImage: NetworkImage(img),
                          radius: 60,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'Hi, $fname',
                          style: GoogleFonts.alata(
                            textStyle: Theme.of(context).textTheme.headlineMedium,
                            fontSize: 25,
                            color: HexColor('#0B4360'),
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ],),
                  ),

                  Container(
                    padding: const EdgeInsets.all(25),
                    child: Text(
                      "Your reviews : ",
                      style: GoogleFonts.alata(
                        fontSize: 20,
                        color: HexColor('#0B4360'),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                      child: SizedBox(
                        height: 700,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("Reviews").where("worker_email" , isEqualTo: email).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                            if (!snapshot.hasData) {
                              return Text("No Revies yet " ,
                                style: GoogleFonts.alata(
                                fontSize: 20,
                                color: HexColor('#0B4360'),
                                fontWeight: FontWeight.w600,
                              ),);
                            }
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Text("Loading");
                            }
                            return ListView(
                              shrinkWrap: true,
                              children: snapshot.data!.docs.map((DocumentSnapshot document){
                              Map<String, dynamic> db = document.data()! as Map<String, dynamic>;
                              String username = db['worker_name'];
                              return Card(
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
                                  ListTile(
                                    title: Text(
                                      username,
                                        style: GoogleFonts.alata(
                                          fontSize: 18,
                                          color: HexColor('#0B4360'),
                                          fontWeight: FontWeight.w600,
                                    ),),
                                    leading: CircleAvatar(
                                      backgroundColor: HexColor('#0B4360'),
                                      child: Text(
                                        username.substring(0 , 1).toUpperCase(),
                                        style: GoogleFonts.alata(color: Colors.white , fontSize: 28 , fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    subtitle: Text(
                                      db['comment'],
                                      style: GoogleFonts.alata(
                                        fontSize: 20,
                                        color: HexColor('#0B4360'),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(0),
                                      alignment: Alignment.bottomRight,
                                      child: TextButton.icon(
                                        onPressed: () {  },
                                        label: Text(
                                          db['rating'],
                                          style: GoogleFonts.alata(
                                            color: HexColor('#0B4360'),
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                        icon: Icon(Icons.star , color: HexColor('#0B4360')),
                                      )
                                  ),
                                ],),
                                );
                              }, ).toList() );
                            },
                          ),
                        )
                    ),
                  ].reversed.toList(),
                ),
              ),
            );
          },);
  }
}
