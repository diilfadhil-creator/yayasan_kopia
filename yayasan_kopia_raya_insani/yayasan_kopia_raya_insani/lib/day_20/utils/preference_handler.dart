import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHandler {
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserName = 'user_name';
  static const String _keyUserPhone = 'user_phone';
  static const String _keyProfilePhoto = 'user_profile_photo';
  static const String _keyNotifDonation = 'notif_donation';
  static const String _keyNotifNews = 'notif_news';

  static Future<void> saveUserSession({
    required String email,
    required String name,
    String? phone,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyUserEmail, email);
    await prefs.setString(_keyUserName, name);
    if (phone != null) {
      await prefs.setString(_keyUserPhone, phone);
    }
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  static Future<String> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserEmail) ?? 'sahabat@kopia.or.id';
  }

  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName) ?? 'Sahabat Kopia';
  }

  static Future<String> getUserPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserPhone) ?? '081234567890';
  }

  static Future<void> updateUserProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserName, name);
    await prefs.setString(_keyUserEmail, email);
    await prefs.setString(_keyUserPhone, phone);
  }

  static Future<void> saveProfilePhoto(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyProfilePhoto, path);
  }

  static Future<String?> getProfilePhoto() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyProfilePhoto);
  }

  static Future<void> setNotificationPref({
    bool? donationNotif,
    bool? newsNotif,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    if (donationNotif != null) {
      await prefs.setBool(_keyNotifDonation, donationNotif);
    }
    if (newsNotif != null) {
      await prefs.setBool(_keyNotifNews, newsNotif);
    }
  }

  static Future<Map<String, bool>> getNotificationPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'donation': prefs.getBool(_keyNotifDonation) ?? true,
      'news': prefs.getBool(_keyNotifNews) ?? true,
    };
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsLoggedIn);
    await prefs.remove(_keyUserEmail);
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyUserPhone);
    await prefs.remove(_keyProfilePhoto);
    await prefs.remove(_keyNotifDonation);
    await prefs.remove(_keyNotifNews);
  }
}

