import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:worker_budget_worker/showSnacBar.dart';

import 'auth.dart';
class Bookings extends StatefulWidget {
  const Bookings({Key? key}) : super(key: key);

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {

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

        return Scaffold(
          backgroundColor : HexColor('#ffe6e6'),
          body: Center(
            child: ListView(
              shrinkWrap: true,
              reverse: true,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Your Works',
                    style: GoogleFonts.alata(
                      textStyle: Theme.of(context).textTheme.headlineMedium,
                      fontSize: 25,
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
                      stream: FirebaseFirestore.instance.collection("Booking").where("Worker_email" , isEqualTo: email).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Text("Loading");
                        }
                        return ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((DocumentSnapshot document){
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                            String bid = data['bookingId'];
                            if(data['Work_sts'] == 'Not Started'){
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
                                      data['UserFname'] + " "+data['UserLname']+", is requesting for \n",
                                      style: GoogleFonts.alata(
                                        color: HexColor('#0B4360'),
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    subtitle: Text(
                                      data['Work'] + 'on '+data['booking_date']+' '+data['booking_time'] + " at "+data['User_flat']+" "+data['User_Landmark']+" "+data['User_state'],
                                      style: GoogleFonts.alata(
                                        color: HexColor('#0B4360'),
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    alignment: Alignment.bottomRight,
                                    child: TextButton.icon(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context){
                                              return AlertDialog(
                                                backgroundColor: HexColor('#ffe6e6'),
                                                title: Text('To start work' ,
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
                                                        'This option will start your work and when completed the user will change the status that assigned work was completed ' ,
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
                                                actions: [
                                                  TextButton(
                                                    onPressed: (){
                                                      FirebaseFirestore.instance.collection('Booking').doc(bid).update({'Work_sts': 'Started'});
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text(
                                                      'OK',
                                                      style: GoogleFonts.alata(
                                                        color: HexColor('#0B4360'),
                                                        fontStyle: FontStyle.normal,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                            }
                                        );

                                      } ,
                                      icon: Icon(Icons.start , color: HexColor('#0B4360')),
                                      label: Text(
                                        'Start',
                                        style: GoogleFonts.alata(
                                          color: HexColor('#0B4360'),
                                          fontStyle: FontStyle.normal,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        data['Work_sts'],
                                        style: GoogleFonts.alata(
                                          color: HexColor('#0B4360'),
                                          fontStyle: FontStyle.normal,
                                          fontSize: 15,
                                        ),
                                      )
                                  ),
                                ],),
                              );
                            }
                            if(data['Work_sts'] == 'Completed'){
                              return AlertDialog(
                                backgroundColor: HexColor('#ffe6e6'),
                                title: Text('Payment Done message' ,
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
                                        'Has the payment done by the customer done ?' ,
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
                                    child: Text('Yes' ,
                                      style: GoogleFonts.alata(
                                        color: HexColor('#0B4360'),
                                        fontStyle: FontStyle.normal,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),),
                                    onPressed: () {
                                      FirebaseFirestore.instance.collection('Booking').doc(bid).update({'Payment_sts': 'Done'});
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('No' ,
                                      style: GoogleFonts.alata(
                                        color: HexColor('#0B4360'),
                                        fontStyle: FontStyle.normal,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),),
                                    onPressed: () {
                                      FirebaseFirestore.instance.collection('Booking').doc(bid).update({'Payment_sts': 'Incomplete'});
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            }
                            return Container(

                            );
                          },).toList() );
                      },),
                  ),
                ),
              ].reversed.toList(),
            ),
          ),
        );
      },);
  }
}
