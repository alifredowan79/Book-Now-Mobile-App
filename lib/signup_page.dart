import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  static String tag = 'signup-page';

  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'), // Change to your logo path
      ),
    );

    final nameField = TextFormField(
      keyboardType: TextInputType.name,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Full Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final emailField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final passwordField = TextFormField(
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final confirmPasswordField = TextFormField(
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final signUpButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        backgroundColor: Colors.lightBlueAccent,
      ),
      child: Text('Sign Up', style: TextStyle(color: Colors.white)),
      onPressed: () {
        // Add sign-up logic here
      },
    );

    final loginLabel = TextButton(
      child: Text(
        'Already have an account? Log In',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pop(context); // Go back to login page
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logo,
              SizedBox(height: 24.0),
              nameField,
              SizedBox(height: 12.0),
              emailField,
              SizedBox(height: 12.0),
              passwordField,
              SizedBox(height: 12.0),
              confirmPasswordField,
              SizedBox(height: 24.0),
              signUpButton,
              loginLabel,
            ],
          ),
        ),
      ),
    );
  }
}
