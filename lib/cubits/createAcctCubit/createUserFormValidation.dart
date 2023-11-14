import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../../utils/appUtil.dart';

class CreateUserFormValidation {
  final _firstNameSubject = BehaviorSubject<String>();
  final _lastNameSubject = BehaviorSubject<String>();
  final _middleNameSubject = BehaviorSubject<String>();
  final _emailSubject = BehaviorSubject<String>();
  final _phoneSubject = BehaviorSubject<String>();
  final _bvnSubject = BehaviorSubject<String>();
  final _genderSubject = BehaviorSubject<String>();
  final _referralSubject = BehaviorSubject<String>();
  final _usernameSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _retypePassword = BehaviorSubject<String>();

  Function(String) get setFirstName => _firstNameSubject.sink.add;

  Function(String) get setLastName => _lastNameSubject.sink.add;

  Function(String) get setMiddleName => _middleNameSubject.sink.add;

  Function(String) get setEmail => _emailSubject.sink.add;

  Function(String) get setPhone => _phoneSubject.sink.add;

  Function(String) get setBvn => _bvnSubject.sink.add;

  Function(String) get setGender => _genderSubject.sink.add;

  Function(String) get setReferral => _referralSubject.sink.add;

  Function(String) get setUsername => _usernameSubject.sink.add;

  Function(String) get setPassword => _passwordSubject.sink.add;

  Function(String) get setRetypePassword => _retypePassword.sink.add;

  Stream<String> get firstName => _firstNameSubject.stream.transform(validateFirstName);

  Stream<String> get lastName => _lastNameSubject.stream.transform(validateLastName);

  Stream<String> get middleName => _middleNameSubject.stream.transform(validateMiddleName);

  Stream<String> get email => _emailSubject.stream.transform(validateEmail);

  Stream<String> get phone =>  _phoneSubject.stream.transform(validatePhoneNumber);

  Stream<String> get gender => _genderSubject.stream.transform(validateGender);

  Stream<String> get bvn => _bvnSubject.stream.transform(validateBvn);

  Stream<String> get username =>
      _usernameSubject.stream.transform(validateUsername);

  Stream<String> get password =>
      _passwordSubject.stream.transform(validatePassword);

  Stream<String> get retypePassword =>
      _retypePassword.stream.transform(validateRetypePassword());

  Stream<bool> get userInfoFormValid => Rx.combineLatest6(
      firstName, lastName, middleName, gender, email, phone, (firstName, lastName,
      middleName, gender, email, phone) => true);
  Stream<bool> get userInfo2FormValid => Rx.combineLatest4(
      username, bvn, password, retypePassword, (username, bvn, password, retypePassword) => true);

  final validateFirstName = StreamTransformer<String, String>.fromHandlers(
      handleData: (firstName, sink) {
        if (firstName.length < 2) {
          sink.addError('first Name must be at Least 2 characters');
        } else {
          sink.add(firstName);
        }
      }
  );
  final validateLastName = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (value.length < 2) {
          sink.addError('Must be at Least 2 characters');
        } else {
          sink.add(value);
        }
      }
  );
  final validateGender = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (value.length < 2) {
          sink.addError('Must be at Least 2 characters');
        } else {
          sink.add(value);
        }
      }
  );
  final validateUsername = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (value.length < 2) {
          sink.addError('Must be at Least 2 characters');
        } else {
          sink.add(value);
        }
      }
  );
  final validateMiddleName = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (value.length < 2) {
          sink.addError('Must be at Least 2 characters');
        } else {
          sink.add(value);
        }
      }
  );
  final validatePhoneNumber = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (!AppUtils().validateMobile(value)) {
          sink.addError('Phone number not valid');
        } else {
          sink.add(value);
        }
      }
  );
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (!AppUtils().validateEmail(value)) {
          sink.addError('Enter a valid email');
        } else {
          sink.add(value);
        }
      }
  );
  final validateBvn = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (value.length != 11) {
          sink.addError('Enter a valid bvn');
        } else {
          sink.add(value);
        }
      }
  );
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (value.length < 6) {
          sink.addError('Password must be six characters or more');
        } else {
          sink.add(value);
        }
      }
  );

  StreamTransformer<String, String>  validateRetypePassword() {
    return StreamTransformer<String,
        String>.fromHandlers(
        handleData: (value, sink) {
          if (value != _passwordSubject.value) {
            sink.addError('Password does not match');
          } else {
            sink.add(value);
          }
        }
    );
  }
  // CreateAccountRequest createUser(BuildContext context){
  //   CreateAccountRequest request = CreateAccountRequest(
  //       username: _usernameSubject.stream.value,
  //       password: _passwordSubject.stream.value,
  //       confirmPassword: _passwordSubject.stream.value,
  //       phoneNumber: _phoneSubject.stream.value,
  //       surname: _lastNameSubject.stream.value,
  //       firstname: _firstNameSubject.stream.value,
  //       othername: _middleNameSubject.stream.value,
  //       email: _emailSubject.stream.value,
  //       bvn: _bvnSubject.stream.value,
  //       gender: "",
  //       referral: "",
  //       title: "",
  //       deviceId: const Uuid().v1(),
  //       deviceModel: deviceModel,
  //       deviceOs: platformOS, deviceName: deviceName, deviceType: 'mobile'
  //   );
  //   return request;
  // }
  String getUsername(){
    return _usernameSubject.stream.value;
  }
}