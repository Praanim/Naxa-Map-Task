import 'package:map_task/features/list/domain/models/list_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDbServices {
  Database? _database;
  final String _tableName = 'entries';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb('list.db');
    return _database!;
  }

  Future<Database> _initDb(String filePath) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int versions) async {
    await db.execute('''
        CREATE TABLE $_tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          api TEXT NOT NULL,
          description TEXT NOT NULL,
          auth TEXT NOT NULL,
          cors TEXT NOT NULL,
          link TEXT NOT NULL,
          category TEXT NOT NULL
        );
''');
  }

  ///method for inserting listitems to db
  Future<void> insertLists(List<ListItemModel> listItems) async {
    //inserting all list items to the database
    for (int i = 0; i < listItems.length; i++) {
      await _database!.insert(_tableName, listItems[i].toJson());
    }
  }

  ///method for getting listitems from db
  Future<List<Map<String, Object?>>> readListItemsFromDb() async {
    final db = await database;
    final maps = await db.query(_tableName);

    return maps;
  }

  Future close() async {
    await _database!.close();
  }
}
