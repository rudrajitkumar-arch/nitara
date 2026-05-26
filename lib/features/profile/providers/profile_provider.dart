import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  bool _waterRemindersEnabled = true;
  String _userName = '';
  String _doctorName = '';
  String _partnerName = '';

  bool get isDarkMode => _isDarkMode;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get waterRemindersEnabled => _waterRemindersEnabled;
  String get userName => _userName;
  String get doctorName => _doctorName;
  String get partnerName => _partnerName;

  ProfileProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('darkMode') ?? false;
    _notificationsEnabled = prefs.getBool('notifications') ?? true;
    _waterRemindersEnabled = prefs.getBool('waterReminders') ?? true;
    _userName = prefs.getString('userName') ?? '';
    _doctorName = prefs.getString('doctorName') ?? '';
    _partnerName = prefs.getString('partnerName') ?? '';
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _isDarkMode);
    notifyListeners();
  }

  Future<void> toggleNotifications() async {
    _notificationsEnabled = !_notificationsEnabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', _notificationsEnabled);
    notifyListeners();
  }

  Future<void> toggleWaterReminders() async {
    _waterRemindersEnabled = !_waterRemindersEnabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('waterReminders', _waterRemindersEnabled);
    notifyListeners();
  }

  Future<void> updateProfile({
    String? userName,
    String? doctorName,
    String? partnerName,
  }) async {
    if (userName != null) _userName = userName;
    if (doctorName != null) _doctorName = doctorName;
    if (partnerName != null) _partnerName = partnerName;
    final prefs = await SharedPreferences.getInstance();
    if (userName != null) await prefs.setString('userName', userName);
    if (doctorName != null) await prefs.setString('doctorName', doctorName);
    if (partnerName != null) await prefs.setString('partnerName', partnerName);
    notifyListeners();
  }
}
