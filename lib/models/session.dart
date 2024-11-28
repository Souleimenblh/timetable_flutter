class Session {
  final String sessionId;
  final String subjectId;
  final String teacherId;
  final String roomId;
  final String classId;
  final String sessionDate;
  final String startTime;
  final String endTime;

  // Constructor
  Session({
    required this.sessionId,
    required this.subjectId,
    required this.teacherId,
    required this.roomId,
    required this.classId,
    required this.sessionDate,
    required this.startTime,
    required this.endTime,
  });

  // From JSON
  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      sessionId: json['session_id'],
      subjectId: json['subject_id'],
      teacherId: json['teacher_id'],
      roomId: json['room_id'],
      classId: json['class_id'],
      sessionDate: json['session_date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'subject_id': subjectId,
      'teacher_id': teacherId,
      'room_id': roomId,
      'class_id': classId,
      'session_date': sessionDate,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}
