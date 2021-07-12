class Admin {
  late final String staffId;
  late final String firstName,
      lastName,
      gender,
      email,
      phone,
      picture,
      position;
  late final String location;

  Admin(
      {required this.staffId,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.email,
      required this.phone,
      required this.picture,
      required this.position,
      required this.location});

  //convert from admin object to map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['staffId'] = staffId;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['gender'] = gender;
    map['email'] = email;
    map['phone'] = phone;
    map['picture'] = picture;
    map['position'] = position;
    map['location'] = location;

    return map;
  }

  //convert form map object to admin object
  Admin.fromMapObject(Map<String, dynamic> map) {
    this.staffId = map['staffId'];
    this.firstName = map['firstName'];
    this.lastName = map['lastName'];
    this.gender = map['gender'];
    this.email = map['email'];
    this.phone = map['phone'];
    this.picture = map['picture'];
    this.position = map['position'];
    this.location = map['location'];
  }
}
