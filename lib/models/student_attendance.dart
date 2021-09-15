class StudentAttendance {
  String? studentId, type;
  int? time;
  StudentAttendance({
    required this.time,
    required this.studentId,
    required this.type,
  });

  //convert from student attendace oject to map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['time'] = time;
    map['type'] = type;
    map['studentId'] = studentId;
    return map;
  }

  //convert from map object to student attendace object
  StudentAttendance.fromMapObject(Map<String, dynamic>? map) {
    time = map!['time'];
    type = map['type'];
    studentId = map['studentId'];
  }
}
