import 'package:flutter/material.dart';

class AddSessionDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddSession;

  const AddSessionDialog({Key? key, required this.onAddSession}) : super(key: key);

  @override
  _AddSessionDialogState createState() => _AddSessionDialogState();
}

class _AddSessionDialogState extends State<AddSessionDialog> {
  final _subjectController = TextEditingController();
  final _classController = TextEditingController();
  final _roomController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  
  void _submit() {
    if (_subjectController.text.isEmpty || 
        _classController.text.isEmpty || 
        _roomController.text.isEmpty || 
        _startTimeController.text.isEmpty || 
        _endTimeController.text.isEmpty) {
      // Show an error if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields are required')));
      return;
    }

    final newSession = {
      'subject_id': _subjectController.text,
      'class_id': _classController.text,
      'room_id': _roomController.text,
      'start_time': _startTimeController.text,
      'end_time': _endTimeController.text,
    };

    widget.onAddSession(newSession);  
    Navigator.of(context).pop(); 
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Session'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(labelText: 'Subject ID'),
            ),
            TextField(
              controller: _classController,
              decoration: InputDecoration(labelText: 'Class ID'),
            ),
            TextField(
              controller: _roomController,
              decoration: InputDecoration(labelText: 'Room ID'),
            ),
            TextField(
              controller: _startTimeController,
              decoration: InputDecoration(labelText: 'Start Time'),
            ),
            TextField(
              controller: _endTimeController,
              decoration: InputDecoration(labelText: 'End Time'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: _submit,
          child: Text('Add Session'),
        ),
      ],
    );
  }
}
