import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'newtask.dart';

import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('   Todo List'),
          backgroundColor: Color(0xFFFA7397),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder(
                    stream:
                        Firestore.instance.collection("todolist").snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return const Text('Loading....');
                      return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) => buildListItem(
                            context, snapshot.data.documents[index]),
                      );
                    }),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFFA7397),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewTask(), fullscreenDialog: true));
          },
        ));
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot document) {
    return Dismissible(
      key: Key(document.documentID),
      onDismissed: (DismissDirection direction) {
        direction = DismissDirection.endToStart;

        Firestore.instance
            .collection("todolist")
            .document(document.documentID)
            .delete();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
        child: Card(
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.cyan,
                      child: Icon(
                        Icons.access_alarm,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        document['taskname'],
                        style: TextStyle(fontSize: 30.0),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      document['taskdate'],
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      document['tasktime'],
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
