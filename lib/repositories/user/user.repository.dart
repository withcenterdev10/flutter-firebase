import 'package:fb_test2/models/user/user.model.dart';
import 'package:fb_test2/utils/database/database.util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserRepository {
  UserRepository._();

  static final _instance = UserRepository._();
  static UserRepository get instance => _instance;

  Future<void> signUp(UserModel model) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: model.email!,
      password: model.password!,
    );
  }

  Future<void> signIn(UserModel model) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: model.email!,
      password: model.password!,
    );
  }

  Future<void> updateUser(UserModel model) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseDatabase.instance.ref(Lists.members.name).child(uid).update({
      "name": model.name!,
      "nickname": model.nickname!,
    });
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
