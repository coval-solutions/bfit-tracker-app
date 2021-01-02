import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  static const SCOPES = [
    "https://www.googleapis.com/auth/documents.readonly",
  ];

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn(scopes: SCOPES);

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  GoogleSignInAccount getGoogleUser() {
    return _googleSignIn.currentUser;
  }

  User getUser() {
    return _firebaseAuth.currentUser;
  }

  Future<String> getAccessToken() async {
    GoogleSignInAccount googleSignInAccount = this.getGoogleUser();
    if (googleSignInAccount == null) {
      await GoogleSignIn(scopes: SCOPES).signIn();
      this.getAccessToken();
    }

    GoogleSignInAuthentication googleSignInAuthentication =
        await getGoogleUser().authentication;

    return googleSignInAuthentication.accessToken;
  }

  static Future<String> getIdToken() async {
    return await FirebaseAuth.instance.currentUser.getIdToken();
  }
}
