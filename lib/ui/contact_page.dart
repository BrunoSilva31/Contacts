import 'dart:io';

import 'package:contacts/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {

  final Contact? contact;
  ContactPage({Key? key, this.contact});

  @override
  State<ContactPage> createState() => _ContactPageState();

}

class _ContactPageState extends State<ContactPage> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _userEdited = false;

  late Contact _editedContact;


  @override
  void initState() {
    super.initState();

    if(widget.contact == null) {
      _editedContact = Contact();
    }else {
      final contactMap = widget.contact?.toMap();
      _editedContact = Contact.fromMap(contactMap!);
    }

    _nameController.text = _editedContact.name ?? "";
    _emailController.text = _editedContact.email ?? "";
    _phoneController.text = _editedContact.phone ?? "";

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(_editedContact.name ?? "Novo Contato"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        
        child: Column(

          children: [
            GestureDetector(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _editedContact.img != null && _editedContact.img!.isNotEmpty ? FileImage(File(_editedContact.img!)) as ImageProvider : const AssetImage("images/person.png"),
                    ),

                ),
              ),
            ),

            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Nome"),
              onChanged: (text){
                _userEdited = true;
                setState(() {
                  _editedContact.name = text;
                });
              },
            ),


            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
              onChanged: (text){
                _userEdited = true;
                _editedContact.email = text;
              },

              keyboardType: TextInputType.emailAddress,
            ),


            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone"),
              onChanged: (text){
                _userEdited = true;
                _editedContact.phone = text;
              },

              keyboardType: TextInputType.phone,
            ),


          ],

        ),

      ),
    );
  }
}