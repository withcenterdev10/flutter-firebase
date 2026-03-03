import 'package:fb_test2/models/user/user.model.dart';
import 'package:fb_test2/repositories/user/user.repository.dart';

class UserService {
  UserService._();

  static final _instance = UserService._();
  static UserService get instance => _instance;

  final UserRepository _repository = UserRepository.instance;

  Future<void> signIn(String email, String password) async {
    final model = UserModel(email: email, password: password);
    await _repository.signIn(model);
  }

  Future<void> signUp(String email, String password) async {
    final model = UserModel(email: email, password: password);
    await _repository.signUp(model);
  }

  Future<void> updateUser({
    required String name,
    required String nickname,
  }) async {
    final model = UserModel(name: name, nickname: nickname);
    await _repository.updateUser(model);
  }

  Future<void> signOut() async {
    await _repository.signOut();
  }
}
