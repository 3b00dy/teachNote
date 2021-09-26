import 'package:flutter/material.dart';
import '../dataBaseHelper/model.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper.internal();
  static Database _db;
  Future<Database> createDAtabase() async {
    if (_db != null) {
      return _db;
    }
    //define the path to the database
    String path = join(await getDatabasesPath(), 'notesdb');
    _db = await openDatabase(path, version: 1, onCreate: (Database db, int v) {
      //create tables
      db.execute(
          'create table FirstStageNOTES(ID integer primary key autoincrement, NoteTitle TEXT NOT NULL, NoteContent TEXT,SID NUMBER)');
    });
    return _db;
  }

  Future<int> create(Model model) async {
    Database db = await createDAtabase();
    return db.insert('FirstStageNOTES', model.toMap());
  }

  Future<List> allNotes(int sid) async {
    Database db = await createDAtabase();
    return db.query('FirstStageNOTES', where: "SID= ?", whereArgs: [sid]);
  }

  Future<int> delete(int id) async {
    Database db = await createDAtabase();
    return db.delete('FirstStageNOTES', where: 'ID=?', whereArgs: [id]);
  }

  Future<int> deleteAll(int sid) async {
    Database db = await createDAtabase();
    return db.delete('FirstStageNOTES', where: "SID= ?", whereArgs: [sid]);
  }

  Future<int> updateCourse(Model model) async {
    Database db = await createDAtabase();
    return await db.update('FirstStageNOTES', model.toMap(),
        where: 'ID = ?', whereArgs: [model.id]);
  }
}
