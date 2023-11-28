

import 'dart:async';


import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../Utils/DeviceUtil.dart';
import '../../models/requests/LoginRequest.dart';


class LoginFormValidation{

  final _clientIdSubject = BehaviorSubject<String>();
  final _clientSecretSubject = BehaviorSubject<String>();

  Function(String) get setClientId => _clientIdSubject.sink.add;
  Function(String) get setClientSecret => _clientSecretSubject.sink.add;

  Stream<String> get clientId =>
      _clientIdSubject.stream.transform(validateClientId);
  Stream<String> get clientSecret =>
      _clientSecretSubject.stream.transform(validateClientSecret);
  Stream<bool> get passwordUsernameFormValidation => Rx.combineLatest2(
      clientId, clientSecret, (clientId, clientSecret) => true);

  final validateClientId = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (value.isEmpty) {
          sink.addError('Please enter firstname');
        } else {
          sink.add(value);
        }
      }
  );
  final validateClientSecret = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (value.isEmpty) {
          sink.addError('Please enter password');
        } else {
          sink.add(value);
        }
      }
  );
  LoginRequest loginValidation(){
     LoginRequest request =  LoginRequest(
         clientId: _clientIdSubject.stream.value,
         clientSecret: _clientSecretSubject.stream.value,
         deviceId: deviceId,
         deviceModel: deviceModel,
         deviceOs: deviceOs,
         deviceName: deviceName,
         deviceType: "Mobile"
     );
    return request;
  }
}