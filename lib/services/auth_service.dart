import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _keyEmail = 'user_email';
  static const String _keyName = 'user_name';
  static const String _keyLoggedIn = 'is_logged_in';
  static const String _keyUserId = 'user_id';
  
  // تسجيل المستخدم
  Future<bool> registerUser(String email, String password, String name) async {
    final prefs = await SharedPreferences.getInstance();
    
    // التحقق من عدم وجود مستخدم مسجل بنفس البريد الإلكتروني
    String? existingUserEmail = prefs.getString('user_$email');
    if (existingUserEmail != null) {
      return false; // المستخدم موجود مسبقاً
    }
    
    // إنشاء معرف فريد للمستخدم
    String userId = DateTime.now().millisecondsSinceEpoch.toString();
    
    // حفظ معلومات المستخدم
    await prefs.setString('user_$email', password);
    await prefs.setString('name_$email', name);
    await prefs.setString('id_$email', userId);
    
    return true;
  }
  
  // تسجيل الدخول
  Future<bool> loginUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    
    String? storedPassword = prefs.getString('user_$email');
    if (storedPassword == password) {
      // حفظ معلومات تسجيل الدخول
      await prefs.setString(_keyEmail, email);
      await prefs.setString(_keyName, prefs.getString('name_$email') ?? '');
      await prefs.setString(_keyUserId, prefs.getString('id_$email') ?? '');
      await prefs.setBool(_keyLoggedIn, true);
      return true;
    }
    
    return false;
  }
  
  // التحقق من حالة تسجيل الدخول
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLoggedIn) ?? false;
  }
  
  // معلومات المستخدم المسجل
  Future<Map<String, String>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (await isLoggedIn()) {
      return {
        'email': prefs.getString(_keyEmail) ?? '',
        'name': prefs.getString(_keyName) ?? '',
        'userId': prefs.getString(_keyUserId) ?? '',
      };
    }
    return null;
  }
  
  // تسجيل الخروج
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyLoggedIn);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyName);
    await prefs.remove(_keyUserId);
  }
}