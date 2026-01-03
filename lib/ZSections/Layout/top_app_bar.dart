import 'package:flutter/material.dart';
import 'package:projekt_i/ZSections/Homepage/HomePage2.dart';

import '../../Login 2/auth.dart';
import '../../Login 2/dialog_auth.dart';

//UI of TopAppBar
class TopAppBar extends StatefulWidget {
  final double opacity;

  TopAppBar(this.opacity);

  @override
  State<TopAppBar> createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar> {
  bool _isProcessing = false;
  
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    
    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        color: Theme.of(context).primaryColorLight.withOpacity(widget.opacity),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Flutter Web',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Documentation',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5),
                        ]
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Design',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5),
                        ]
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Developer',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5),
                        ]
                      ),
                    ),
                  ]
                ),
              ),
              SizedBox(  
                width: screenSize.width / 60,
              ),

              //to show the Sign in button only when the user is not signed in already

              //to show the dialog box, make a call to the showDialog method from the onTap of the Sign in button

              InkWell(  
                onTap:userEmail == null
                ? () {
                  showDialog(context: context,
                  
                  //for call and show AuthDialog widget when click
                  builder: (context) => AuthDialog(),
                  );
                }
                : null,

                //If the user is logged in, the userEmail will be non-null, irrespective of the authentication method
                child: userEmail == null
                ? Container(  
                  padding: const EdgeInsets.only(  
                    top: 8, bottom: 8, left: 12, right: 0
                  ),
                  width: 75,
                  height: 38,
                  decoration: ShapeDecoration(  
                    shape: RoundedRectangleBorder(  
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white,
                  ),
                  child: Text(  
                    'Sign in',
                    style: TextStyle(  
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold
                    ),
                  )
                )
                
                //To display the user profile picture (if present), user email/name and a Sign out button

                : Row(
                  children: [
                    CircleAvatar(  
                      radius:16,
                      backgroundImage: imageUrl != null
                      ? NetworkImage(imageUrl!)
                      : null,
                      child: imageUrl == null
                      ? Icon(  
                        Icons.account_circle,
                        size: 30,
                      )
                      : Container(),
                    ),
                    SizedBox(width: 5),
                    Text(
                      name ?? userEmail!,
                      style: TextStyle(  
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),

                      //UI for sign out button 
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    
                      onPressed: _isProcessing
                      ? null: () async {
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
                        print('Sign Out Error: $error');
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
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }     
}