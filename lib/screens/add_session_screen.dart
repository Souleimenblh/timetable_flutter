import 'package:flutter/material.dart';
import '../models/session.dart';

class AddEditSessionScreen extends StatefulWidget {
  final Session? session;

  
  AddEditSessionScreen({Key? key, this.session}) : super(key: key);

  @override
  _AddEditSessionScreenState createState() => _AddEditSessionScreenState();
}

class _AddEditSessionScreenState extends State<AddEditSessionScreen> {
  late TextEditingController subjectController;
  late TextEditingController teacherController;
  late TextEditingController roomController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late TextEditingController sessionDateController;

  
  @override
  void initState() {
    super.initState();
    subjectController = TextEditingController(text: widget.session?.subjectId ?? '');
    teacherController = TextEditingController(text: widget.session?.teacherId ?? '');
    roomController = TextEditingController(text: widget.session?.roomId ?? '');
    startTimeController = TextEditingController(text: widget.session?.startTime ?? '');
    endTimeController = TextEditingController(text: widget.session?.endTime ?? '');
    sessionDateController = TextEditingController(text: widget.session?.sessionDate ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.session == null ? 'Add Session' : 'Edit Session'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            TextField(
              controller: subjectController,
              decoration: InputDecoration(
                labelText: 'Subject ID',
                labelStyle: TextStyle(color: Colors.teal),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            
            TextField(
              controller: teacherController,
              decoration: InputDecoration(
                labelText: 'Teacher ID',
                labelStyle: TextStyle(color: Colors.teal),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            
            TextField(
              controller: roomController,
              decoration: InputDecoration(
                labelText: 'Room ID',
                labelStyle: TextStyle(color: Colors.teal),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            
            TextField(
              controller: startTimeController,
              decoration: InputDecoration(
                labelText: 'Start Time',
                labelStyle: TextStyle(color: Colors.teal),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            
            TextField(
              controller: endTimeController,
              decoration: InputDecoration(
                labelText: 'End Time',
                labelStyle: TextStyle(color: Colors.teal),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            
            TextField(
              controller: sessionDateController,
              decoration: InputDecoration(
                labelText: 'Session Date (YYYY-MM-DD)',
                labelStyle: TextStyle(color: Colors.teal),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () {
                final newSession = Session(
                  sessionId: widget.session?.sessionId ?? DateTime.now().toString(), // Generate new ID if it's a new session
                  subjectId: subjectController.text,
                  teacherId: teacherController.text,
                  roomId: roomController.text,
                  classId: '', 
                  sessionDate: sessionDateController.text,
                  startTime: startTimeController.text,
                  endTime: endTimeController.text,
                );

                
                Navigator.pop(context, newSession);
              },
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}