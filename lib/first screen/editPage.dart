import 'package:flutter/material.dart';
import '../dataBaseHelper/dataBaseHelper.dart';
import '../dataBaseHelper/model.dart';
import '../listScreeen.dart';

// ignore: must_be_immutable
class EditPage extends StatefulWidget {
  Model model;
  final String page;
  int noteID;
  EditPage(this.model, this.page, this.noteID);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController noteTitle = TextEditingController();
  TextEditingController noteContent = TextEditingController();
  Color theme = Color(0xff458766);

  DatabaseHelper helper;
  @override
  void initState() {
    super.initState();
    helper = DatabaseHelper();
    noteTitle.text = widget.model.noteTitle;
    noteContent.text = widget.model.noteContent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(38, 44, 63, 1.0),
        appBar: AppBar(
          backgroundColor: theme,
          title: Text('Edit Note'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: <Widget>[
              TextField(
                controller: noteTitle,
                style: TextStyle(color: Colors.white),
              ),
              TextField(
                maxLines: null,
                controller: noteContent,
                style: TextStyle(color: Colors.white),
              ),
              FlatButton.icon(
                color: Colors.white54,
                icon: Icon(Icons.save),
                label: Text('Save', style: TextStyle(fontSize: 25)),
                onPressed: () {
                  // print("ID= ${widget.model.id}");
                  var editNote = Model({
                    'ID': widget.model.id,
                    'NoteTitle': noteTitle.text,
                    'NoteContent': noteContent.text,
                    'SID': widget.noteID
                  });
                  helper.updateCourse(editNote);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          ListScreen(widget.page, widget.noteID)));
                },
              ),
            ],
          ),
        ));
  }
}
