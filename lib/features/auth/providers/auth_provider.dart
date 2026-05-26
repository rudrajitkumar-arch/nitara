import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/auth_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthProvider extends ChangeNotifier {
  final _authService = AuthService();

  AuthStatus _status = AuthStatus.unknown;
  User? _user;
  Map<String, dynamic>? _profile;
  bool _isProfileSetup = false;
  bool _isLoading = false;
  String? _error;

  AuthStatus get status => _status;
  User? get user => _user;
  Map<String, dynamic>? get profile => _profile;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get isProfileSetup => _isProfileSetup;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get userName => _profile?['name'] ?? _user?.displayName ?? 'Mama';
  String get userEmail => _user?.email ?? '';

  AuthProvider() {
    _init();
  }

  void _init() {
    _authService.authStateChanges.listen((user) async {
      _user = user;
      if (user != null) {
        _status = AuthStatus.authenticated;
        await _loadProfile();
      } else {
        _status = AuthStatus.unauthenticated;
        _isProfileSetup = false;
        _profile = null;
      }
      notifyListeners();
    });
  }

  Future<void> _loadProfile() async {
    if (_user == null) return;
    try {
      _profile = await _authService.getUserProfile(_user!.uid);
      _isProfileSetup = _profile?['profileSetup'] == true;
    } catch (_) {
      // Offline — check SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      _isProfileSetup = prefs.getBool('profileSetup') ?? false;
    }
    notifyListeners();
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _error = null;
    try {
      await _authService.signUp(name: name, email: email, password: password);
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _error = _mapAuthError(e.code);
      _setLoading(false);
      return false;
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _error = null;
    try {
      await _authService.signIn(email: email, password: password);
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _error = _mapAuthError(e.code);
      _setLoading(false);
      return false;
    }
  }

  Future<bool> savePregnancyProfile({
    required DateTime lmpDate,
    String? partnerName,
    String? doctorName,
  }) async {
    if (_user == null) return false;
    _setLoading(true);
    try {
      await _authService.savePregnancyProfile(
        uid: _user!.uid,
        lmpDate: lmpDate,
        partnerName: partnerName,
        doctorName: doctorName,
      );
      // Cache locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('profileSetup', true);
      await prefs.setString('lmpDate', lmpDate.toIso8601String());
      _isProfileSetup = true;
      await _loadProfile();
      _setLoading(false);
      return true;
    } catch (_) {
      _setLoading(false);
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  String _mapAuthError(String code) {
    switch (code) {
      case 'user-not-found': return 'No account found with this email.';
      case 'wrong-password': return 'Incorrect password. Please try again.';
      case 'email-already-in-use': return 'An account already exists with this email.';
      case 'weak-password': return 'Password must be at least 6 characters.';
      case 'invalid-email': return 'Please enter a valid email address.';
      case 'network-request-failed': return 'Network error. Please check your connection.';
      default: return 'Something went wrong. Please try again.';
    }
  }
}
