import 'package:path/path.dart' show join;
import 'file:///D:/Neeraj/git%20project/rbazaar/lib/App/model/AddTocartLocal.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;

class DBHelperNew {
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'rbazaarshop.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
   /* await db
        .execute('CREATE TABLE employee (id INTEGER PRIMARY KEY, name TEXT, phone TEXT)');*/
    await db.execute(
        'CREATE TABLE ProductDetails (dsno INTEGER PRIMARY KEY, productName TEXT, aliasName TEXT, saleRate REAL,quantityLocal REAL,grossweight REAL,netweight REAL,imagePath REAL,category TEXT)');
  }
  // Future<QuizResultRequest> saveQuizResult(var requestParam) async {
  Future<AddTocartLocal> add(var addTocartLocal) async {
    var dbClient = await db;
    addTocartLocal.dsno = await dbClient.insert('ProductDetails', addTocartLocal.toMap());
    return addTocartLocal;
  }

  /*Future<List<Employee>> getEmployee() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('employee', columns: ['id', 'name','phone']);
    List<Employee> employees = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        employees.add(Employee.fromMap(maps[i]));
      }
    }
    return employees;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'employee',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Employee employee) async {
    var dbClient = await db;
    return await dbClient.update(
      'employee',
      employee.toMap(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }*/

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}