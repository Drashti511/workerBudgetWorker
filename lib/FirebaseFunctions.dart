import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

import 'auth.dart';

class FirestoreServices{
  static saveUser(String name,lastname ,imgUrl , email , contact , age , gender, uid) async{
    await FirebaseFirestore.instance
        .collection('WorkerData')
        .doc(uid)
        .set({'email' : email , 'FirstName' : name , 'LastName' : lastname , 'imgUrl' : imgUrl ,'contact' : contact , 'age' : age , 'gender' : gender});
  }
}
class FirestoreServices2{
  static applyWork(String firstName ,lastName ,w_age , w_gender , w_contact , w_email , w_imgUrl , w_dropdownvalue , w_workName , w_workDBName , w_workImg,  brief , exp , datOfApp , status , uid) async {
    String id = w_email+randomAlphaNumeric(5);
    await FirebaseFirestore.instance
        .collection('WorkerApplication')
        .doc(id)
        .set({
            'firstName': firstName,
            'lastName': lastName,
            'Age': w_age,
            'gender': w_gender,
            'contact': w_contact,
            'email': w_email,
            'workerImage': w_imgUrl,
            'WorkType': w_dropdownvalue,
            'WorkerOpted': w_workName,
            'WorkDatabaseName': w_workDBName,
            'WorkImage': w_workImg,
            'Experience' : exp,
            'Brief' : brief,
            'ApplicationDate' : datOfApp,
            'uid' : id,
            'status' : status,
            'WorkerUID' : Auth.getUid()
        });
    }
}