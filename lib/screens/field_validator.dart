class FieldValidator {
  static String? validateField(
      String? value, String field, String? pattern, int length) {
    String? result;
    if (value!.length == 0) {
      result = "Please provide $field";
    } else if (value.length > length) {
      result = "Must be less than $length";
    } else if (pattern != null) {
      RegExp regExp = new RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        if (field == "Email") {
          result = "Email must be in format example@abc.com";
        } else if (field == "Password") {
          result = "At least 8 characters, 1 letter, and 1 number";
        } else {
          result = "Please enter valid $field";
        }
      }
    }
    return result;
  }
}
