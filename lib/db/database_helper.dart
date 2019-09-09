import 'package:my_ecommerce_app/models/product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Singleton class to manage database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";

  // database table and column names
  final String _tableName = "produts";
  final String _columnId = "id";
  final String _columnName = "name";
  final String _columnCategory = "category";
  final String _columnBrand = "brand";
  final String _columnImage = "image";
  final String _columnPrice = "price";
  final String _columnQuantity = "quantity";
  final String _columnColor = "color";
  final String _columnSize = "size";


  // Increment this version when you need to change the schema
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    /* // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();*/
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

// SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $_tableName ("
        "$_columnId TEXT,$_columnName TEXT,$_columnBrand TEXT,$_columnCategory TEXT,$_columnImage TEXT,$_columnColor TEXT,$_columnSize TEXT,$_columnPrice INTEGER,$_columnQuantity INTEGER)");
  }

  Future<int> insert(ProductModel model)async{
    final Database db=await database;
    // `conflictAlgorithm` to use in case the same model is inserted twice.
    // replace any previous data.
    int id=await db.insert(_tableName,model.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<ProductModel>> queryAll() async{

   final Database db=await database;

   final List<Map<String,dynamic>> maps=await db.query(_tableName);

   return List.generate(maps.length, (i){
     return ProductModel(
       prodId: maps[i]['id'],
       prodName: maps[i]['name'],
       prodImage: maps[i]['image'],
       prodCategory: maps[i]['category'],
       prodBrand: maps[i]['brand'],
       prodPrice: maps[i]['price'],
       quantity: maps[i]['quantity'],
     );
   });
  }

  Future<List<String>> queryIds() async{
    final Database db=await database;

    final List<Map<String,dynamic>> maps=await db.query(_tableName,columns: ["id"]);
    return List.generate(maps.length, (i){
      return (
         maps[i]['id']
      );
    });
  }
  Future<List<int>> queeryPrices() async{
    final Database db=await database;

    final List<Map<String,dynamic>> maps=await db.query(_tableName,columns: ["price"]);
    return List.generate(maps.length, (i){
      return (
          maps[i]['price']
      );
    });
  }
  Future<void> delete(String id)async{
    final Database db=await database;

    await db.delete(_tableName,
        // Use a `where` clause to delete a specific product.
        where:"id = ?",
        // Pass the product id as a whereArg to prevent SQL injection.
        whereArgs: [id],
    );
  }
  Future<void> deleteAll()async{
    final Database db=await database;

    await db.delete(_tableName,);
  }
}
