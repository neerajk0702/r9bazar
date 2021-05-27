import 'package:path/path.dart';
import 'package:rbazaar/App/model/AddTocartLocal.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static final DBHelper _instance = new DBHelper.internal();

  factory DBHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "rbazaar.db");
    var theDb = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
    /*  await db.execute("CREATE TABLE ProductDetails ("
          "dsno INTEGER,"
          "productName TEXT,"
          "aliasName TEXT,"
          "saleRate REAL,"
          "quantityLocal REAL,"
          "grossweight REAL,"
          "netweight REAL,"
          "imagePath TEXT,"
          "category TEXT"
          ")");*/
      await db.execute(
          'CREATE TABLE ProductDetails (dsno INTEGER,productName TEXT, aliasName TEXT, saleRate REAL,quantityLocal REAL,'
              'grossweight REAL,netweight REAL,totalNetweight REAL,imagePath TEXT,category TEXT,patternid INTEGER, weight REAL, unit TEXT,mainproductsno INTEGER,purchaserate REAL, mrp REAL,discountpercent REAL)');
    });
    return theDb;
  }

  DBHelper.internal();


  Future<bool> upsertProduct(var addTocartLocal) async {
    bool updateDone;
    var productChecked = await getProduct(addTocartLocal.dsno);
    var dbClient = await db;
    if (productChecked != null) {
      var rowUpdated =await dbClient.update('ProductDetails', addTocartLocal.toMap(), where: 'dsno = ?', whereArgs: [addTocartLocal.dsno]);
      print('Update done*****'+rowUpdated.toString());
      updateDone = rowUpdated > 0 ? true : false;
    } else {
      int resSave = await insertProduct(addTocartLocal);
      print('Inster done*****'+resSave.toString());
      updateDone = resSave > 0 ? true : false;
    }
    return updateDone;
  }
  Future<bool> productUpdate(AddTocartLocal addTocartLocal) async {
    bool updateDone;
    var dbClient = await db;
    var rowUpdated =await dbClient.update('ProductDetails', addTocartLocal.toMap(), where: 'dsno = ?', whereArgs: [addTocartLocal.dsno]);
    updateDone = rowUpdated > 0 ? true : false;
    return updateDone;
  }

  Future<int> insertProduct(var addTocartLocal) async {
    var dbClient = await db;
    var result=await dbClient.insert(
      'ProductDetails',
      addTocartLocal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // user.dsno = await dbClient.insert("ProductDetails", user.toMap());
    return result;
  }

  Future<AddTocartLocal> getProduct(int id) async {
    var dbClient = await db;
    // var result = await db.query("ProductDetails", where: "dsno = ", whereArgs: [id]);
    List<Map> maps = await dbClient.query("ProductDetails",
        columns: [
          "dsno",
          "productName",
          "aliasName",
          "saleRate",
          "quantityLocal",
          "grossweight",
          "netweight",
          "totalNetweight",
          "imagePath",
          "category",
          "patternid",
          "weight",
          "unit",
          "mainproductsno",
          "purchaserate",
          "mrp",
          "discountpercent"
        ],
        where: "dsno = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return AddTocartLocal.fromMap(maps.first);
    }
    return null;
  }
 /* Future<List> getAllProduct() async {
    List<AddTocartLocal> product = List();
    var dbClient = await db;
    List<Map> maps = await dbClient.query('ProductDetails', columns: ['dsno', 'productName','aliasName','saleRate','quantityLocal'
        'grossweight','netweight','imagePath','category']);
    if (maps.length > 0) {
      maps.forEach((f) {
        product.add(AddTocartLocal.fromMap(f));
//          print("getAllUsers"+ User.fromMap(f).toString());
      });
    }
    return product;
  }*/
  Future<List<AddTocartLocal>> getAllProduct() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('ProductDetails', columns: ['dsno', 'productName','aliasName','saleRate','quantityLocal','grossweight','netweight','totalNetweight','imagePath','category','patternid','weight','unit','mainproductsno','purchaserate','mrp','discountpercent']);
    List<AddTocartLocal> proList = [];
    print('cart ProductDetails list***********'+maps.length.toString());
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        proList.add(AddTocartLocal.fromMap(maps[i]));
      }
    }
    return proList;
  }

  Future<List<Map>> getAllProducts() async {
    var dbClient = await db;
    /*List<Map> maps = await dbClient.query('ProductDetails', columns: ['dsno', 'productName','aliasName','saleRate','quantityLocal','grossweight','netweight','imagePath','category']);
    List<AddTocartLocal> proList = [];
    print('cart ProductDetails list***********'+maps.length.toString());
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        proList.add(AddTocartLocal.fromMap(maps[i]));
      }
    }*/
    var res  = await dbClient.query('ProductDetails', columns: ['dsno', 'productName','aliasName','saleRate','quantityLocal','grossweight','netweight','totalNetweight','imagePath','category','patternid','weight','unit','mainproductsno','purchaserate','mrp','discountpercent']);

    List<AddTocartLocal> proListl =res.isNotEmpty ? res.map((c) => AddTocartLocal.fromMap(c)).toList() : null;
    // List<AddTocartLocal>.from(proList.where((i) => i.dsno== true));
    return res;
  }



  Future<bool> deleteProduct(int id) async {
    bool updateDone;
    var dbClient = await db;
    var rowUpdated =await dbClient.delete('ProductDetails', where: 'dsno = ?', whereArgs: [id]);
    updateDone = rowUpdated > 0 ? true : false;
    return updateDone;
  }
  Future<bool> deleteAllProduct() async {
    bool updateDone;
    var dbClient = await db;
    var rowUpdated =await dbClient.delete('ProductDetails');
    updateDone = rowUpdated > 0 ? true : false;
    return updateDone;
  }
/* Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableUser, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(User user) async {
    var dbClient = await db;
    return await dbClient.update(tableUser, user.toMap(),
        where: '$columnId = ?', whereArgs: [user.id]);
  }

  Future<List> getAllUsers() async {
    List<User> user = List();
    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableUser,
        columns: [columnId, columnName, columnPhone, columnEmail]);
    if (maps.length > 0) {
      maps.forEach((f) {
        user.add(User.fromMap(f));
//          print("getAllUsers"+ User.fromMap(f).toString());
      });
    }
    return user;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }*/
}
