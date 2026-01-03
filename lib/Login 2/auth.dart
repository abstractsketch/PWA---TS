import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

///these functions
///1- for checking if the user is already logged into the app using google sign in
///2- for authenticating user using google sign in with firebase Authenticatation API
///3- Retrieves some general user realted information from their Google account for ease of the login process

final GoogleSignIn _googleSignIn = GoogleSignIn();
String? userEmail;
String? imageUrl;

Future<User?> signInwithGoogle() async {
  await Firebase.initializeApp();
  
  User? user;

  if (kIsWeb) {
    //The googleauthprovider can only be used while running on the web
    GoogleAuthProvider authProvider = GoogleAuthProvider();

    try {
      final UserCredential userCredential =
      await _auth.signInWithPopup(authProvider);

      user = userCredential.user;
    } catch (e) {
      print(e);
    }
  } else {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

        user = userCredential.user;


      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print('The account already exists with a different credential.');
        } else if (e.code == 'invalid-credential') {
          print('Error occurred while accessing credentials. Try again.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  if (user != null) {
    uid= user.uid;
    name = user.displayName;
    userEmail = user.email;
    imageUrl = user.photoURL;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', true);
  }

  return user;

}

//In the above implementation, the signInwithGoogle method will only work on the web
//as the GoogleAuthProvider class is only accessible while running on the web
//In order to use Google authentication from your Flutter web app, you will have to enable it in the Firebase Authentication settings

///For sign out of their Google account
void signOutGoogle() async {
  await _googleSignIn.signOut();
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);
  
  uid = null;
  name = null;
  userEmail = null;
  imageUrl = null;

  print("User Signed Out");
}

//Create an instance of FirebaseAuth and add a few more variables:
final FirebaseAuth _auth = FirebaseAuth.instance;

String? uid;
String? name;

//Authenticating using email and password 

// We will define a new function called register WithEmailPassword that will handle the whole process of regrating a new user
//This function will contain two parameters email and password

Future<User?> registerWithEmailPassword(String email, String password) async {
  await Firebase.initializeApp(); 
  User? user;


//to register a new user
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    user = userCredential.user;
    if (user != null) {
      uid = user.uid;
      name = user.email;
    }

    //Instead of using a single catch for handling any type of error, it is recommended to handle the Firebase authentification exception seperately

  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }

  return user;
}

//After a user is registered, they can log in using the email and password they provided during registration
//I can use the method signinwithemail provided by firebaseauth to authenticate the login process
//We will define another functioncalled signinwithemailpassword for handling the login

Future<User?> signInWithEmailPassword(String email, String password) async {
  await Firebase.initializeApp();

  User? user;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    user = userCredential.user;

    if (user != null) {
      uid = user.uid;
      userEmail = user.email;

      //Shared Preferences is used for caching the login status. This will be helpful while we set up auto login in our web app
      //Even here we have handled some Firebase authntification exceptions that may occur while a user is trying to log in 

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('auth', true);
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }

  return user;
}

//irgendwas stimmt hier nicht login durch chat laufen lassen oder mitch koko

//handy function for signing out of an account 
Future<String> signOut() async {
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;
  userEmail = null;

  return "User Signed Out";
}

//In order to prevent users from logging in every time they come back to your web app you can cache their login state 
//rretrieve the users information if they have logged in previously
Future getUser() async {
  await Firebase.initializeApp();
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? authSignedIn = prefs.getBool('auth') ?? false;

  final User? user = _auth.currentUser;

  if (authSignedIn == true) {
    if (user != null) {
      uid = user.uid;
      name = user.displayName;
      userEmail = user.email;
      imageUrl = user.photoURL;

      return true;
    } else {
      return false;
    }
  }
}