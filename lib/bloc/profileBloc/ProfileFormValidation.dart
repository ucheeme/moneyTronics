


import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../models/response/FinedgeProduct.dart';

class ProfileFormValidation{
  final _productSelectedSubject = BehaviorSubject<FinedgeProduct>();
  Function(FinedgeProduct) get setProductSelected => _productSelectedSubject.sink.add;

  Stream<FinedgeProduct> get productSelectStream =>
      _productSelectedSubject.stream.transform(validateClientId);

  final validateClientId = StreamTransformer<FinedgeProduct, FinedgeProduct>.fromHandlers(
      handleData: (value, sink) {
          sink.add(value);
      }
  );

}