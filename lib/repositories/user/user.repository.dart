import 'package:fb_test2/models/user/user.model.dart';

class UserRepository {
  UserRepository._();

  static final _instance = UserRepository._();
  static UserRepository get instance => _instance;

  Future<void> signUp(UserModel model) async {}

  Future<void> signIn(UserModel model) async {}

  Future<void> updateUser(UserModel model) async {}

  Future<void> signOut() async {}
}
