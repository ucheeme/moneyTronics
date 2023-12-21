import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../../models/requests/CreateAccountRequest.dart';
import '../../models/requests/CreateExistingUserRequest.dart';
import '../../models/requests/ValidateExistingUserRequest.dart';
import '../../models/response/SecurityQuestionsResponse.dart';
import '../../models/response/validateExistingUserAccountResponsse.dart';
import '../../utils/DeviceUtil.dart';
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
   final _accNumberSubject = BehaviorSubject<String>();
   final _tranPinSubject = BehaviorSubject<String>();
   final _securityQuestion = BehaviorSubject<SecurityQuestion>();
   final _securityAnswer = BehaviorSubject<String>();

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
   Function(String) get setAccNumber => _accNumberSubject.sink.add;
   Function(String) get setTransactionPin => _tranPinSubject.sink.add;
   Function(SecurityQuestion) get setSecurityQuestion => _securityQuestion.sink.add;
   Function(String) get setSecurityAnswer => _securityAnswer.sink.add;

   Stream<String> get firstName => _firstNameSubject.stream.transform(validateFirstName);

   Stream<String> get lastName => _lastNameSubject.stream.transform(validateLastName);

   Stream<String> get middleName => _middleNameSubject.stream.transform(validateMiddleName);

   Stream<String> get email => _emailSubject.stream.transform(validateEmail);

   Stream<String> get phone =>  _phoneSubject.stream.transform(validatePhoneNumber);

   Stream<String> get gender => _genderSubject.stream.transform(validateGender);

   Stream<String> get bvn => _bvnSubject.stream.transform(validateBvn);

   Stream<String> get username =>
       _usernameSubject.stream.transform(validateUsername);

   Stream<String> get accountNumber =>
       _accNumberSubject.stream.transform(validateAccountNumber);
   Stream<String> get transactionPin =>
       _tranPinSubject.stream.transform(validateTransPin);

   Stream<String> get password =>
       _passwordSubject.stream.transform(validatePassword);

   Stream<String> get retypePassword =>
       _retypePassword.stream.transform(validateRetypePassword());

   Stream<SecurityQuestion> get securityQuestion =>
       _securityQuestion.stream.transform(validateSecurityQuestion);
   Stream<String> get securityAnswer =>
       _securityAnswer.stream.transform(validateSecretAnswer);


   Stream<bool> get userInfoFormValid => Rx.combineLatest5(
       firstName, lastName, gender, email, phone, (firstName, lastName,
       gender, email, phone) => true);
   Stream<bool> get userInfo2FormValid => Rx.combineLatest4(username, bvn, password, retypePassword,
           (username, bvn, password, retypePassword) => true);


   Stream<bool> get bvnValidationFormValid => Rx.combineLatest2(bvn, accountNumber,
           (bvn,accountNumber) => true);
   Stream<bool> get existingUserCreateFormValid => Rx.combineLatest6(username,email, password,transactionPin,securityQuestion,securityAnswer,
           (username,email,password,transactionPin,securityQuestion,securityAnswer) => true);

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
           sink.addError('Must be at Least 5 characters');
         } else {
           sink.add(value);
         }
       }
   );

   final validateMiddleName = StreamTransformer<String, String>.fromHandlers(
       handleData: (value, sink) {
         // if (value.length < 2) {
         //   sink.addError('Must be at Least 2 characters');
         // } else {
         //   sink.add(value);
         // }
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
         if (passwordValidator(value)) {
           sink.add(value);
        } else {
           sink.addError('Password must more than 6 characters, must contain at least a  lowercase, uppercase, number and a special character ');
         }
       }
   );

   final validateAccountNumber = StreamTransformer<String, String>.fromHandlers(
       handleData: (value, sink) {
         if (value.length != 10) {
           sink.addError('Enter a valid account number');
         } else {
           sink.add(value);
         }
       }
   );
   final validateTransPin = StreamTransformer<String, String>.fromHandlers(
       handleData: (value, sink) {
         if (value.length != 4) {
           sink.addError('Enter a four digit pin');
         } else {
           sink.add(value);
         }
       }
   );
   final validateSecurityQuestion = StreamTransformer<SecurityQuestion,  SecurityQuestion>.fromHandlers(
       handleData: (value, sink) {
         sink.add(value);
       }
   );
   final validateSecretAnswer = StreamTransformer<String, String>.fromHandlers(
       handleData: (value, sink) {
         if (value.isEmpty) {
           sink.addError('Please secret answer');
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
   CreateAccountRequest createUser(BuildContext context){
    CreateAccountRequest request = CreateAccountRequest(
        username: _usernameSubject.stream.value,
        password: _passwordSubject.stream.value,
        confirmPassword: _passwordSubject.stream.value,
        phoneNumber: _phoneSubject.stream.value,
        surname: _lastNameSubject.stream.value,
        firstname: _firstNameSubject.stream.value,
        othername: _middleNameSubject.hasValue ?  _middleNameSubject.stream.value : "",
        email: _emailSubject.stream.value,
        bvn: _bvnSubject.stream.value,
        gender: "",
        referral: "",
        title: "",
        deviceId: const Uuid().v1(),
        deviceModel: deviceModel,
        deviceOs: platformOS, deviceName: deviceName, deviceType: 'mobile'
    );
    return request;
  }

   ValidateExistingUserRequest validateExistingUser(BuildContext context){
     ValidateExistingUserRequest request = ValidateExistingUserRequest(
         bvn: _bvnSubject.stream.value,
         accountNumber: _accNumberSubject.stream.value,
         referral: ""
     );
     return request;
   }
   CreateExistingUserRequest createExistingUser(BuildContext context,ValidateExistingUserAccountResponse? userData,String otp){
     CreateExistingUserRequest request = CreateExistingUserRequest(
       fullname: userData?.fullname??"",
       accountnumber: userData?.accountnumber??"",
       username: _usernameSubject.stream.value,
       email: _emailSubject.stream.value,
       userpassword: _retypePassword.stream.value,
       opTcode: otp,
       transactionPin: _tranPinSubject.stream.value,
       secretQuestionId: _securityQuestion.stream.value.id,
       secretAnswer: _securityAnswer.stream.value,
       deviceId: const Uuid().v1(),
       deviceModel: deviceModel,
       deviceOs: deviceOs,
       deviceName: deviceName,
       deviceType: "mobile",
     );
     return request;
   }



   String getUserPassKey(){

     return _passwordSubject.stream.value;
   }

  String getUsername(){
     return _usernameSubject.stream.value;
  }

  static bool passwordValidator(String password)  {
    var  hasUppercase = password.contains( RegExp(r'[A-Z]'));
    var  hasDigits = password.contains( RegExp(r'[0-9]'));
    var  hasLowercase = password.contains( RegExp(r'[a-z]'));
    var  hasSpecialCharacters = password.contains( RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    var  hasMinLength = password.length > 7;
    return hasUppercase & hasDigits && hasLowercase && hasSpecialCharacters && hasMinLength;
   }
}