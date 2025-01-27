import 'dart:io';

import 'package:contacts/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState(); 
  
}

class HomePageState extends State<HomePage> {

  ContactHelper helper = ContactHelper();

  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();

    helper.getAllContacts().then((list){
      setState(() {
        contacts = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),

      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(onPressed: (){},
      child: Icon(Icons.add),
      backgroundColor: Colors.red,
      ),

      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: contacts.length,
        itemBuilder: (context, index){
          return contactCard(context, index);
        },
      ),
    );
  }

  Widget contactCard(BuildContext context, int index){
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[index].img != null && contacts[index].img!.isNotEmpty ? FileImage(File(contacts[index].img!)) as ImageProvider : const AssetImage("images/person.png"),
                    ),

                ),
              ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(contacts[index].name ?? "",
                  style: TextStyle(fontSize: 22,
                  fontWeight: FontWeight.bold),
                  ),

                  Text(contacts[index].email ?? "",
                  style: TextStyle(fontSize: 18),
                  ),

                  Text(contacts[index].phone ?? "",
                  style: TextStyle(fontSize: 18),
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

