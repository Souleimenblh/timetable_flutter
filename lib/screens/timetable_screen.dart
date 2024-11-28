import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'add_edit_session_screen.dart';
import '../models/session.dart';
import '../shared_preferences_helper.dart';
import 'login_screen.dart';

class TimetableScreen extends StatefulWidget {
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  List<Session> sessions = [];
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    loadSessions();
  }

  Future<void> loadSessions() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/db.json');
      final data = json.decode(response);
      final sessionList = data['sessions'] as List;

      setState(() {
        sessions = sessionList
            .map((sessionJson) => Session.fromJson(sessionJson))
            .toList();
      });
    } catch (e) {
      print('Error loading sessions: $e');
    }
  }

  Future<void> saveSessions() async {
    final updatedJson = jsonEncode({
      'sessions': sessions.map((session) => session.toJson()).toList(),
    });

    print("Updated JSON Data: $updatedJson");
  }

  List<Session> _getSessionsForDay(DateTime day) {
    return sessions.where((session) {
      final sessionDate = DateTime.parse(session.sessionDate);
      return sessionDate.year == day.year &&
          sessionDate.month == day.month &&
          sessionDate.day == day.day;
    }).toList();
  }

  void _editSession(Session session) async {
    final updatedSession = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditSessionScreen(session: session),
      ),
    );

    if (updatedSession != null) {
      setState(() {
        sessions = sessions.map<Session>((s) {
          return s.sessionId == updatedSession.sessionId ? updatedSession : s;
        }).toList();
      });
      saveSessions();
    }
  }

  void _deleteSession(Session session) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Session'),
        content: Text('Are you sure you want to delete this session?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                sessions.removeWhere((s) => s.sessionId == session.sessionId);
              });
              saveSessions();
              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _logout() async {
    final confirmLogout = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmLogout == true) {
      await SharedPreferencesHelper.clearLoginState();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Timetable app'),
      centerTitle: true, 
      backgroundColor: Colors.teal,
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 01, 01),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.tealAccent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: _getSessionsForDay(_selectedDay).isEmpty
                ? Center(child: Text('No sessions for this day.'))
                : ListView.builder(
                    itemCount: _getSessionsForDay(_selectedDay).length,
                    itemBuilder: (context, index) {
                      final session = _getSessionsForDay(_selectedDay)[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: ListTile(
                          title: Text('${session.subjectId}'),
                          subtitle: Text(
                            '${session.startTime} - ${session.endTime}\n${session.sessionDate}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _editSession(session),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteSession(session),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newSession = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditSessionScreen()),
          );

          if (newSession != null) {
            setState(() {
              sessions.add(newSession);
            });
            saveSessions();
          }
        },
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
      ),
    );
  }
}