import 'package:flutter/material.dart';
import 'package:task_mate/tasks.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> _categories = [
    Category("MERCADO", Icons.local_grocery_store, Colors.orange[100]),
    Category("FARMÁCIA", Icons.local_pharmacy, Colors.pink[100]),
    Category("CONSTRUÇÃO", Icons.build, Colors.green[100]),
    Category("TAREFAS", Icons.style, Colors.blueAccent[100]),
    Category("AUTOMÓVEL", Icons.directions_car, Colors.blue[400]),
    Category("ROUPAS", Icons.card_giftcard, Colors.red[200]),
    Category("OUTROS", Icons.dashboard, Colors.brown[200]),
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
      body: buildBody(),
    );
  }

  Container buildBody() {
    return Container(
      color: Colors.blue[100],
      child: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: _categoryCards,
      ),
    );
  }

  Widget _categoryCards(context, idx) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TasksPage(categ: _categories[idx].name.toString())),
        );
      },
      child: Padding(
        padding:
            const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8.0,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                border: Border.all(color: Colors.grey[500], width: 1.0)),
            // color: _categories[idx].color,
            height: 100.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[500], width: 0.5),
                      shape: BoxShape.circle,
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

class Category {
  String name;
  IconData icon;
  Color color;

  Category(this.name, this.icon, this.color);
}
