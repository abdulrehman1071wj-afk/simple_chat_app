import 'local_database.dart';
import 'package:sqflite/sqflite.dart';

class UserLocalDataSource {
  Future<void> cacheUsers(List<Map<String, dynamic>> users) async {
    final db = await LocalDatabase.database;

    for (var user in users) {
      await db.insert(
        'users',
        user,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getCachedUsers() async {
    final db = await LocalDatabase.database;
    return await db.query('users');
  }
}
