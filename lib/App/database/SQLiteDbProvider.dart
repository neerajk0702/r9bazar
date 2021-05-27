import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rbazaar/App/model/AddTocartLocal.dart';
import 'package:rbazaar/App/productdetails/ProductDetailsModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;


class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;
    _database = await initDB();
    return _database;
  }
  Future close() async {
    var dbClient = await database;
    dbClient.close();
  }

  initDB() async {
    Directory documentsDirectory = await
    getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Rbazaar.db");
    return await openDatabase(
        path, version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE ProductDetails ("
                  "dsno INTEGER,"
                  "productName TEXT,"
                  "aliasName TEXT,"
                  "saleRate TEXT,"
                  "quantityLocal TEXT,"
                  "grossweight TEXT,"
                  "netweight TEXT,"
                  "imagePath TEXT,"
                  "category TEXT"
                  ")"
          );
        }
    );
  }
  Future<AddTocartLocal> getProductById(int id) async {
    final db = await database;
    var result = await db.query("ProductDetails", where: "dsno = ", whereArgs: [id]);
    return result.isNotEmpty ? AddTocartLocal.fromMap(result.first) : Null;
  }

  insert(AddTocartLocal product) async {
    final db = await database;
    var result = await db.rawInsert(
        "INSERT Into ProductDetails (dsno, productName, aliasName, saleRate, quantityLocal,grossweight,netweight,imagePath,category)"
            " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
        [product.dsno, product.productName, product.aliasName, product.saleRate, product.quantityLocal,product.grossweight,product.netweight
          ,product.imagePath,product.category]
    );
    return result;
  }
  /*Future<List<Product>> getAllProducts() async {
    final db = await database;
    List<Map> results = await db.query(
        "Product", columns: Product.columns, orderBy: "id ASC"
    );
    List<Product> products = new List();
    results.forEach((result) {
      Product product = Product.fromMap(result);
      products.add(product);
    });
    return products;
  }
  Future<Product> getProductById(int id) async {
    final db = await database;
    var result = await db.query("Product", where: "id = ", whereArgs: [id]);
    return result.isNotEmpty ? Product.fromMap(result.first) : Null;
  }
  insert(Product product) async {
    final db = await database;
    var maxIdResult = await db.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM Product");
    var id = maxIdResult.first["last_inserted_id"];
    var result = await db.rawInsert(
        "INSERT Into Product (id, name, description, price, image)"
            " VALUES (?, ?, ?, ?, ?)",
        [id, product.name, product.description, product.price, product.image]
    );
    return result;
  }
  update(Product product) async {
    final db = await database;
    var result = await db.update(
        "Product", product.toMap(), where: "id = ?", whereArgs: [product.id]
    );
    return result;
  }
  delete(int id) async {
    final db = await database;
    db.delete("Product", where: "id = ?", whereArgs: [id]);
  }*/
}