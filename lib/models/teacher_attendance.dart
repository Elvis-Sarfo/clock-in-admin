class TeacherAttendance {
  String? teacherId, type;
  int? time;
  double? locationProximity;
  Map<String, dynamic>? location;
  TeacherAttendance(
      {required this.time,
      required this.teacherId,
      required this.type,
      required this.locationProximity,
      required this.location});

  //convert from teacher attendace oject to map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['time'] = time;
    map['type'] = type;
    map['teacherId'] = teacherId;
    map['location'] = location;
    map['locationProximity'] = locationProximity;
    return map;
  }

  //convert from map object to teacher attendace object
  TeacherAttendance.fromMapObject(Map<String, dynamic> map) {
    this.time = map['time'];
    this.type = map['type'];
    this.teacherId = map['teacherId'];
    this.location = map['location'];
    this.locationProximity = map['location_proximity'];
  }
}
