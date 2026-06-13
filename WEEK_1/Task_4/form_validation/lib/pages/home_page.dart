import 'package:flutter/material.dart';

class HomePgae extends StatelessWidget {  


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  HomePgae({super.key});

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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              
              // EMAIL
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  icon: Icon(Icons.email),
                  labelText: "Email",
                  hintText: "johndoe@gmail.com",
                ),
                validator: (val){
                  if (val == null || val.isEmpty) {
                    return "Enter your email";
                  } 
                  if (!val.contains('@') && !val.contains('.co')) {
                    return "Enter valid email";
                  } else {
                    return null;
                  }
                },
              ),
            
              SizedBox(height: 24,),
            
              // password
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  icon: Icon(Icons.key),
                  labelText: "Password",
                  hintText: "Enter your password",
                ),
                validator: (val){
                  if (val == null || val.isEmpty) {
                    return "Enter your password";
                  } else {
                    return null;
                  }
                },
              ),

              SizedBox(height: 24,),

            
              ElevatedButton(
                onPressed: (){
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form is valid', style: TextStyle(color: Colors.green.shade600, fontWeight: FontWeight.bold),), 
            
                      backgroundColor: Colors.green.shade100,
                      )
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form is invalid', style: TextStyle(color: Colors.red.shade600, fontWeight: FontWeight.bold),), 
            
                      backgroundColor: Colors.red.shade100,
                      )
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade800,
                  foregroundColor: Colors.white,
                  elevation: 0.0,
                ),
                child: Text("Login", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),), 
              )
              
            ],),
          ),
        ),
      )
      
    );
  }
}