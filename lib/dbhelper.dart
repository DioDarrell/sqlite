import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite/item_customer.dart';
import 'item.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'item.db';

    //create, read databases
    var itemDatabase = openDatabase(path, version: 4, onCreate: _createDb, onUpgrade: _onUpgrade);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return itemDatabase;
  }
void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      // db.execute(""); // SQL Query
    }
  }
  //buat tabel baru dengan nama item
  void _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE item (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    price INTEGER,
    stock INTEGER,
    kode TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE customer (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    kode TEXT,
    alamat TEXT,
    jumlah INTEGER
    )
    ''');
  }

  //select databases
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.initDb();
    var mapList = await db.query('item', orderBy: 'name');
    return mapList;
  }

Future<List<Map<String, dynamic>>> selectCustomer() async {
    Database db = await this.initDb();
    var mapList = await db.query('customer', orderBy: 'name');
    return mapList;
  }
  //create databases
  Future<int> insert(Item object) async {
    Database db = await this.initDb();
    int count = await db.insert('item', object.toMap());
    return count;
  }

Future<int> insertC(ItemCustomer object) async {
    Database db = await this.initDb();
    int count = await db.insert('customer', object.toMap());
    return count;
  }
//update databases
  Future<int> update(Item object) async {
    Database db = await this.initDb();
    int count = await db
        .update('item', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

Future<int> updateC(ItemCustomer object) async {
    Database db = await this.initDb();
    int count = await db
        .update('customer', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }
//delete databases
  Future<int> delete(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('item', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Item>> getItemList() async {
    var itemMapList = await select();
    int count = itemMapList.length;
    List<Item> itemList = List<Item>();
    for (int i = 0; i < count; i++) {
      itemList.add(Item.fromMap(itemMapList[i]));
    }
    return itemList;
  }

Future<List<ItemCustomer>> getItemCustomList() async {
    var itemMapList = await selectCustomer();
    int count = itemMapList.length;
    List<ItemCustomer> itemList = List<ItemCustomer>();
    for (int i = 0; i < count; i++) {
      itemList.add(ItemCustomer.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
