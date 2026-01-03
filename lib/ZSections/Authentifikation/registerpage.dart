import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projekt_i/ZSections/Authentifikation/login3Button.dart';
import 'package:projekt_i/ZSections/Authentifikation/textfield.dart';

class registerpage extends StatefulWidget {
  final Function()? onTap;
  const registerpage({super.key, required this.onTap});

  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {
  final emailTextController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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

                //confirm password textfield
                Textfield(
                  controller: confirmpasswordController,
                  hintText: 'Passwort',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                Login3button(onTap: (){}, text: 'Sign up'),

                Row(
                  children: [
                    Text("Already have an account?", style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login now", 
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
        ),
      ),
    );
  }
}