import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔹 Email Login
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Email Login Error: $e");
      return null;
    }
  }

  // 🔹 Register Email
  Future<User?> registerWithEmail(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Register Error: $e");
      return null;
    }
  }

  // 🔹 Phone Auth (OTP)
  Future<void> verifyPhone({
    required String phone,
    required Function(String) codeSent,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Phone Auth Error: $e");
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // 🔹 Verify OTP
  Future<User?> signInWithOTP(
      String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final result = await _auth.signInWithCredential(credential);
      return result.user;
    } catch (e) {
      print("OTP Error: $e");
      return null;
    }
  }

  // 🔹 Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}