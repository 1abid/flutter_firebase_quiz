import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Future<FirebaseUser> get user => _firebaseAuth.currentUser();

  Stream<FirebaseUser> get _userState => _firebaseAuth.onAuthStateChanged;

  Future<FirebaseUser> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication signInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: signInAuthentication.idToken,
        accessToken: signInAuthentication.accessToken,
      );

      AuthResult authResult =
          await _firebaseAuth.signInWithCredential(credential);
      updateUserData(authResult.user);

      return authResult.user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<FirebaseUser> anonymousSignIn() async{
    AuthResult authResult = await _firebaseAuth.signInAnonymously();

    updateUserData(authResult.user);

    return authResult.user;
  }

  Future<void> updateUserData(FirebaseUser user) {
    DocumentReference reportRef = _db.collection('reports').document(user.uid);

    return reportRef.setData(
      {
        'uid': user.uid,
        'lastActivity': DateTime.now(),
      },
      merge: true,
    );
  }

  Future<void> signOut(){
    return _firebaseAuth.signOut();
  }
}
