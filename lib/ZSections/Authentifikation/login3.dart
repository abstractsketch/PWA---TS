import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projekt_i/ZSections/Authentifikation/login3Button.dart';
import 'package:projekt_i/ZSections/Authentifikation/textfield.dart';

class Login3 extends StatefulWidget {
  final Function()? onTap;
  const Login3({super.key, required this.onTap});

  @override
  State<Login3> createState() => _Login3State();
}

class _Login3State extends State<Login3> {
  final emailTextController = TextEditingController();
  final passwordController = TextEditingController();
  

  void signin() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailTextController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 180, 180, 180),
      body : SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //email textfield
                Textfield(
                  controller: emailTextController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                //password textfield
                Textfield(
                  controller: passwordController,
                  hintText: 'Passwort',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                Login3button(onTap: signin, text: 'Sign in'),

                Row(
                  children: [
                    Text("Not a member?", style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register now", 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],   
                ),
              ]
            ),
          ),
        ))
    );
  }
}