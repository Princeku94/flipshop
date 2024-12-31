import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

final List<TextEditingController> controllers = List.generate(4, (index) {
  return TextEditingController();
});

final List<String> labels = ['Name', 'Email', 'Phone', 'Address'];

final List<FormFieldValidator<String>?> validate = [
  (value) {
    if (value!.isEmpty) return 'Enter valid name';
    return null;
  },
  (value) {
    bool check = isValidEmail(value ?? '');
    if (!check) return 'Enter valid email';
    return null;
  },
  (value) {
    if (value!.length < 10) return 'Enter valid phone no.';
    return null;
  },
  (value) {
    if (value!.isEmpty) return 'Enter valid address';
    return null;
  },
];

final List<TextInputType> textInputTypes = [
  TextInputType.text,
  TextInputType.emailAddress,
  TextInputType.number,
  TextInputType.streetAddress,
];

//validation

bool isValidEmail(String? email) {
  final bool isValid = EmailValidator.validate(email!);

  print(email);
  return isValid;
}
