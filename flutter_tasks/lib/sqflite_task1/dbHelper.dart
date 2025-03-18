// import 'dart:io';
//
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DBHelper{
//
//   ///constructor private becz not to create multiple instances
//   DBHelper._();
//
//   ///Table,Column and Variable Names
//   Database? myDB;
//   static final String TABLE_USERS="users";
//   static final String COLUMN_SNO="sno";
//   static final String COLUMN_NAME="name";
//   static final String COLUMN_EMAIL="email";
//   static final String COLUMN_PASSWORD="password";
//
//
//   ///create single instance
//   static final DBHelper getInstance=DBHelper._();
//
//   getDB() async {
//
//     myDB= myDB ?? await openDB();
//     return myDB;
//
//   }
//
//   Future<Database> openDB() async {
//
//     Directory appDir= await  getApplicationDocumentsDirectory();
//     String dbPath=join(appDir.path,"users.db");
//     return await openDatabase(dbPath,onCreate: (db,version){
//       db.execute('CREATE TABLE $TABLE_USERS ($COLUMN_SNO integer PRIMARY KEY autoincrement,$COLUMN_NAME text,$COLUMN_EMAIL text,$COLUMN_PASSWORD)');
//     },version: 1);
//
//   }
//
//
// }