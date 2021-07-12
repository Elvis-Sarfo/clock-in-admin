class Student {
  String? id, firstName, lastName, gender, picture, course, position, residence;
  Map<String, dynamic>? guardian;

  Student({
    this.id,
    this.firstName,
    this.lastName,
    this.gender,
    this.picture,
    this.course,
    this.position,
    this.residence,
    this.guardian,
  });

  //convert from map object to teacher object
  Student.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.firstName = map['firstName'];
    this.lastName = map['lastName'];
    this.gender = map['gender'];
    this.picture = map['picture'];
    this.course = map['course'];
    this.position = map['position'];
    this.residence = map['residence'];
    this.guardian = map['guardian'];
  }

  //convert from teacher object to map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['gender'] = gender;
    map['picture'] = picture;
    map['course'] = course;
    map['position'] = position;
    map['residence'] = residence;
    map['guardian'] = guardian;
    // returns a map
    return map;
  }

  // Get the full name of the teacher
  String? fullName() => '${this.firstName!} ${this.lastName!}';
}
