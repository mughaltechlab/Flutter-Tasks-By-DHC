import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey.shade900),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  int _counter = 0;


  @override
  void initState() {
    super.initState();
    loadData();
  }
  

  // load counter save value
  Future<void> loadData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _counter = prefs.getInt("counter") ?? 0;
    });
    
  }
  
  // save  counter  value
  Future<void> saveData(int val) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("counter", val);
  }
  

  // increment
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    saveData(_counter);
  }

  // decrement
  void _decrementCounter() {
    setState(() {
      _counter--;
    });
    saveData(_counter);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        
        title: Text("State Management Basic", style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Center(
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
                    // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      borderRadius: BorderRadius.circular(8),
                      
                    ),
                    child: Center(
                      child: Text(
                                    '$_counter',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 48,
                                    ),
                                  ),
                    ),
            ),

            SizedBox(height: 8),
            
            // btns
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // add
                GestureDetector(
                  onTap: _incrementCounter,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      borderRadius: BorderRadius.circular(8),
                      
                    ),
                    child: Icon(Icons.add, fontWeight: FontWeight.bold, color: Colors.white,),
                  ),
                ),

                SizedBox(width: 8),

                // minus
                GestureDetector(
                  onTap: _decrementCounter,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      borderRadius: BorderRadius.circular(8),
                      
                    ),
                    child: Icon(Icons.remove, fontWeight: FontWeight.bold, color: Colors.white,),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      
    );
  }
}
