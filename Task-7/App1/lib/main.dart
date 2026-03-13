import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task 7',
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Task 7"),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.favorite_border),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

        
            Card(
              child: ListTile(
                leading: const Icon(Icons.person, size: 40),
                title: const Text(
                  "Alyaa Ashraf Elnagar",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text("Flutter Developer"),
              ),
            ),

      
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Life is like riding a bicycle. To keep your balance, you must keep moving.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),

        
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                  
                    Row(
                      children: const [
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star_half, color: Colors.orange),
                      ],
                    ),

                    const Text("150 Reviews"),

                    const Icon(Icons.share)
                  ],
                ),
              ),
            ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [

                    Column(
                      children: [
                        Icon(Icons.code),
                        SizedBox(height: 5),
                        Text("EXP"),
                        Text("2 Yrs"),
                      ],
                    ),

                    Column(
                      children: [
                        Icon(Icons.bug_report),
                        SizedBox(height: 5),
                        Text("Bugs"),
                        Text("∞"),
                      ],
                    ),

                    Column(
                      children: [
                        Icon(Icons.coffee),
                        SizedBox(height: 5),
                        Text("Coffee"),
                        Text("∞"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [

                    Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.red),
                        SizedBox(width: 5),
                        Text(
                          "My Hobbies:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Text("1. playing guitar"),
                    Text("2. Drawing"),
                    Text("3. Painting"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}