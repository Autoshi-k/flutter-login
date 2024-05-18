import 'package:formz/formz.dart';

enum PinCodeValidationError { empty, tooShort, tooLong }

class PinCode extends FormzInput<String, PinCodeValidationError> {
  const PinCode.pure() : super.pure('');
  const PinCode.dirty([super.value = '']) : super.dirty();

  @override
  PinCodeValidationError? validator(String value) {
    if (value.isEmpty) return PinCodeValidationError.empty;
    if (value.length < 5) return PinCodeValidationError.tooShort;
    if (value.length > 6) return PinCodeValidationError.tooLong;
    return null;
  }
}