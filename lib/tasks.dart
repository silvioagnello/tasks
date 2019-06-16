import 'dart:convert';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:flutter/material.dart';

class Categ {
  String categ;
  String name;
  bool ok;

// Categ();
  Categ(this.categ, this.name, this.ok);
}

class TasksPage extends StatefulWidget {
  final String categ;

  TasksPage({this.categ});

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final _toDoController = TextEditingController();

  List _toDoList = [];
  List _toDoList2 = [];
// List<Map<String, dynamic>> _toDoList = [
  // {"name": "teste1", "ok": true},
  // {"name": "teste2", "ok": false}
// ];

  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
        _toDoList2 = json.decode(data);
        _toDoList2.removeWhere((c) => c["categ"] == widget.categ);
        _toDoList.removeWhere((c) => c["categ"] != widget.categ);
      });
    });
  }

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newTask = {
        "categ": "${widget.categ}",
        "name": _toDoController.text,
        "ok": false
      };
      _toDoController.text = "";
      
      _toDoList.add(newTask);
      _saveData();
    });
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _toDoList.sort((a, b) {
        if (a["ok"] && !b["ok"])
          return 1;
        else if (!a["ok"] && b["ok"])
          return -1;
        else
          return 0;
      });

      // _saveData();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("${widget.categ}",
              style: TextStyle(
                  fontSize: 20.0,
                  // fontWeight: FontWeight.bold,
                  fontFamily: "LibreBaskerville"))),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                          controller: _toDoController,
                          // autofocus: true,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              hintText: "Digite uma tarefa",
                              labelStyle: TextStyle(color: Colors.blue)))),
                  RaisedButton(
                    elevation: 4.0,
                    color: Colors.lightBlueAccent,
                    child: Icon(Icons.check),
                    onPressed: _addToDo,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 8.0),
                  itemCount: _toDoList.length,
                  itemBuilder: buildItem),
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem(context, int index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
          color: Colors.red,
          child: Align(
              alignment: Alignment(-0.9, 0.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ))),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
          title: Text(_toDoList[index]['name']),
          value: _toDoList[index]["ok"],
          secondary: CircleAvatar(
              child: Icon(_toDoList[index]["ok"] ? Icons.check : Icons.error)),
          onChanged: (c) {
            setState(() {
              _toDoList[index]["ok"] = c;
              _saveData();
            });
          }),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_toDoList[index]);
          _lastRemovedPos = index;
          _toDoList.removeAt(index);
          _saveData();

          final snack = SnackBar(
            content: Text("Tarefa ${_lastRemoved['name']} removida"),
            action: SnackBarAction(
              label: "Desfazer",
              onPressed: () {
                setState(() {
                  _toDoList.insert(_lastRemovedPos, _lastRemoved);
                  _saveData();
                });
              },
            ),
            duration: Duration(seconds: 7),
          );
          // Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(snack);
        });
      },
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/tasks.json");
  }

  Future<File> _saveData() async {
    var newMyList = _toDoList + _toDoList2;
    _toDoList2 = [];
    String data = json.encode(newMyList);   //  json.encode(_toDoList2);
    final file = await _getFile();
    return file.writeAsString(data);
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
}
