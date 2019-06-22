// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// final String nmTable = 'Tasktable';
// final String idCategColumn = 'idCateg';
// final String nmCategColumn = 'nmCateg';
// final String dtInsertedColumn = 'dtInserted';
// final String txtTaskColumn = 'txtTask';

// class TaskHelper {
//   static final TaskHelper _instance = TaskHelper.internal();
//   factory TaskHelper() => _instance;
//   TaskHelper.internal();

//   Database _db;

// Future<Database> get db async {
//     if (db != null) {
//       return _db;
//     } else {
//       _db = await initDb();
//       return _db;
//     }
//   }

//   Future<Database> initDb() async {
//     final databasesPath = await getDatabasesPath();
//     final path = join(databasesPath, 'TaskHyst.db');

//     return await openDatabase(path, version: 1,
//         onCreate: (Database db, int newerVersion) async {
//       await db.execute(
//            "CREATE TABLE $nmTable($dtInsertedColumn TEXT NOT NULL,$nmCategColumn TEXT NOT NULL,$txtTaskColumn TEXT NOT NULL)");
//     });
//   }

//   Future<TaskHyst> saveTask(TaskHyst taskHyst) async {
//     Database dbTaskHyst = await db;
//     await dbTaskHyst.insert(nmTable, taskHyst.toMap());
//     return taskHyst;
//   }

//   Future<TaskHyst> getTaskHyst(String dt) async {
//     Database dbTaskHyst = await db;
//     List<Map> maps = await dbTaskHyst.query(nmTable,
//     columns: [idCategColumn,nmCategColumn,dtInsertedColumn,txtTaskColumn],
//     where: '$dtInsertedColumn = ?',
//     whereArgs: [dt]);
//     if(maps.length > 0){
//       return TaskHyst.fromMap(maps.first));
//     }
//   }
// }

// class TaskHyst {
//   String dtInserted;
//   String idCateg;
//   String nmCateg;
//   String txtTask;

//   TaskHyst.fromMap(Map map) {
//     dtInserted = map[dtInsertedColumn];
//     idCateg = map[idCategColumn];
//     nmCateg = map[nmCategColumn];
//     txtTask = map[txtTaskColumn];
//   }

//   Map toMap() {
//     Map<String, dynamic> map = {
//       idCategColumn: idCateg,
//       nmCategColumn: nmCateg,
//       dtInsertedColumn: dtInserted,
//       txtTaskColumn: txtTask
//     };

//     return map;
//   }
// }
