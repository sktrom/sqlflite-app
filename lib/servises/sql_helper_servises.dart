import 'dart:async';
import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelperService {
  static Database? _db;

  Future<Database?> get database async {
    if (_db == null) {
      log('Data base was that null converted to initialDataBase.');
      _db = await initialDataBase();
      return _db;
    } else {
      log('Data base created directly.');
      return _db;
    }
  }

  initialDataBase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'users.db'); // =>  databasePath/users.db
    Database myDatabase = await openDatabase(path,
        version: 1, onCreate: onCreate, onUpgrade: onUpgrade);
    return myDatabase;
  }

  FutureOr<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    log('ON Upgrade');
    // await db.execute("ALTER TABLE userinfo ADD COLUMN color TEXT");
  }

  FutureOr<void> onCreate(Database db, int version) async {
    Batch batch = db.batch();

// ((((((((((( Batch give me accibility to create more than table in the same time )))))))))))

// Table one
    batch.execute('''
      CREATE TABLE "userinfo"(
      'id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      'title' TEXT,
      'description' TEXT,
      'createdAt' TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )''');
// Table two example
//       batch.execute('''
//       CREATE TABLE "students"(
//       'id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
//       'title' TEXT,
//       'description' TEXT,
//       'createdAt' TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
//       )''');

    await batch.commit();
    log('ON Created');
  }

  readOrGetData(String sql) async {
    log('The Read Database is completed');
    Database? mydb = await database;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertOrAddData(String sql) async {
    log('The Insert Database is completed');
    Database? mydb = await database;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    log('The Update Database is completed');
    Database? mydb = await database;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deletData(String sql) async {
    log('The Delete Database is completed');
    Database? mydb = await database;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  deleteAllDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'users.db');
    await deleteDatabase(path);
  }

  // we have a short functhion

  read(String table) async {
    log('The Read Database is completed');
    Database? mydb = await database;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  insert(String table, Map<String, Object?> values) async {
    log('The Insert Database is completed');
    Database? mydb = await database;
    int response = await mydb!.insert(table, values);
    return response;
  }

  update(String table, Map<String, Object?> values,String? myWhere) async {
    log('The Update Database is completed');
    Database? mydb = await database;
    int response = await mydb!.update(table, values,where: myWhere);
    return response;
  }

  delet(String table,String? myWhere) async {
    log('The Delete Database is completed');
    Database? mydb = await database;
    int response = await mydb!.delete(table,where: myWhere);
    return response;
  }
}
