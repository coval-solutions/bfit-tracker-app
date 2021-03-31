import 'package:bfit_tracker/controllers/user_controller.dart';
import 'package:bfit_tracker/models/coval_user.dart';
import 'package:bfit_tracker/models/user_info.dart' as Coval;
import 'package:bfit_tracker/routes.dart';
import 'package:bfit_tracker/views/onboarding/onboarding_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  Rx<User> _user = Rx<User>();

  @override
  Future<void> onInit() async {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
    await this.signInWithGoogle();
  }

  User getUser() {
    return _user.value;
  }

  Future<void> signInWithGoogle() async {
    bool isSignedIn = await _googleSignIn.isSignedIn();
    GoogleSignInAccount googleSignInAccount;
    if (!isSignedIn) {
      googleSignInAccount = await _googleSignIn.signIn();
    } else {
      googleSignInAccount = await _googleSignIn.signInSilently();
    }

    final GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    _auth.signInWithCredential(credential);
    this._loadCovalUser();

    UserController userController = Get.find<UserController>();
    if (userController?.user?.userInfo == null) {
      // Cache some SVGs
      OnboardingScreenState.images.forEach((element) async {
        await precachePicture(SvgPicture.asset(element).pictureProvider, null);
      });

      OnboardingScreenState.background.forEach((element) async {
        await precachePicture(SvgPicture.asset(element).pictureProvider, null);
      });

      Get.offAllNamed(Routes.ONBOARDING);
    } else {
      Get.offAllNamed(Routes.HOME);
    }

    return;
  }

  Future<void> _loadCovalUser() async {
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

    FirebaseCrashlytics.instance.setUserIdentifier(user.uid);
    FirebaseAnalytics().setUserId(user.uid);

    return;
  }

  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);

    Get.find<UserController>().clear();

    FirebaseCrashlytics.instance.setUserIdentifier(null);
    FirebaseAnalytics().setUserId(null);

    return;
  }
}
