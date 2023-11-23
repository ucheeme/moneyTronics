


import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../Utils/DeviceUtil.dart';
import '../../models/requests/ChangePasswordRequest.dart';
import '../../models/requests/DeviceRegistrationRequest.dart';
import '../../models/requests/ForgotPasswordOtpRequest.dart';
import '../../models/requests/ForgotPasswordRequest.dart';



class PasswordSettingsFormValidation {

  final _usernameSubject = BehaviorSubject<String>();
  final _securityAnswerSubject = BehaviorSubject<String>();
  final _otpSubject = BehaviorSubject<String>();

  final _accountNumberSubject = BehaviorSubject<String>();


  final _passwordSubject = BehaviorSubject<String>();
  final _newPasswordSubject = BehaviorSubject<String>();
  final _confirmPasswordSubject = BehaviorSubject<String>();
  final _confirmNewPasswordSubject = BehaviorSubject<String>();


  Function(String) get setUsername => _usernameSubject.sink.add;
  Function(String) get setSecurityAnswer => _securityAnswerSubject.sink.add;
  Function(String) get setOtp => _otpSubject.sink.add;
  Function(String) get setPassword => _passwordSubject.sink.add;
  Function(String) get setAccountNumber => _accountNumberSubject.sink.add;
  Function(String) get setNewPassword => _newPasswordSubject.sink.add;
  Function(String) get setConfirmPassword => _confirmPasswordSubject.sink.add;
  Function(String) get setNewConfirmPassword => _confirmNewPasswordSubject.sink.add;

  Stream<String> get usernameStream =>
      _usernameSubject.stream.transform(validateUsername);
  Stream<String> get accountNumber =>
      _accountNumberSubject.stream.transform(validateUsername);
  Stream<String> get securityAnswerStream =>
      _securityAnswerSubject.stream.transform(validateSecretAnswer);
  Stream<bool> get validateForgotPasswordForm => Rx.combineLatest2(
      usernameStream, securityAnswerStream, ( usernameStream, securityAnswerStream) => true);
  Stream<bool> get validateResetPinForm => Rx.combineLatest2(
      otpStream, securityAnswerStream, ( otpStream, securityAnswerStream) => true);


  Stream<String> get otpStream =>
      _otpSubject.stream.transform(validateOtp);

  Stream<String> get passwordStream =>
      _passwordSubject.stream.transform(validatePassword);

  Stream<String> get newPasswordStream =>
      _newPasswordSubject.stream.transform(validateNewPassword);

  Stream<String> get confirmPasswordStream =>
      _confirmPasswordSubject.stream.transform(validateRetypePassword());

  Stream<String> get confirmNewPasswordStream =>
      _confirmNewPasswordSubject.stream.transform(validateRetypeNewPassword());

  Stream<bool> get validateResetPasswordForm => Rx.combineLatest3(
      otpStream, passwordStream, confirmPasswordStream, (  otpStream, passwordStream, confirmPasswordStream,) => true);

  Stream<bool> get validateChangePasswordPasswordForm => Rx.combineLatest3(
      passwordStream, newPasswordStream, confirmNewPasswordStream, (  passwordStream, newPasswordStream, confirmNewPasswordStream,) => true);

  Stream<bool> get validateDeviceChangeForm => Rx.combineLatest3(
      accountNumber, otpStream, securityAnswerStream, (  accountNumber, otpStream, securityAnswerStream,) => true);


  final validateUsername = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (value.isEmpty) {
          sink.addError('Please secret answer');
        } else {
          sink.add(value);
        }
      }
  );
  final validateAccountNumber = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (value.length != 10) {
          sink.addError('Please enter a valid account number');
        } else {
          sink.add(value);
        }
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

  final validateOtp = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (value.length < 4) {
          sink.addError('Please enter a valid otp');
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

  final validateNewPassword = StreamTransformer<String, String>.fromHandlers(
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

  StreamTransformer<String, String>  validateRetypeNewPassword() {
    return StreamTransformer<String,
        String>.fromHandlers(
        handleData: (value, sink) {
          if (value != _newPasswordSubject.value) {
            sink.addError('Password does not match');
          } else {
            sink.add(value);
          }
        }
    );
  }

  ForgotPasswordOtpRequest forgotPasswordRequest(){
    ForgotPasswordOtpRequest request = ForgotPasswordOtpRequest(
        username: _usernameSubject.stream.value,
        answerToQuestion: _securityAnswerSubject.stream.value
    );
    return request;
  }

  ForgotPasswordRequest resetPasswordRequest(){
    ForgotPasswordRequest request = ForgotPasswordRequest(
        code: _otpSubject.stream.value,
        username: _usernameSubject.stream.value,
        password: _passwordSubject.stream.value
    );
    return request;
  }

  ChangePasswordRequest changePasswordRequest(){
    ChangePasswordRequest request = ChangePasswordRequest(
        currentPassword: _passwordSubject.stream.value,
        newPassword: _newPasswordSubject.stream.value,
        confirmPassword: _confirmNewPasswordSubject.stream.value
    );
    return request;
  }

  DeviceAuthenticationRequest  deviceAuthRequest(username){
    DeviceAuthenticationRequest request = DeviceAuthenticationRequest(
        username: username,
        otpCode: _otpSubject.stream.value,
        accountNumber: _accountNumberSubject.stream.value,
        deviceName: deviceName,
        deviceUniqueId: deviceId,
        platformOs: platformOS,
        deviceModel: deviceModel,
       deviceType: "Mobile",
        secretQuestionAnswer: _securityAnswerSubject.stream.value
    );
    return request;
  }
}