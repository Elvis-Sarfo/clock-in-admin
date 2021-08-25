class Teacher {
  String? staffId,
      firstName,
      lastName,
      gender,
      email,
      phone,
      picture,
      subject,
      position,
      residence;
  bool? enabled;

  Teacher(
      {this.firstName,
      this.lastName,
      this.gender,
      this.phone,
      this.email,
      this.picture,
      this.subject,
      this.position,
      this.residence,
      this.staffId,
      this.enabled});

  //convert from map object to teacher object
  Teacher.fromMapObject(Map<String, dynamic?> map) {
    this.staffId = map['staffId'];
    this.firstName = map['firstName'];
    this.lastName = map['lastName'];
    this.gender = map['gender'];
    this.email = map['email'];
    this.phone = map['phone'];
    this.subject = map['subject'];
    this.residence = map['residence'];
    this.enabled = map['enabled'];
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

    return map;
  }

  // Get the full name of the teacher
  String? fullName() => '${this.firstName!} ${this.lastName!}';
}
