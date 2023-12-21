import 'dart:async';

import 'package:rxdart/rxdart.dart';

class SignUpFormValidation{
  final _bvnSubject= BehaviorSubject<String>();
  final _accountNumberSubject = BehaviorSubject<String>();
  final _referralCodeSubject = BehaviorSubject<String>();

  Function(String) get setBvnNumber => _bvnSubject.sink.add;
  Function(String) get setAccountNumber => _accountNumberSubject.sink.add;
  Function(String) get setReferralCode => _referralCodeSubject.sink.add;
  Stream<String> get bvnNumber =>
      _bvnSubject.stream.transform(validateBvnNumber);
  Stream<String> get accountNumber =>
      _accountNumberSubject.stream.transform(validateAccountNumber);
  Stream<String> get referralCode => _referralCodeSubject.stream.transform(validateReferralCode);

  final validateAccountNumber = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (value.length != 10) {
          sink.addError('Please enter a valid account number');
        } else {
          sink.add(value);
        }
      }
  );

  final validateBvnNumber = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (value.length != 11) {
          sink.addError('Please enter a valid bvn number');
        } else {
          sink.add(value);
        }
      }
  );
  final validateReferralCode = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (value.length != 6) {
          sink.addError('Please enter a valid referal code');
        } else {
          sink.add(value);
        }
      }
  );


}