import 'package:flutter/material.dart';
import 'package:projekt_i/Test/Homepage/MainLayout.dart';
import 'package:projekt_i/ZSections/Homepage/HomePage2.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/LandingPageR/auth.dart';
import 'package:projekt_i/ZSections/Homepage/HomePage.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveLayout.dart';
import 'package:projekt_i/main.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({super.key});

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  bool _isProcessing = false;
  
  @override
  Widget build(BuildContext context) {
    return Container(
  width: double.infinity,
  height: 45,
  decoration: BoxDecoration(
    color: AppColors.cardWhite,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        offset: const Offset(0, 4),
        blurRadius: 5,
      ),
    ],
  ),
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent, 
      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    onPressed: () async {
      setState(() {
        _isProcessing = true;
      });
      await signInwithGoogle().then((result) {
        print(result);
        if (result != null) {
          //navigate to Homepage after login
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResponsiveLayout(),
            ),
          );
        }
      }).catchError((error) {
        print('Registration Error: $error');
      });
      setState(() {
        _isProcessing = false;
      });
    },
    child: _isProcessing
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*const Image(
                image: AssetImage('lib/Bilder/googleg.png'),
                height: 10, // Leicht verkleinert für die 45er Button-Höhe
              ),*/
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Weiter mit Google',
                  style: TextStyle(
                    fontSize: 16, // Angepasst an die Button-Größe
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ],
          ),
  ),
);
  }
}

/*DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(20),
          side: BorderSide(color: Colors.blueGrey, width:3),
        ),
        color: Colors.white,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
        onPressed: () async {
          setState(() {
            _isProcessing = true;
          });
          await signInwithGoogle().then((result) {
            print(result);
            if (result != null) {
              //navigate to Homepage after login
              Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ResponsiveLayout(),
  ),
);
            }
          }).catchError((error) {
            print('Registration Error: $error');
          });
          setState(() {
            _isProcessing = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: _isProcessing
          ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.orangeEnd),
            ),
          )
          :Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Image(
                image: AssetImage('lib/Bilder/google.png'),
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Continue with Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.text,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );*/ 