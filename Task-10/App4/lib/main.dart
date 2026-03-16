import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "E-Commerce UI",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {

  List products = [
    {
      "name": "Shoes",
      "price": "\$80",
      "image": "https://picsum.photos/200"
    },
    {
      "name": "Headphones",
      "price": "\$120",
      "image": "https://picsum.photos/201"
    },
    {
      "name": "Watch",
      "price": "\$150",
      "image": "https://picsum.photos/202"
    },
    {
      "name": "Bag",
      "price": "\$70",
      "image": "https://picsum.photos/203"
    },
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
        actions: [
          Icon(Icons.shopping_cart),
          SizedBox(width: 10)
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Fav"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [

            TextField(
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            SizedBox(height: 15),


            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  category("All"),
                  category("Shoes"),
                  category("Electronics"),
                  category("Fashion"),
                  category("Beauty"),
                ],
              ),
            ),

            SizedBox(height: 15),

            /// Products
            Expanded(
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10
                ),
                itemBuilder: (context, index) {

                  var product = products[index];

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Image.network(
                          product["image"],
                          height: 80,
                        ),

                        SizedBox(height: 10),

                        Text(
                          product["name"],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          product["price"],
                          style: TextStyle(
                            color: Colors.deepPurple,
                          ),
                        ),

                        IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: () {},
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget category(String name) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(
        name,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
