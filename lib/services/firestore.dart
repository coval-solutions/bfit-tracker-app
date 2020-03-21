import 'package:bfit_tracker/models/user.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Firestore _firestore;
  String _uid;

  CollectionReference _userInfoCollection;

  FirestoreService(User user) {
    this._firestore = Firestore.instance;
    this._firestore.settings(timestampsInSnapshotsEnabled: true);

    this._uid = user.getUid();
    this._userInfoCollection = this._firestore.collection('UserInfo');
  }

  Stream<UserInfo> get userInfo {
    return this
        ._userInfoCollection
        .document(this._uid)
        .snapshots()
        .map(UserInfo().fromSnapshot);
  }
}
