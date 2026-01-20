import 'package:flutter/material.dart';
import 'package:projekt_i/ZSections/Homepage/HomePage2.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/LandingPageR/auth.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/LandingPageR/dialog_auth.dart';
import 'package:projekt_i/ZSections/Homepage/HomePage.dart';

class Drawers extends StatefulWidget {
  const Drawers({Key? key,}) : super(key: key);

  @override
  State<Drawers> createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Container(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DrawerHeader(
                child: Text("Logo")
              ),

              userEmail != null ? SizedBox(height: 20) : Container(),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Divider(color: Colors.grey[900]),
                ),

                Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  title: const Text('Was ist Mind?'),
                  textColor: const Color.fromARGB(255, 0, 0, 0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homepage2(), // <-- deine Zielseite
                      ),
                    );
                  },
                ),
              ),

                Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.health_and_safety,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  title: const Text('Tools'),
                  textColor: const Color.fromARGB(255, 0, 0, 0),
                  onTap: () {},
                ),
              ),

                Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.contact_emergency,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  title: const Text('Kontakt'),
                  textColor: const Color.fromARGB(255, 0, 0, 0),
                  onTap: () {},
                ),
              ),
                Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.info,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  title: const Text('Impressum'),
                  textColor: const Color.fromARGB(255, 0, 0, 0),
                  onTap: () {},
                ),
              ),

              
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,   // Alles nach unten drücken
                  children: [
                    userEmail == null
                ? Container(
                  width: double.maxFinite,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),

                    //call and show AuthDialogwidget when click
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AuthDialog(),
                      );
                    },

                    child: Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900],
                        )
                      ),
                    ),
                  ),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
                      child: imageUrl == null
                      ? Icon(
                        Icons.account_circle,
                        size: 40,
                      )
                      : Container(),
                    ),
                    SizedBox(width:10),
                    Text(
                      name ?? userEmail!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                userEmail != null
                ? Container(
                  width: double.maxFinite,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: _isProcessing
                    ? null
                    : () async {
                      setState(() {
                        _isProcessing = true;
                      });
                      await signOut().then((result) {
                        print(result);

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder:(context) => Homepage2(),
                          ),
                        );
                      }).catchError((error) {
                      print('SignOut Error: $error');
                      });
                      setState(() {
                        _isProcessing = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top:8, bottom: 8),
                      child: _isProcessing
                      ? CircularProgressIndicator()
                      : Text(
                        'Sign Out',
                        style: TextStyle(
                          fontSize:16,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                )
                
                : SizedBox(height: 10,),
                Container(),
                    SizedBox(height: 10,),
                    Text(
                      'Copyright 2025 | Thomas Schen',
                      style: TextStyle(color: Colors.black45, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ], 
          ),
        ),
      ),
    );
  }
}