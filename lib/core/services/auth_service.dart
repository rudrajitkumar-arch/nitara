import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Sign up with email and password, create Firestore user doc.
  Future<UserCredential> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await cred.user?.updateDisplayName(name);

    // Create user document
    await _db.collection('users').doc(cred.user!.uid).set({
      'uid': cred.user!.uid,
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
      'profileSetup': false,
    });

    return cred;
  }

  /// Sign in with email and password.
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  /// Sign out.
  Future<void> signOut() => _auth.signOut();

  /// Save LMP date and pregnancy info to Firestore.
  Future<void> savePregnancyProfile({
    required String uid,
    required DateTime lmpDate,
    String? partnerName,
    String? doctorName,
  }) async {
    final dueDate = lmpDate.add(const Duration(days: 280));
    await _db.collection('users').doc(uid).update({
      'lmpDate': lmpDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'partnerName': partnerName ?? '',
      'doctorName': doctorName ?? '',
      'profileSetup': true,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Fetch user profile from Firestore.
  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.data();
  }

  /// Reset password.
  Future<void> sendPasswordReset(String email) =>
      _auth.sendPasswordResetEmail(email: email);
}
