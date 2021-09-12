class Teacher {
  String? staffId,
      firstName,
      lastName,
      gender,
      email,
      phone,
      picture,
      department,
      subject,
      position,
      residence;
  bool? enabled;

  Teacher({
    this.firstName,
    this.lastName,
    this.gender,
    this.phone,
    this.email,
    this.picture,
    this.department,
    this.subject,
    this.position,
    this.residence,
    this.staffId,
    this.enabled = true,
  });

  //convert from map object to teacher object
  Teacher.fromMapObject(Map<String, dynamic>? map) {
    this.staffId = map?['staffId'];
    this.firstName = map?['firstName'];
    this.lastName = map?['lastName'];
    this.gender = map?['gender'];
    this.email = map?['email'];
    this.phone = map?['phone'];
    this.subject = map?['subject'];
    this.residence = map?['residence'];
    this.enabled = map?['enabled'];
    this.picture = map?['picture'];
    this.department = map?['department'];
    this.position = map?['position'];
  }

  //convert from teacher object to map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['staffId'] = staffId;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['gender'] = gender;
    map['email'] = email;
    map['phone'] = phone;
    map['subject'] = subject;
    map['position'] = position;
    map['residence'] = residence;
    map['enabled'] = enabled;
    map['picture'] = picture;
    map['department'] = department;

    return map;
  }

  // Get the full name of the teacher
  String? fullName() => this.firstName != null || this.lastName != null
      ? '${this.firstName ?? ''} ${this.lastName ?? ''}'
      : null;
}
