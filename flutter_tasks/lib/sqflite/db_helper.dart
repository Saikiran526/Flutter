import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{

  ///table name and column names of notes
  static final String TABLE_NOTE="note";
  static final String COLUMN_NOTE_SNO="s_no";
  static final String COLUMN_NOTE_TITLE="title";
  static final String COLUMN_NOTE_DESC="desc";

  ///Table and Column Names of users
  static final String TABLE_USERS="users";
  static final String COLUMN_SNO="sno";
  static final String COLUMN_NAME="name";
  static final String COLUMN_EMAIL="email";
  static final String COLUMN_PASSWORD="password";

  ///Table and Column names of todos
    static final String TABLE_TODOS="todos";
    static final String COLUMN_TODO_SNO="sno";
    static final String COLUMN_TODO_TITLE="title";
    static final String COLUMN_TODO_DESC="desc";

  ///singleton
  DBHelper._();

  ///single instance to get the info from the database
  static final DBHelper getInstance=DBHelper._();

  ///Create a database
  Database? myDB;

  ///Database Open ( if exist open else create )
  Future<Database> getDB() async {
    myDB = myDB ?? await openDB();
    return myDB!;
  }

  ///If the db not exist we have to create the database
  Future<Database> openDB() async {
    Directory appDir= await getApplicationDocumentsDirectory();
    String dbPath=join(appDir.path,"noteDb1.db");
    print("Database path: $dbPath");
    return await openDatabase(dbPath,onCreate: (db,version){
      db.execute('CREATE TABLE $TABLE_NOTE ($COLUMN_NOTE_SNO integer primary key autoincrement,$COLUMN_NOTE_TITLE text ,$COLUMN_NOTE_DESC text)');
      db.execute('CREATE TABLE $TABLE_USERS ($COLUMN_SNO integer primary key autoincrement,$COLUMN_NAME text,$COLUMN_EMAIL text,$COLUMN_PASSWORD text)');
      print('Tables Created successfully');
    },version: 2,
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            await db.execute(
                'CREATE TABLE IF NOT EXISTS $TABLE_USERS ($COLUMN_SNO INTEGER PRIMARY KEY AUTOINCREMENT, $COLUMN_NAME TEXT, $COLUMN_EMAIL TEXT, $COLUMN_PASSWORD TEXT)');
            print('Users Table Created Successfully in Upgrade');
          }
        }
    );
  }

  /// Insert into userTable
  Future<bool> addUser({required String mName,required String mEmail,required String mPassword}) async {
    var db= await getDB();
    int rowsEffected=await db.insert(TABLE_USERS,{
      COLUMN_NAME:mName,
      COLUMN_EMAIL:mEmail,
      COLUMN_PASSWORD:mPassword,
    });
    return rowsEffected>0;
  }

  /// Retrieve all users and print them
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    var db = await getDB();
    List<Map<String, dynamic>> users = await db.query(TABLE_USERS);

    if (users.isNotEmpty) {
      print("Users in Database:");
      for (var user in users) {
        print("S.No: \${user[COLUMN_SNO]}, Name: \${user[COLUMN_NAME]}, Email: \${user[COLUMN_EMAIL]}, Password: \${user[COLUMN_PASSWORD]}");
      }
    } else {
      print("No users found.");
    }
    return users;
  }

  /// Insert Data into note table
  Future<bool> addNote({required String mTitle,required String mDesc}) async {
    var db= await getDB();
    int rowsEffected=await db.insert(TABLE_NOTE, {
      COLUMN_NOTE_TITLE:mTitle,
      COLUMN_NOTE_DESC:mDesc,
    });
    return rowsEffected>0;
  }

  ///Select all Data-Select * from note
  Future<List<Map<String,dynamic>>> getAllDetails() async {
    var db= await getDB();
    List<Map<String,dynamic>> mData =await db.query(TABLE_NOTE);
    return mData;
  }

  ///Update data
  Future<bool> updateNote({required String mTitle,required String mDesc,required int sno }) async {
    var db= await getDB();
    int rowsEffected=await db.update(TABLE_NOTE, {
      COLUMN_NOTE_TITLE:mTitle,
      COLUMN_NOTE_DESC:mDesc,
    }, where:"$COLUMN_NOTE_SNO=$sno" );
    return rowsEffected>0;
  }

  ///Delete data
  Future<bool> deleteNote ({required int sno}) async  {
    var db= await getDB();
    int rowsEffected= await db.delete(TABLE_NOTE,where: "$COLUMN_NOTE_SNO=?",whereArgs: [sno]);
    return rowsEffected>0;
  }
}
