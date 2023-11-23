import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../models/requests/FDCalculator.dart';
import '../../models/requests/FixedDepositRequest.dart';
import '../../models/response/FDProducts.dart';

class FDBookingValidation{

  final _purposeSubject = BehaviorSubject<String>();
  final _productSubject = BehaviorSubject<FdProducts>();
  final _setTenureSubject = BehaviorSubject<String>();
  final _setAmountSubject = BehaviorSubject<String>();

  Function(String) get setPurpose => _purposeSubject.sink.add;
  Function(FdProducts) get setProduct => _productSubject.sink.add;
  Function(String) get setTenure => _setTenureSubject.sink.add;
  Function(String) get setAmount => _setAmountSubject.sink.add;

  Stream<String> get purpose =>
      _purposeSubject.stream.transform(validatePurpose);
  Stream<FdProducts> get product =>
      _productSubject.stream.transform(validateProduct);
  Stream<String> get tenure =>
      _setTenureSubject.stream.transform(validateTenure);
  Stream<String> get amount =>
      _setAmountSubject.stream.transform(validateAmount);
  Stream<bool> get validateForm => Rx.combineLatest4(
      purpose, product, tenure, amount, ( purpose, product, tenure, amount) => true);

  final validatePurpose = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (value.isEmpty) {
          sink.addError('Please enter purpose');
        } else {
          sink.add(value);
        }
      }
  );
  final validateProduct = StreamTransformer<FdProducts, FdProducts>.fromHandlers(
      handleData: (value, sink) {

          sink.add(value);

      }
  );
  final validateTenure = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (value.isEmpty) {
          sink.addError('Please select tenure');
        } else {
          sink.add(value);
        }
      }
  );
  final validateAmount = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (value.isEmpty) {
          sink.addError('Please enter amount');
        } else {
          sink.add(value);
        }
      }
  );
  FdCalculatorRequest getCalculatorRequest(){
    FdCalculatorRequest request = FdCalculatorRequest(
        tdAmount: double.parse(_setAmountSubject.stream.value.replaceAll(",", "")),
        duration: int.parse(_setTenureSubject.stream.value),
        productcode: _productSubject.stream.value.productCode.trim()
    );
    return request;
  }

  FixedDepositRequest getInvestRequest(String accountNumber, bool rollOver){
    FixedDepositRequest request = FixedDepositRequest(term: int.parse(_setTenureSubject.stream.value),
        rollOverMaturity: rollOver ? 1 : 0,
        rolloverOption: rollOver ? 1 : 0,
        purpose: _purposeSubject.stream.value,
        amount: double.parse(_setAmountSubject.stream.value.replaceAll(",", "")),
        settlementAccount: accountNumber,
        productCode: _productSubject.stream.value.productCode.trim());
    return request;
  }
}