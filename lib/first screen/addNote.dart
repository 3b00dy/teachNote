import 'package:flutter/material.dart';
import '../dataBaseHelper/dataBaseHelper.dart';
import '../dataBaseHelper/model.dart';
import 'package:toast/toast.dart';
import '../listScreeen.dart';

class AddNote extends StatefulWidget {
  final String page;
  int noteID;
  AddNote(this.page, this.noteID);
  @override
  _FirstStageScreenState createState() => _FirstStageScreenState();
}

class _FirstStageScreenState extends State<AddNote> {
  String noteTitle, noteContent;
  // int sid = 1;
  Color theme = Color(0xff458766);
  DatabaseHelper helper;
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
        title: Text("${widget.page} Stage"),
        centerTitle: true,
      ),
      body: ListView(children: [
        TextField(
          style: TextStyle(color: Colors.white),
          onChanged: (value) {
            noteTitle = value;
          },
          decoration: InputDecoration(
            hintText: "Note Title",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
        TextFormField(
          style: TextStyle(color: Colors.white),
          onChanged: (value) {
            noteContent = value;
          },
          minLines: 2,
          maxLines: 100,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: 'Enter Your Note ',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
        FlatButton.icon(
          color: Colors.white,
          icon: Icon(Icons.save),
          label: Text('Save', style: TextStyle(fontSize: 25)),
          onPressed: () async {
            if (noteTitle != null) {
              Model notes = Model({
                'NoteTitle': noteTitle,
                'NoteContent': noteContent,
                'SID': widget.noteID
              });
              int id = await helper.create(notes);
              print("Id= $id");
              (Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ListScreen(widget.page, widget.noteID),
                  )));
            } else
              Toast.show("Note title is empty!", context,
                  duration: 2, gravity: 1);
          },
        )
      ]),
    );
  }
}
