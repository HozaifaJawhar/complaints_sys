import 'package:complaints_sys/features/auth/domain/entities/auth_result.dart';

class AuthResultModel extends AuthResult {
  const AuthResultModel({required String token}) : super(token: token);

  factory AuthResultModel.fromJson(Map<String, dynamic> json) {
    // 1. محاولة قراءة التوكن من استجابة (Login)
    String? token = json['data']?['token'];

    // 2. إذا لم يوجد (null)، قم بقراءته من استجابة (VerifyOtp)
    token ??= json['token'];

    return AuthResultModel(
      token: token ?? '', // إرجاع التوكن أو سلسلة فارغة إذا فشل كلاهما
    );
  }
}
