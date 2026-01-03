import 'package:flutter/widgets.dart';
import 'package:projekt_i/ZSections/Authentifikation/login3.dart';
import 'package:projekt_i/ZSections/Authentifikation/registerpage.dart';

class Loginorregister extends StatefulWidget {
  const Loginorregister({super.key});

  @override
  State<Loginorregister> createState() => _LoginorregisterState();
}

class _LoginorregisterState extends State<Loginorregister> {
  bool showloginpage = true;

  void togglePages() {
    setState(() {
      showloginpage = !showloginpage;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if(showloginpage) {
      return Login3(onTap: togglePages);
    } else {
      return registerpage(onTap: togglePages);
    }
  }
}