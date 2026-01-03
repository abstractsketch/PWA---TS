import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PersistentInputWidget extends StatefulWidget {
  @override
  _PersistentInputWidgetState createState() => _PersistentInputWidgetState();
}

class _PersistentInputWidgetState extends State<PersistentInputWidget> {
  late TextEditingController _nameController, _numberController;
  String _typeSelected ='';

  late DatabaseReference _ref;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _ref = FirebaseDatabase.instance.ref().child('Contacts');
  }


Widget _buildContactType(String title){

  return InkWell(

    child: Container(
      height: 40,
      width: 90,

      decoration: BoxDecoration(
        color: _typeSelected == title? Colors.green : Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Center(child: Text(title, style: TextStyle(fontSize: 18,
      color: Colors.white),
    ),),),

    onTap: (){
      setState(() {
        _typeSelected = title;
      });
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Contact'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter Name',
                prefixIcon: Icon(
                  Icons.account_circle,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: _numberController,
              decoration: InputDecoration(
                hintText: 'Enter Number',
                prefixIcon: Icon(
                  Icons.phone_iphone,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
           SizedBox(height: 15,),
           
           SizedBox(height: 25,),
           Container(
             width: double.infinity,
             padding: EdgeInsets.symmetric(horizontal: 10),
             child: ElevatedButton(child: Text('Save Contact',style: TextStyle(
               fontSize: 20,
               color: Colors.white,
               fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: (){
              saveContact();
            },
             ),
           )

          ],
        ),
      ),
    );
  }
  void saveContact(){

    String name = _nameController.text;
    String number = _numberController.text;

    Map<String,String> contact = {
      'name':name,
      'number': '+91 ' + number,
      'type': _typeSelected,
    };


  }
}
