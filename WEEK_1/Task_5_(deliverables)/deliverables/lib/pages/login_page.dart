import 'package:deliverables/pages/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          
            // email
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                label: Text("Email"),
                hintText: "Johndoe@gmail.com",
              ),
              validator: (val){
                if (val == null || val.isEmpty) {
                  return "Enter your email";
                }
                if (!val.contains("@") || !val.contains(".co")) {
                  return "Enter your valid email";
                } else {
                  return null;
                }
              },
            ),
          
            SizedBox(height: 12,),
          
            // password
            TextFormField(
              controller: passController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                label: Text("Password"),
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
          
            SizedBox(height: 12,),
          
            // ElevatedButton(
            //         onPressed: (){
            //           if (_formKey.currentState!.validate()) {
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               SnackBar(content: Text('Form is valid', style: TextStyle(color: Colors.green.shade600, fontWeight: FontWeight.bold),), 
                
            //               backgroundColor: Colors.green.shade100,
            //               )
            //             );
            //           } else {
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               SnackBar(content: Text('Form is invalid', style: TextStyle(color: Colors.red.shade600, fontWeight: FontWeight.bold),), 
                
            //               backgroundColor: Colors.red.shade100,
            //               )
            //             );
            //           }
            //         },
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: Colors.grey.shade900,
            //           foregroundColor: Colors.white,
            //           elevation: 0.0,
            //         ),
            //         child: Text("Login", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),), 
            //       ),

                SizedBox(height: 20),

                  GestureDetector(
                    onTap: (){
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Successfuly Login', style: TextStyle(color: Colors.green.shade600, fontWeight: FontWeight.bold),), 
                
                          backgroundColor: Colors.green.shade100,
                          )

                          
                        );

                        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                        
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Form is invalid', style: TextStyle(color: Colors.red.shade600, fontWeight: FontWeight.bold),), 
                
                          backgroundColor: Colors.red.shade100,
                          )
                        );
                      }
                    },
                    
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),))), 
                  ),

                  SizedBox(height: 10),
                  
          
                  // signup||forgot pasword?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // signup
                      Text("Haven't account yet",
                      style: TextStyle(
                        color: Colors.blue.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      ),

                      SizedBox(width: 8),
                      Text("|", style: TextStyle(
                        color: Colors.grey,
                      ),),
                      SizedBox(width: 8),

                      // forgot pass
                      Text("Forgot Password?",
                      style: TextStyle(
                        color: Colors.blue.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ],
                  ),
                  
          ],),
        ),
      ),
    );
  }
}