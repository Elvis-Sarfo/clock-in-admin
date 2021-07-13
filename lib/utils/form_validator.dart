String? validateEmail(String? value) {
  final verifyEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (value!.isEmpty) {
    return 'Please Enter Email';
  }
  if (!verifyEmail.hasMatch(value)) {
    return 'Enter a valid Email Address';
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  final verifyPhoneNum = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
  if (value!.isEmpty) {
    return 'Please Enter Phone Number';
  }
  if (!verifyPhoneNum.hasMatch(value)) {
    return 'Enter a valid Phone Number';
  }
  return null;
}

String? validatePhoneNumberValue(String? value) {
  final verifyPhoneNum = RegExp(r'^[0-9]*$');
  if (value!.isEmpty) {
    return 'Please Enter a Number';
  }
  if (!verifyPhoneNum.hasMatch(value)) {
    return 'Enter a valid a Number';
  }
  return null;
}

String? emptyFeildValidator(String? value) {
  if (value!.isEmpty) {
    return 'Feild must not be empty';
  }
  return null;
}
