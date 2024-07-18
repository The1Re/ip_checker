import 'package:ip_checker/model/device.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteHelper {

  final String databaseName = 'ipchecker.db';
  final int version = 1;
  final String tableName = 'tableDevice';

  String colName = 'name';
  final String colIP = 'ip';
  final String colStatus = 'status';
  final String colDateAdd = 'dateAdd';
  final String colLastOff = 'lastOffline';

  SQLiteHelper(){
    initialDatabase();
  }

  Future<Null> initialDatabase() async{
    await openDatabase(join(await getDatabasesPath(), databaseName),
    onCreate: (db, version) {
      return db.execute(
        '''CREATE TABLE $tableName(
        $colName TEXT PRIMARYKEY,
        $colIP TEXT,
        $colStatus INTEGER,
        $colDateAdd TEXT,
        $colLastOff TEXT
        )''',
      );
    },
      version: version
    );
  }

  Future<Database> connectedDatabase()async{
    return await openDatabase(join(await getDatabasesPath(), databaseName));
  }

  Future<void> insert(Device device) async {
    Database db = await connectedDatabase();
    await db.insert(
      tableName, 
      device.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    print("### insert device ${device.name}");
  }

  Future<List<Device>> getDevice() async{
    Database db = await connectedDatabase();
    final List<Device> deviceList = [];
    final List<Map<String, Object?>> maps = await db.query( tableName );
    print('### maps on SQLitHelper ==>> $maps');
    for(var item in maps){
      Device device = Device.fromMap(item);
      deviceList.add(device);
    }
    return deviceList;
  }

  Future<void> delete(Device device) async{
    Database db = await connectedDatabase();
    await db.delete(
      tableName, 
      where: "$colName = '${device.name}'",  
      );
    print('### Deleted row device name = ${device.name}');
  }

  Future<void> update(String name,Device device) async{
    Database db = await connectedDatabase();
    await db.update(
      tableName, 
      device.toMap(), 
      where: "$colName = '$name'", 
      );
  }

  Future<bool> isExist(String chkname) async {
    Database db = await connectedDatabase();
    var result = await db.rawQuery("SELECT * FROM $tableName WHERE name = '$chkname'");
    return (result.isEmpty)? false : true;
  }

  Future<void> emptySQLite() async {
    Database database = await connectedDatabase();
    await database
        .delete(tableName)
        .then((value) => print('### Empty SQLite Success'));
  }
}