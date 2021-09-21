import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

User? user = FirebaseAuth.instance.currentUser;

// // a simple sialog to be visible everytime some error occurs
// showErrDialog(BuildContext context, String err) {
//   // to hide the keyboard, if it is still p
//   FocusScope.of(context).requestFocus(new FocusNode());
//   return showDialog(
//     context: context,
//     child: AlertDialog(
//       title: Text("Error"),
//       content: Text(err),
//       actions: <Widget>[
//         OutlineButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text("Ok"),
//         ),
//       ],
//     ),
//   );
// }

// many unhandled google error exist
// will push them soon
// Future<bool?> googleSignIn() async {
//   print("clicked");
//   try {
//     final GoogleSignInAccount? googleSignInAccount =
//         await _googleSignIn.signIn();
//     // print("googleSignInAccount" + googleSignInAccount.toString());
//     final GoogleSignInAuthentication googleSignInAuthentication =
//         await googleSignInAccount!.authentication;
//     // print("GOOGLESIGNINAUTHENTICATION" + googleSignInAuthentication.toString());
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleSignInAuthentication.accessToken,
//       idToken: googleSignInAuthentication.idToken,
//     );
//     print("CREDENTIALS " + credential.token.toString());
//     await _auth.signInWithCredential(credential);
//   } on FirebaseAuthException catch (e) {
//     print("ERROR" + e.message.toString());
//     throw e;
//   }
// }

Future<User?> signInWithGoogle() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

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
          await auth.signInWithCredential(credential);

      user = userCredential.user;
      // print("LOGIN SUCCESS " + userCredential.user.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        print("ERROR: ACCOUNT ALREADY EXISTS");
        // handle the error here
      } else if (e.code == 'invalid-credential') {
        print("ERROR: INVALID CREDENTIALS");
        // handle the error here
      }
    } catch (e) {
      print("ERROR: TRY AGAIN");
      // handle the error here
    }
  }

  return user;
}

// instead of returning true or false
// returning user to directly access UserID
// Future<User> signin(String email, String password) async {
//   try {
//     // print("Email and Password" + email + "-" + password);
//     UserCredential userCredential = await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password);
//     print("LOGIN ATTEMPT SUCCESS " + userCredential.user.toString());
//     return Future.value(userCredential.user);
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'user-not-found') {
//       print('No user found for that email.');
//     } else if (e.code == 'wrong-password') {
//       print('Wrong password provided for that user.');
//     }
//     print("LOGIN ATTEMPT FAILURE");
//     return Future.value(null);
//   }
// }

// // change to Future<FirebaseUser> for returning a user
// Future<User> signUp(String email, String password) async {
//   try {
//     UserCredential userCredential = await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email, password: password);
//     print("SIGNUP ATTEMPT SUCCESS " + userCredential.user.toString());
//     return Future.value(userCredential.user);
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       print('The password provided is too weak.');
//     } else if (e.code == 'email-already-in-use') {
//       print('The account already exists for that email.');
//     }
//     print("SIGNUP ATTEMPT FAILURE");
//     return Future.value(null);
//   }
// }

Future<User> signin(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print("SIGN IN SUCCESS" + userCredential.user.toString());
    return Future.value(userCredential.user);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
    print("user sign in failed");
    return Future.value(null);
  }
}

// sign out
Future<bool> signOutUser() async {
  print("CURRENTLY LOGGED IN USER " +
      FirebaseAuth.instance.currentUser.toString());
  await FirebaseAuth.instance.signOut();
  print("SIGNED OUT SUCCESSFULLY");
  return Future.value(true);
  // print("Sign out called");
  // User? user = FirebaseAuth.instance.currentUser;
  // print("CURRENT USER" + user.toString());
  // print("provider id " + user!.providerData[1].providerId);
  // if (user.providerData[1].providerId == 'google.com') {
  //   await _googleSignIn.disconnect();
  //   print("signed out");
  // }
  // await _auth.signOut();
  // await FirebaseAuth.instance.signOut();
  // return Future.value(true);
}
