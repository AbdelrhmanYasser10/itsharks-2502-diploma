String? emailValidator(String? email){
  if (email == null || email.isEmpty) {
    return "Email cannot be empty";
  } else {
    RegExp expression =
    RegExp("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}\$");
    if (!expression.hasMatch(email)) {
      return "Enter a valid email";
    }
  }

  return null;
}

String? passwordValidator(String? password){
  print(password);
  RegExp expression = RegExp(
      "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@\$!%*#?&])[A-Za-z\\d@\$!%*#?&]{8,}\$");
  if (password == null || password.isEmpty) {
    return "Password cannot be empty";
  } else if (!expression.hasMatch(password)) {
    return "Enter a valid password";
  }
  return null;
}