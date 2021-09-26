import 'package:flutter/material.dart';
import 'listScreeen.dart';
import './dataBaseHelper/dataBaseHelper.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseHelper helper;
  @override
  void initState() {
    super.initState();
    helper = DatabaseHelper();
  }

  Color theme = Color(0xff458766);

  void goToPage(BuildContext ctx, String page, int noteID) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return ListScreen(page, noteID);
    }));
  }

  @override
  Widget build(BuildContext context) {
    bool isLandScape = MediaQuery.of(context).orientation ==Orientation.landscape;
var mediaQuery=MediaQuery.of(context);
    var _appBar=AppBar(
      title: Text("Teacher Note"),
      backgroundColor: theme,
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(38, 44, 63, 1.0),
      appBar:_appBar,

      body: !isLandScape? Container(
        height:(MediaQuery.of(context).size.height - _appBar.preferredSize.height-MediaQuery.of(context).padding.top)*1 ,
        width: mediaQuery.size.width*1,
          child: Center(

          child: LayoutBuilder(
            builder: (ctx,constraint)=> ListView(children: [
                SizedBox(
                  height: constraint.maxHeight*0.04,
                ),
                Container(
                  width: constraint.maxWidth*1,
                  child: Text(
                    "Choose Section to show or add note",
                    style: TextStyle(
                        color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.06 ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: constraint.maxHeight*0.15,
                ),
                Container(
                  height: constraint.maxHeight*0.60,
                  child: Column(

                    children: [
                      stagesButton(context, "First ", "First", 1),
                      // SizedBox(height: ,),
                      stagesButton(context, "Second ", "Second", 2),
                      stagesButton(context, "Third ", "Third", 3),
                      stagesButton(context, "Fourth ", "Fourth", 4),
                      stagesButton(context, "Others", "Other", 5),
                    ],
                  ),
                ),


                SizedBox(
                  height: constraint.maxHeight*0.08,
                ),
                FlatButton.icon(
                  label: Text(
                    "GC4D",
                    style: TextStyle(color: Colors.white54),
                  ),
                  icon: Icon(
                    Icons.copyright,
                    color: Colors.white54,
                  ),
                  onPressed: () {},
                )
              ]),
          ),
          ),
      ):
      Container(
        height:(MediaQuery.of(context).size.height - _appBar.preferredSize.height-MediaQuery.of(context).padding.top) ,
        child: Center(

          child: LayoutBuilder(
            builder: (ctx,constraint)=> ListView(children: [
              // SizedBox(
              //   height: constraint.maxHeight *0.02,
              // ),
              Container(

                child: Text(
                  "Choose Stage to show or add note",
                  style: TextStyle(
                      color: Colors.white, fontSize: 25, fontFamily: 'Raleway'),
                  textAlign: TextAlign.center,
                ),
              ),

              Container(

                child: Column(

                  children: [
                    stagesButton(context, "First ", "First", 1),
                    // SizedBox(height: ,),
                    stagesButton(context, "Second ", "Second", 2),
                    stagesButton(context, "Third ", "Third", 3),
                    stagesButton(context, "Fourth ", "Fourth", 4),
                    stagesButton(context, "Others", "Other", 5),
                  ],
                ),
              ),


              SizedBox(

              ),
              Container(

                child: FlatButton.icon(
                  label: Text(
                    "GC4D",
                    style: TextStyle(color: Colors.white54),
                  ),
                  icon: Icon(
                    Icons.copyright,
                    color: Colors.white54,
                  ),
                  onPressed: () {},
                ),
              )
            ]),
          ),
        ),
      )

      );

  }

  stagesButton(BuildContext context, String pageName, String page, int noteID) {
    return Container(

      child: Column(
        children: [
          ListTile(
              onTap: () {
                goToPage(context, page, noteID);
              },
              title: Text(
                pageName,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              trailing: Icon(Icons.keyboard_arrow_right,
                  color: Colors.white, size: 30.0)),
        ],
      ),
    );
  }
}
