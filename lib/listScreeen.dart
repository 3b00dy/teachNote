import 'dart:io';

import 'package:flutter/material.dart';
import 'dataBaseHelper/dataBaseHelper.dart';
import 'dataBaseHelper/model.dart';
import 'first screen/addNote.dart';
import 'first screen/editPage.dart';

class ListScreen extends StatefulWidget {
  final String page;
  final int noteID;
  ListScreen(this.page, this.noteID);

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<ListScreen> {
  DatabaseHelper helper;
  Color theme = Color(0xff458766);

  @override
  void initState() {
    super.initState();
    helper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(38, 44, 63, 1.0),
      appBar: AppBar(
        backgroundColor: theme,
        title: Text("${widget.page} "),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete_forever_sharp,
              color: Colors.amber,
              size: 35,
            ),
            onPressed: () {
              setState(() {
                final AlertDialog alert = AlertDialog(
                  title: Text("Are you sure?"),
                  content: Container(
                      height: 112,
                      child: Column(
                        children: [
                          Divider(color: Colors.red),
                          Text(
                              "Are you sure you want to delete all note of this stage?"),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              FlatButton(
                                color: Colors.green,
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                              SizedBox(
                                width: 90,
                              ),
                              FlatButton(
                                color: Colors.redAccent,
                                child: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    helper.deleteAll(widget.noteID);
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      )),
                );
                showDialog(context: context, child: alert);
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: helper.allNotes(widget.noteID),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  Model myNote = Model.fromMap(snapshot.data[i]);

                  return Card(
                    child: ListTile(
                      title: Text('${myNote.noteTitle}'),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            final AlertDialog alert = AlertDialog(
                              title: Text("Are you sure?"),
                              content: Container(
                                  height: 112,
                                  child: Column(
                                    children: [
                                      Divider(color: Colors.red),
                                      Text(
                                          "If you delete this note you will never get it back"),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          FlatButton(
                                            color: Colors.green,
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                Navigator.pop(context);
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 90,
                                          ),
                                          FlatButton(
                                            color: Colors.redAccent,
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                helper.delete(myNote.id);
                                                Navigator.pop(context);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            );
                            showDialog(context: context, child: alert);
                          });
                        },
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                EditPage(myNote, widget.page, widget.noteID)));
                      },
                    ),
                  );
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AddNote(widget.page, widget.noteID)),
          );
        },
        tooltip: 'Add New Note',
        child: Icon(Icons.add),
      ),
    );
  }
}
