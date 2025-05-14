import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'toast.dart'; // Make sure this file contains showToast()
import 'login_page.dart'; // Add this if using Navigator.push

class SignUpPage extends StatefulWidget {
  static String tag = 'signup-page';

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Sign Up Function
  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      showToast(message: "Passwords do not match");
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      showToast(message: "Sign up successful!");

      // Navigate to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      showToast(message: e.message ?? "Signup failed");
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'), // Replace with your logo
      ),
    );

    final nameField = TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: 'Full Name',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final emailField = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final passwordField = TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final confirmPasswordField = TextFormField(
      controller: _confirmPasswordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final signUpButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        backgroundColor: Colors.lightBlueAccent,
      ),
      child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
      onPressed: _signUp,
    );

    final loginLabel = TextButton(
      child: const Text(
        'Already have an account? Log In',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pop(context); // Go back to login
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logo,
                const SizedBox(height: 24.0),
                nameField,
                const SizedBox(height: 12.0),
                emailField,
                const SizedBox(height: 12.0),
                passwordField,
                const SizedBox(height: 12.0),
                confirmPasswordField,
                const SizedBox(height: 24.0),
                signUpButton,
                loginLabel,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
