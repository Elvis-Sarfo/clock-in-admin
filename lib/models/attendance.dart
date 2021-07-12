class Attendance {
  late final String arrivalTime, departureTime, locationProximity;
  Attendance({
    required this.arrivalTime,
    required this.departureTime,
    required this.locationProximity,
  });
  //convert from teacher attendace oject to map object

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['arrivalTime'] = arrivalTime;
    map['departureTime'] = departureTime;
    map['locationProximity'] = locationProximity;
    return map;
  }

  //convert from map object to teacher attendace object
  Attendance.fromMapObject(Map<String, dynamic> map) {
    this.arrivalTime = map['arrivalTime'];
    this.departureTime = map['departureTime'];
    this.locationProximity = map['locationProximity'];
  }
}
