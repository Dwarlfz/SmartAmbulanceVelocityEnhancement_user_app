import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService _auth = AuthService();
  final FirestoreService _firestore = FirestoreService();

  bool isLoading = false;

  // 🔐 LOGIN FUNCTION
  Future<void> loginUser() async {
    setState(() => isLoading = true);

    try {
      final user = await _auth.signInWithEmail(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (user != null) {
        await _firestore.saveUser(
          uid: user.uid,
          email: user.email ?? "",
        );

        Navigator.pushReplacementNamed(context, '/home');
      } else {
        showError("Login Failed");
      }
    } catch (e) {
      showError("Error: $e");
    }

    setState(() => isLoading = false);
  }

  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe53935), Color(0xFFb71c1c)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset('assets/images/logo.png', height: 120),

            const SizedBox(height: 20),

            const Text(
              "SAVE",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Saving lives, faster every second 🚑",
              style: TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 40),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [

                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔴 EMAIL LOGIN BUTTON
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: loginUser,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Login"),
                  ),

                  const SizedBox(height: 10),

                  // 📱 PHONE LOGIN (placeholder)
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      showError("Phone login coming next 🔥");
                    },
                    icon: const Icon(Icons.phone),
                    label: const Text("Login with Phone"),
                  ),

                  const SizedBox(height: 10),

                  // 🔵 GOOGLE LOGIN (placeholder)
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      showError("Google login coming next 🔥");
                    },
                    icon: Image.asset('assets/images/google.png', height: 20),
                    label: const Text("Continue with Google"),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Text("Continue as Guest"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}