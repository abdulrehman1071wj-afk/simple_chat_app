import 'local_database.dart';
import 'package:sqflite/sqflite.dart';

class MessageLocalDataSource {
  Future<void> cacheMessage(Map<String, dynamic> message) async {
    final db = await LocalDatabase.database;

    await db.insert(
      'messages',
      message,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getMessages(
      String senderId, String receiverId) async {
    final db = await LocalDatabase.database;

    return await db.query(
      'messages',
      where:
      '(senderId = ? AND receiverId = ?) OR (senderId = ? AND receiverId = ?)',
      whereArgs: [senderId, receiverId, receiverId, senderId],
    );
  }
}
