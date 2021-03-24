import 'package:bfit_tracker/controllers/user_controller.dart';
import 'package:bfit_tracker/models/coval_user.dart';
import 'package:bfit_tracker/models/user_info.dart' as Coval;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  Rx<User> _user = Rx<User>();

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
  }

  User getUser() {
    return _user.value;
  }

  void signInWithGoogle() async {
    if (this.getUser() != null) {
      return;
    }

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _auth.signInWithCredential(credential);

    UserController userController = Get.find<UserController>();
    User user = this.getUser();
    userController.user = CovalUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      displayPicture: CovalUser.getImageFromUrl(user.photoURL),
    );

    Coval.UserInfo userInfo = await userController.userInfoRepository
        .retrieve(userController.user)
        .first;

    userController.user.setUserInfo(userInfo);

    return;
  }

  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);

    Get.find<UserController>().clear();

    return;
  }
}
