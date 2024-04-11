import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_coffe_app/model/user.dart';
import 'package:flutter_coffe_app/services/database.dart';


class AuthServices {
  var firebaseAuth = FirebaseAuth.instance;
  UserModel? userFromFirebase(User? user) {

    return user!=null? UserModel(uid: user.uid, name: user.displayName!, email: user.email!): null;
  } 
  Stream<UserModel?>  get user {
    return firebaseAuth.authStateChanges()
    //.map((User? user) => userFromFirebase(user));
    .map(userFromFirebase);
  }

  Future signInAnonymous() async {
    try {
     
      UserCredential userCredential = await firebaseAuth.signInAnonymously();
      User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      await DatabaseService(id: user!.uid).addUserData("0", "anonim", 100);
      return userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
       await firebaseAuth.signOut();
    } catch (e) {
      print(e);
      
    }finally {
      print("cıkıldı");
    }
  }


  
}