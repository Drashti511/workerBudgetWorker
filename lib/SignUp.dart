
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:worker_budget_worker/showSnacBar.dart';


import 'LoginScreen.dart';
import 'auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  String email = "" , password = "" , firstname = "" , contact = "" , lastname = "" , imgUrl = "" , age = "";
  File? image ;
  final ImagePicker picker = ImagePicker();
  String gender = 'Male';

  // List of items in our dropdown menu
  var items = [
    'Male',
    'Female',
    'Other'
  ];
  Future getImage() async{
    final XFile? xf = await picker.pickImage(source: ImageSource.gallery);
    final File imagefile = File(xf!.path);
    setState(() {
      image = imagefile;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                'We are delighted to have you join our team, and we look forward to working with you !',
                style: GoogleFonts.alata(
                  textStyle: Theme.of(context).textTheme.headlineMedium,
                  fontSize: 20,
                  color: HexColor('#0B4360'),
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
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
              child: Form(
                  key: formKey,
                  child : Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: InkWell(
                        onTap: () => getImage(),
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.white60,
                          backgroundImage: image != null ? FileImage(image!) : const AssetImage("assets/images/addUser.png") as ImageProvider,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        // focusNode: myFocusNode,
                          style: GoogleFonts.alata(),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_add_alt_1_outlined, color: HexColor('#0B4360'),),
                            labelText: "Enter First Name",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)){
                              //allow upper and lower case alphabets and space
                              return "Enter Correct Name";
                            }else{
                              return null;
                            }
                          },
                        onSaved: (value){
                          setState(() {
                            firstname = value!;
                          });
                        },

                        // controller: controller,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        // focusNode: myFocusNode,
                        style: GoogleFonts.alata(),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_add_alt_1_outlined, color: HexColor('#0B4360'),),
                          labelText: "Enter Last Name",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)){
                            //allow upper and lower case alphabets and space
                            return "Enter Correct Name";
                          }else{
                            return null;
                          }
                        },
                        onSaved: (value){
                          setState(() {
                            lastname = value!;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.alata(),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email_rounded , color: HexColor('#0B4360'),),
                          labelText: "Enter Email Id",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
                            return "Enter Correct Email Address";
                          }else{
                            return null;
                          }
                        },
                        onSaved: (value){
                          setState(() {
                            email = value!;
                          });
                        },
                        // controller: controller2,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        // focusNode: myFocusNode,
                        style: GoogleFonts.alata(),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone, color: HexColor('#0B4360'),),
                          labelText: "Enter Contact Number",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty || !RegExp(r'^(?:[+0][1-9])?[0-9]{10}$').hasMatch(value)){
                            return "Enter Correct Phone Number";
                          }else{
                            return null;
                          }
                        },
                        onSaved: (value){
                          setState(() {
                            contact = value!;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        style: GoogleFonts.alata(),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.numbers, color: HexColor('#0B4360'),),
                          labelText: "Enter Age",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        validator: (value){
                          var str2 = '18';
                          var res = value?.compareTo(str2);
                          if(value!.isEmpty){
                            return "Please fill out this field";
                          }
                          else if(res! < 0){
                           return "You are not eligible as a worker";
                          }
                          else{
                            return null;
                          }
                        },
                        onSaved: (value){
                          setState(() {
                            age = value!;
                          });
                        },
                        // controller: controller,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child:  DropdownButton(
                          value: gender,
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
                              gender = newVal!;
                            });
                          }
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        obscureText: true,
                        style: GoogleFonts.alata(),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password , color: HexColor('#0B4360'),),
                          labelText: "Set a Password",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onSaved: (value){
                          setState(() {
                            password = value!;
                          });
                        },
                        // controller: controller3,
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
                            var storageImg = FirebaseStorage.instance.ref().child("Worker"+email + image!.path);
                            UploadTask task = storageImg.putFile(image!);
                            imgUrl = await (await task).ref.getDownloadURL();
                            Auth.signupUser(email, password, firstname , lastname, imgUrl.toString() , contact , age , gender ,context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                          }
                          else{
                            showSnacBar(context, "Error");
                          }
                        },
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.alata(),
                        ),
                      ),
                    ),
                  ],)
                ),
              ),
            Container(
              padding: const EdgeInsets.all(1),
              child: const Divider(
                color: Colors.grey,
                height: 1,
                thickness: 1,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(1),
              child: TextButton(
                onPressed: () {
                  setState((){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  });
                },
                child: Text(
                  "Already have an account ? Login",
                  style: GoogleFonts.alata(
                    color: HexColor('#0B4360'),
                  ),
                ),
              ),
            ),
          ].reversed.toList(),
        ),
      ),
    );
  }
}
