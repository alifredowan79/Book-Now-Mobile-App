import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'toast.dart';
import 'signup_page.dart';
import 'navigation_home_screen.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController(text: 'bubt_sdp_3@gmail.com');
  final _passwordController = TextEditingController(text: 'bubtsdp3');

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      showToast(message: "Login successful!");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => NavigationHomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      showToast(message: e.message ?? "Login failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final email = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(12),
          backgroundColor: Colors.lightBlueAccent,
        ),
        onPressed: _login,
        child: const Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = TextButton(
      onPressed: () {
        // TODO: Add forgot password functionality
      },
      child: const Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
    );

    final signUpLabel = TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed(SignUpPage.tag);
      },
      child: const Text(
        "Don't have an account? Sign Up",
        style: TextStyle(color: Colors.black54),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            logo,
            const SizedBox(height: 48.0),
            email,
            const SizedBox(height: 8.0),
            password,
            const SizedBox(height: 24.0),
            loginButton,
            forgotLabel,
            signUpLabel,
          ],
        ),
      ),
    );
  }
}
