import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: "task-mate",
      debugShowCheckedModeBanner: false,
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class Category {
  String name;
  IconData icon;
  Color color;

  Category(this.name, this.icon, this.color);
}

class _HomeState extends State<Home> {
  List<Category> _categories = [
    Category("MERCADO", Icons.local_grocery_store, Colors.orange[100]),
    Category("FARMÁCIA", Icons.local_pharmacy, Colors.pink[100]),
    Category("CONSTRUÇÃO", Icons.build, Colors.green[100]),
    Category("TAREFAS", Icons.style, Colors.blueAccent[100]),
    Category("AUTOMÓVEL", Icons.directions_car, Colors.blue[400]),
    Category("ROUPAS", Icons.card_giftcard, Colors.red[200]),
    Category("OUTROS", Icons.dashboard, Colors.brown[100]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text("LISTAS",
            style: TextStyle(
                fontSize: 30.0,
                // fontWeight: FontWeight.bold,
                fontFamily: "LibreBaskerville")),
      )),
      body: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: _categoryCards,
      ),
    );
  }

  Widget _categoryCards(context, idx) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: Card(
          elevation: 8.0,
          child: Container(
            // color: _categories[idx].color,
            height: 100.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(shape: BoxShape.circle,
                  color: _categories[idx].color),
                  child: Icon(_categories[idx].icon, size: 40.0),
                ),
                title: Text(_categories[idx].name,
                    style: TextStyle(fontSize: 28, color: Colors.black87)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
