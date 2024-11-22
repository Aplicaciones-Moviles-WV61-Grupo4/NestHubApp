import 'package:nesthub/features/auth/data/remote/auth_service.dart';
import 'package:nesthub/features/auth/data/remote/user_request.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future<String> register(Map<String, String> userData) async {
    try {
      return await _authService.signUp(userData);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signIn(UserRequest userRequest) async {
    try {
      await _authService.signIn(userRequest);
    } catch (e) {
      rethrow;
    }
  }
}
