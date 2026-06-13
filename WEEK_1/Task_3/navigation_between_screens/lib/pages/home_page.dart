import 'package:flutter/material.dart';
import 'package:navigation_between_screens/pages/info_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        centerTitle: true,
        title: Text("Home Screen",
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
          Text("HOM3 SCR33N 🔥"),

          SizedBox(height: 40),

          ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){ return InfoPage(); }));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[50],
              elevation: 0.0,
            ),
            child: Text("Go to Info page", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),), 
          )
          
        ],),
      )
      
    );
  }
}