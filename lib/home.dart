import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_mate/tasks.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> _categories = [
    Category("0", "MERCADO", Icons.local_grocery_store, Colors.orange[100]),
    Category("1", "FARMÁCIA", Icons.local_pharmacy, Colors.pink[100]),
    Category("2", "CONSTRUÇÃO", Icons.build, Colors.green[100]),
    Category("3", "TAREFAS", Icons.style, Colors.blueAccent[100]),
    Category("4", "AUTOMÓVEL", Icons.directions_car, Colors.blue[400]),
    Category("5", "ROUPAS", Icons.card_giftcard, Colors.red[200]),
    Category("6", "OUTROS", Icons.dashboard, Colors.brown[200]),
  ];

  List _toDoList3 = [];
  String qtPendCateg = '';
  int qtPend0 = 0;
  int qtPend1 = 0;
  int qtPend2 = 0;
  int qtPend3 = 0;
  int qtPend4 = 0;
  int qtPend5 = 0;
  int qtPend6 = 0;

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        _toDoList3 = json.decode(data);

        qtPend0 = _toDoList3.where((c) => c["idCateg"] == "0").length;
        qtPend1 = _toDoList3.where((c) => c["idCateg"] == "1").length;
        qtPend2 = _toDoList3.where((c) => c["idCateg"] == "2").length;
        qtPend3 = _toDoList3.where((c) => c["idCateg"] == "3").length;
        qtPend4 = _toDoList3.where((c) => c["idCateg"] == "4").length;
        qtPend5 = _toDoList3.where((c) => c["idCateg"] == "5").length;
        qtPend6 = _toDoList3.where((c) => c["idCateg"] == "6").length;
      });
    });
  }

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

  void _awaitReturnValueFromSecondScreen(BuildContext context, idx) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TasksPage(idCateg: _categories[idx].idCateg.toString())));

    if (result != null) {
      switch (idx) {
        case 0:
          qtPend0 = int.parse(result);
          break;
        case 1:
          qtPend1 = int.parse(result);
          break;
        case 2:
          qtPend2 = int.parse(result);
          break;
        case 3:
          qtPend3 = int.parse(result);
          break;
        case 4:
          qtPend4 = int.parse(result);
          break;
        case 5:
          qtPend5 = int.parse(result);
          break;
        case 6:
          qtPend6 = int.parse(result);
          break;
      }
    }
  }

  Widget _categoryCards(context, idx) {
    String qtPendCateg;
    switch (_categories[idx].idCateg) {
      case "0":
        qtPendCateg = qtPend0.toString();
        break;
      case "1":
        qtPendCateg = qtPend1.toString();
        break;
      case "2":
        qtPendCateg = qtPend2.toString();
        break;
      case "3":
        qtPendCateg = qtPend3.toString();
        break;
      case "4":
        qtPendCateg = qtPend4.toString();
        break;
      case "5":
        qtPendCateg = qtPend5.toString();
        break;
      case "6":
        qtPendCateg = qtPend6.toString();
        break;
      default:
        qtPendCateg = '';
    }

    return GestureDetector(
      onTap: () {
        // String qtCateg;
        // Route route = MaterialPageRoute(
        //     builder: (context) =>
        //         TasksPage(idCateg: _categories[idx].idCateg.toString()));
        // Navigator.push(context, route);
        _awaitReturnValueFromSecondScreen(context, idx);
        // final result = await Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) =>
        //           TasksPage(idCateg: _categories[idx].idCateg.toString()
        //               // qtCateg: qtPendCateg
        //               )),
        // );
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
                trailing: Text("$qtPendCateg"),
                leading: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[500], width: 0.5),
                      shape: BoxShape.circle,
                      color: _categories[idx].color),
                  child: Icon(_categories[idx].icon, size: 40.0),
                ),
                title: Text(_categories[idx].nmCateg,
                    style: TextStyle(fontSize: 24, color: Colors.black87)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Category {
  String idCateg;
  String nmCateg;
  IconData icon;
  Color color;

  Category(this.idCateg, this.nmCateg, this.icon, this.color);
}

Future<File> _getFile() async {
  final directory = await getApplicationDocumentsDirectory();
  return File("${directory.path}/tasks.json");
}

Future<String> _readData() async {
  try {
    final file = await _getFile();
    final s = file.lengthSync();
    return file.readAsString();
  } catch (e) {
    return null;
  }
}
