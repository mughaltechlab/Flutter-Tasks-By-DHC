import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        centerTitle: true,
        title: Text("Info Screen",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.purple.shade700,
          )),
      ),

      // button to navigate  to the info page..
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text("Made with 🔥 by  SAQIB AHMED"),
          SizedBox(height: 40),
          Text("DHC ID 🔥 DHC-3674"),

          
        ],),
      )
      
    );

  }
}