import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService{
  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      print('exception->$e');
    }
  }

  Future<dynamic> signOutGoogle() async{
    try{
      await FirebaseAuth.instance.signOut();
      return true;
    }
    catch(e){
      print(e.toString());
    }
  }

  Future<dynamic> setUserInformation(
    {
      required String name,
      required String email,
      required String phone_number,
      required String photo_URL,
      }) async{
    try{
      CollectionReference ref= FirebaseFirestore.instance.collection('users');
      await ref.doc(email).set({'name':name,'email':email,'phone_number':phone_number,'photo_URL':photo_URL});
      return true;
    }
    catch(e)
    {
      print(e.toString());
    }
  }

  Future<dynamic> getUserInformation({required String email}) async{
    try{
      CollectionReference ref= FirebaseFirestore.instance.collection('users');
      final user_data =await ref.doc(email).get();
      var userData= user_data.data();
      return userData;
    }catch(e){
      print(e.toString());
    }
  }
}