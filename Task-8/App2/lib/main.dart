import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RecipePage(),
    );
  }
}

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1e88e5),

      body: Stack(
        children: [

          /// FOOD IMAGE
          SizedBox(
            height: 420,
            width: double.infinity,
            child: Image.network(
              "https://images.unsplash.com/photo-1557872943-16a5ac26437e",
              fit: BoxFit.cover,
            ),
          ),

          const Positioned(
            top: 50,
            left: 20,
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),


          const Positioned(
            top: 50,
            right: 20,
            child: Icon(Icons.bookmark_border, color: Colors.white),
          ),

          /// PLAY ICON
          const Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 150),
                child: Icon(
                  Icons.play_circle_fill,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.45,
            minChildSize: 0.45,
            maxChildSize: 0.85,
            builder: (context, controller) {
              return Container(
                padding: const EdgeInsets.all(20),

                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),

                child: ListView(
                  controller: controller,
                  children: [

                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),


                    const Text(
                      "Homemade Ramen",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),


                    const Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange),
                        SizedBox(width: 5),
                        Text("4.5"),
                      ],
                    ),

                    const SizedBox(height: 20),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [

                        Column(
                          children: [
                            Icon(Icons.timer, color: Colors.blue),
                            SizedBox(height: 5),
                            Text("35 min"),
                          ],
                        ),

                        Column(
                          children: [
                            Icon(Icons.restaurant, color: Colors.blue),
                            SizedBox(height: 5),
                            Text("Serves 4"),
                          ],
                        ),

                        Column(
                          children: [
                            Icon(Icons.bar_chart, color: Colors.blue),
                            SizedBox(height: 5),
                            Text("Intermediate"),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),


                    const Text(
                      "Ingredients",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text("• Chicken broth"),
                    const Text("• Soy sauce"),
                    const Text("• Garlic"),
                    const Text("• Ginger"),
                    const Text("• Ramen noodles"),
                    const Text("• Boiled eggs"),
                    const Text("• Green onions"),
                    const Text("• Sesame oil"),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}