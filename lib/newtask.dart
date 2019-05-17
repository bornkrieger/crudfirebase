import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewTask extends StatefulWidget {
  NewTask();

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  //defining strings for the purpose of getters

  String taskname, taskdetails, taskdate, tasktime;

  getTaskName(taskname) {
    this.taskname = taskname;
  }

  getTaskDetails(taskdetails) {
    this.taskdetails = taskdetails;
  }

  getTaskDate(taskdate) {
    this.taskdate = taskdate;
  }

  getTaskTime(tasktime) {
    this.tasktime = tasktime;
  }

  int myTaskType = 0;
  String taskVal;

  void handleTaskType(int value) {
    setState(() {
      myTaskType = value;

      switch (myTaskType) {
        case 1:
          taskVal = 'travel';
          break;

        case 2:
          taskVal = 'shopping';
          break;

        case 3:
          taskVal = 'gym';
          break;

        case 4:
          taskVal = 'party';
          break;

        case 5:
          taskVal = 'others';
          break;
      }
    });
  }

  createData() {
DocumentReference dbref = Firestore.instance.collection("todolist").document(taskname);

Map<String,dynamic> tasks = {

  "taskname" : taskname,
  "taskdetails":taskdetails,
  "tasktime":tasktime,
  "taskdate":taskdate,
  "tasktype":taskVal,


};
dbref.setData(tasks).whenComplete((){
  Navigator.of(context).pop();
});
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("New Task"),
        backgroundColor: Color(0xFFFA7397),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextField(
                      onChanged: (String name) {
                        getTaskName(name);
                      },
                      decoration: InputDecoration(labelText: 'Task: '),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextField(
                      onChanged: (String taskdetails) {
                        getTaskDetails(taskdetails);
                      },
                      decoration: InputDecoration(labelText: 'Details: '),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextField(
                      onChanged: (String taskdetails) {
                        getTaskDate(taskdetails);
                      },
                      decoration: InputDecoration(labelText: 'Date: '),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextField(
                      onChanged: (String tasktime) {
                        getTaskTime(tasktime);
                      },
                      decoration: InputDecoration(labelText: 'Time: '),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      'Select Task Type',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: myTaskType,
                            //this is defined if more than one group of radio button is used.
                            onChanged: handleTaskType,
                            activeColor: Color(0xff41588ba),
                          ),
                          Text('Travel', style: TextStyle(fontSize: 16.0))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            value: 2,
                            groupValue: myTaskType,
                            //this is defined if more than one group of radio button is used.
                            onChanged: handleTaskType,
                            activeColor: Color(0xff41588ba),
                          ),
                          Text('Shopping', style: TextStyle(fontSize: 16.0))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            value: 3,
                            groupValue: myTaskType,
                            //this is defined if more than one group of radio button is used.
                            onChanged: handleTaskType,
                            activeColor: Color(0xff41588ba),
                          ),
                          Text('Gym', style: TextStyle(fontSize: 16.0))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            value: 4,
                            groupValue: myTaskType,
                            //this is defined if more than one group of radio button is used.
                            onChanged: handleTaskType,
                            activeColor: Color(0xff41588ba),
                          ),
                          Text('Party', style: TextStyle(fontSize: 16.0))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            value: 5,
                            groupValue: myTaskType,
                            //this is defined if more than one group of radio button is used.
                            onChanged: handleTaskType,
                            activeColor: Color(0xff41588ba),
                          ),
                          Text('Others', style: TextStyle(fontSize: 16.0))
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        color: Color(0xFFFA7397),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      RaisedButton(
                        color: Color(0xFFFA7397),
                        onPressed: () {
                          createData();
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
