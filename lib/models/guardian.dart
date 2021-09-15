class Guardian {
  String? firstName, lastName, gender, relationship, residence, email, phone;
  bool? enabled;

  Guardian(
      {this.firstName,
      this.lastName,
      this.gender,
      this.relationship,
      this.email,
      this.phone,
      this.residence,
      this.enabled = true});

  //convert from map object to teacher object
  Guardian.fromMapObject(Map<String, dynamic>? map) {
    this.firstName = map?['firstName'];
    this.lastName = map?['lastName'];
    this.gender = map?['gender'];
    this.relationship = map?['relationship'];
    this.email = map?['email'];
    this.phone = map?['phone'];
    this.residence = map?['residence'];
    this.enabled = map?['enabled'];
  }

  //convert from teacher object to map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['gender'] = gender;
    map['relationship'] = relationship;
    map['email'] = email;
    map['phone'] = phone;
    map['residence'] = residence;
    map['enabled'] = enabled;
    // returns a map
    return map;
  }

  // Get the full name of the teacher
  String? fullName() => '${this.firstName!} ${this.lastName!}';
}
