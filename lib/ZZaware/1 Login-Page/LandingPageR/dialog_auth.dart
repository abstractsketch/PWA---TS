import 'package:flutter/material.dart';
import 'package:projekt_i/ZSections/Homepage/HomePage2.dart';
import 'package:projekt_i/ZSections/Bibliothek/Bibliothek.dart';
import 'package:projekt_i/ZSections/Authentifikation/google_sign_in_button.dart';
import 'package:projekt_i/ZSections/Homepage/HomePage.dart';
import 'auth.dart';

class AuthDialog extends StatefulWidget {
  @override
  _AuthDialogState createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  late TextEditingController textControllerEmail;
  late FocusNode textFocusNodeEmail;
  bool _isEditingEmail = false;

  late TextEditingController textControllerPassword;
  late FocusNode textFocusNodePassword;

  bool _isEditingPassword = false;
  bool _isRegristering = false;
  bool _isLoggingIn = false;

  String? loginStatus;
  Color loginStringColor = Colors.grey;

  //method validating an email adress
  String? _validateEmail(String value) {
    value = value.trim();

    if (value.isEmpty) {
      return 'Email cant be empty';
    } 
    else if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
        .hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }


    //validate password

  String? _validatePassword(String value) {
    value = value.trim();

    if (value.isEmpty) {
      return 'Password cant be empty';
    } 
    else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }


  @override
  void initState() {
    super.initState();
    textControllerEmail = TextEditingController();
    textControllerPassword = TextEditingController();
    textFocusNodeEmail = FocusNode();
    textFocusNodePassword = FocusNode();

  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0),),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 400,
            color: Colors.grey[300],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 8.0),
                  child: Text(
                    'Email',
                    textAlign: TextAlign.left,
                    style:TextStyle(
                      color: Colors.grey[900],
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextField(
                    focusNode: textFocusNodeEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: textControllerEmail,
                    autofocus: false,
                    onChanged: (value) {
                      setState((){
                        _isEditingEmail = true;
                      });
                    },
                    onSubmitted: (value) {
                      textFocusNodeEmail.unfocus();
                      FocusScope.of(context)
                          .requestFocus(textFocusNodePassword);
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blueGrey[800]!,
                          width: 3,
                        )
                      ),
                      filled:true,
                      hintStyle: new TextStyle(
                        color: Colors.blueGrey[300],
                      ),
                      hintText: "Email",
                      fillColor: Colors.white,
                      errorText: _isEditingEmail
                          ? _validateEmail(textControllerEmail.text)
                          : null,
                      errorStyle: TextStyle(
                        fontSize:12,
                        color: Colors.redAccent,
                      )
                    ),
                  ),
                ),
                SizedBox(height:20),
                Padding(
                  padding: const EdgeInsets.only(left:20, right: 20),
                  child: TextField(
                    focusNode: textFocusNodePassword,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: textControllerPassword,
                    obscureText: true,
                    autofocus: false,
                    onChanged: (value) {
                      setState(() {
                        _isEditingPassword = true;
                      });
                    },
                    onSubmitted: (value) {
                      textFocusNodePassword.unfocus();
                      FocusScope.of(context)
                        .requestFocus(textFocusNodePassword);
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blueGrey[800]!,
                          width:3,  
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(color: Colors.blueGrey[200]!,),
                      hintText: "Passwort",
                      fillColor: Colors.white,
                      errorText: _isEditingPassword
                          ? _validatePassword(textControllerPassword.text)
                          : null,
                      errorStyle: TextStyle(
                        fontSize: 12,
                        color:  Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                

                //Log in and Sign up buttons
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex:1,
                        child: Container(
                          width: double.maxFinite,
                           

                           //UI login button to sign in with email and password 
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )
                            ),
                            onPressed: (() async {
                              setState(() {
                                _isLoggingIn = true;
                                textFocusNodeEmail.unfocus();
                                textFocusNodePassword.unfocus();
                              });
                              if (_validateEmail(textControllerEmail.text) == null && _validatePassword(textControllerPassword.text) == null) {
                                await signInWithEmailPassword(textControllerEmail.text, textControllerPassword.text).then((result) {
                                  if(result == null) {
                                    print(result);
                                    setState(() {
                                      loginStatus = 
                                      'Du hast dich erfolgreich eingeloggt';
                                      loginStringColor = Colors.green;
                                    });

                                    Future.delayed(Duration(milliseconds:500), () {
                                      Navigator.of(context).pop();

                                      
                                    });//for navigate  to home page after sign in
                                      
                                    Navigator
                                      .of(context)
                                      .pushReplacement(MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) => Homepage2(),
                                      )
                                    );
                                  }
                                }).catchError((error) {
                                  print('Login Error: $error');
                                  setState((){
                                    loginStatus = 'Error occured while logging in';
                                    loginStringColor = Colors.red;
                                  });
                                });
                              } else if (textControllerEmail.text.isEmpty || textControllerPassword.text.isEmpty) {
                                setState(() {
                                  loginStatus = 'Bitte Email und Passwort eingeben';
                                  loginStringColor = Colors.red;
                                });
                                return;
                              }

                              setState(() {
                                _isLoggingIn = false;
                                textControllerEmail.text = '';
                                textControllerPassword.text ='';
                                _isEditingEmail = false;
                                _isEditingPassword = false;
                              });
                            }), 
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              
                              child: _isLoggingIn
                              ?SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                  new AlwaysStoppedAnimation<Color>(Colors.white,
                                  ),
                                ),
                              )
                              :Text(
                                'Log in',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width:20),
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: double.maxFinite,
                          
                          //UI of Sign up button to register with Email & Password
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                _isRegristering = true;
                              });
                              await registerWithEmailPassword(textControllerEmail.text,
                              textControllerPassword.text)
                              .then((result) {
                                if (result!= null){
                                  setState(() {
                                    loginStatus = 'You have registered successfully';
                                    loginStringColor = Colors.green;
                                  });
                                  print(result);
                                }
                              }).catchError((error) {
                                print('Registration Error: $error');
                                setState(() {
                                  loginStatus = 'Error occured while registering';
                                  loginStringColor = Colors.red;
                                });
                              });

                              setState(() {
                                _isRegristering = false;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ) ,
                              child: _isRegristering
                              ? SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                  new AlwaysStoppedAnimation<Color>(Colors.white,
                                  ),
                                ),
                              )
                              :Text(
                                'Registrieren',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]
                  )
                ),
                loginStatus != null
                ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: Text(
                      loginStatus!,
                      style: TextStyle(
                        color: loginStringColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                :Container(),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40,),
                  child: Container(
                    height: 1,
                    width: double.maxFinite,
                    color: Colors.blueGrey[200],
                  ),
                ),
                SizedBox(height: 30,),

                //Call the Widget of Google Sign-In buttons
                Center(child: GoogleButton()),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Sie stimmen unseren Nutzungsbedingungen zu und bestätigen, dass Sie unsere Datenschutzrichtlinie gelesen haben.',
                    maxLines: 2,
                    style: TextStyle(
                      color: Theme
                      .of(context)
                      .textTheme
                      .titleSmall!
                      .color,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,

                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}