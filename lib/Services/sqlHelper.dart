import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper{ 

  static const String table_name = 'users';
  static const String C_UserID = 'user_id';
  static const String C_Email = 'user_email';
  static const String C_Password = 'password';
  static const String C_UserName = 'user_name';

  static Future<void> createTables(sql.Database database)async{
    await database.execute("""CREATE TABLE $table_name(
      $C_UserID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $C_Email TEXT NOT NULL,
      $C_Password TEXT NOT NULL, 
      $C_UserName TEXT NOT NULL)""") ;

    await database.execute("""CREATE TABLE messages(
      chat_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      sender TEXT NOT NULL,
      receiver TEXT NOT NULL, 
      message TEXT NOT NULL,
      createdAt TIMESTAMP DEFAULT (datetime('now', 'localtime')) NOT NULL
      )""") ;
  }

  static Future<sql.Database> db() async{
    return sql.openDatabase(
      'new_db.db',
      version: 1,
      onCreate: (sql.Database database,int version) async{
        await createTables(database);
      }
    );
  } 

  static Future<int> addUser(String user_email, String password, String user_name) async{
    final db = await SQLHelper.db();
    final data = {'user_email': user_email,'password':password,'user_name':user_name};
    final id = await db.insert('users', data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> addMessages(String sender, String receiver, String message) async{
    final db = await SQLHelper.db();
    final data = {'sender': sender,'receiver':receiver,'message':message};
    final id = await db.insert('messages', data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String,dynamic>>> getUsers() async{
    final db = await SQLHelper.db();
    return db.query('users',orderBy: "user_id");
  }

  static Future<List<Map<String,dynamic>>> getUserEmail(String email) async{
    final db = await SQLHelper.db();
     final result = await db.rawQuery(
      'SELECT user_id FROM $table_name WHERE user_email=?', [email]);
    return result; 
  }

  static Future<List<Map<String,dynamic>>> getMessages(String username,String receiverName) async{
    final db = await SQLHelper.db();
     final result = await db.rawQuery(
      'SELECT message,createdAt,sender FROM messages WHERE sender IN (?, ?) AND receiver IN (?, ?)', [username,receiverName,username,receiverName]);
    return result; 
  }

  static Future<List<Map<String,dynamic>>> getUserName(String uname) async{
    final db = await SQLHelper.db();
     final result = await db.rawQuery(
      'SELECT user_id FROM $table_name WHERE user_name=?', [uname]);
    return result; 
  }

   static Future<List<Map<String,dynamic>>> checkUser(String email,String password) async{
    final db = await SQLHelper.db();
     final result = await db.rawQuery(
      'SELECT user_id FROM $table_name WHERE user_email=? AND password=?', [email,password]);
      return result; 
  }

  static Future<List<Map<String,dynamic>>> setUserName(String email) async{
    final db = await SQLHelper.db();
     final result = await db.rawQuery(
    'SELECT user_name FROM $table_name WHERE user_email=?', [email]);
    return result; 
  }

  static Future<List<Map<String,dynamic>>> getUser(String email) async{
    final db = await SQLHelper.db();
    return db.query('users',where: "user_email = ?",whereArgs: [email],limit: 1);
  }

  Future<String?> getSingleUsername(String email) async {
    final db = await SQLHelper.db();
    final result = await db.query('users',where: "user_email = ?",whereArgs: [email], limit: 1);   
    if (result.isNotEmpty) {
      String? value = result.first['user_name'].toString();
      return value ;
    }
    else{
       return null;
    }
  }

  static Future<List<Map<String,dynamic>>> getUsernames(String useremail) async{
    final db = await SQLHelper.db();
   final result = await db.rawQuery(
      'SELECT user_name FROM $table_name WHERE user_email <> ?',  [useremail]);
    return result; 
  }

  static Future<int> updateUserName(String newUsername,String oldUsername)async{
    final db = await SQLHelper.db();
    final data = {'user_name': newUsername,};
    final result = await db.update('users',data,where: "user_name = ?",whereArgs: [oldUsername]);
    return result;
  }
}
  


  
  


