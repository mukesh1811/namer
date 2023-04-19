import 'package:namer/FavsDataModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper
{

  static const int versionNo = 1;
  static const String _dbname = "Favs.db";

  static Future<Database> _getDB() async
  {
    String qry = "CREATE TABLE favs(favword TEXT NOT NULL);";
    return openDatabase(join( await getDatabasesPath(), _dbname),
      onCreate: (db,version) async => await db.execute(qry),
      version: versionNo,
    );
  }

  static Future<int> addWord(FavsDataModel favWord) async
  {
    final db = await _getDB();

    return await db.insert("favs", favWord.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<int> deleteWord(FavsDataModel favWord) async
  {
    final db = await _getDB();

    return await db.delete(
      "favs",
      where: 'favWord = ?',
      whereArgs: [favWord.favWord],
    );
  }

  static Future<List<FavsDataModel>> getAllWords() async
  {
    final db = await _getDB();

    final List<Map<String,dynamic>> allWords = await db.query('favs');

    // if (allWords.isEmpty)
    //   {
    //     return null;
    //   }

    return List.generate(allWords.length, (index)
      {
        return FavsDataModel(favWord: allWords[index]['favWord']);
      }
    );
  }

}