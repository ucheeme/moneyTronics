import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../models/requests/SaveBeneficiaryRequest.dart';
import '../../models/requests/TransferRequest.dart';
import '../../models/response/UserAccountResponse.dart';




class TransactionFormValidation{

  final _amountSubject = BehaviorSubject<String>();
  final _recipientAccount = BehaviorSubject<String>();
  final _debitAccount = BehaviorSubject<String>();
  final _recipientAccountName = BehaviorSubject<String>();
  final _selectedAccount = BehaviorSubject<UserAccount>();
  final _bankCodeSubject = BehaviorSubject<String>();
  final _bankNameSubject = BehaviorSubject<String>();
  final _narrationSubject = BehaviorSubject<String>();

  Function(String) get setAmount => _amountSubject.sink.add;
  Function(String) get setRecipientAccount => _recipientAccount.sink.add;
  Function(String) get setRecipientName => _recipientAccountName.sink.add;
  Function(String) get setBankCode => _bankCodeSubject.sink.add;
  Function(String) get setBankName => _bankNameSubject.sink.add;
  Function(String) get setNarration => _narrationSubject.sink.add;
  Function(String) get setDebitAccount => _debitAccount.sink.add;
  Function(UserAccount) get setSelectedAccount => _selectedAccount.sink.add;

  Stream<String> get amount => _amountSubject.stream.transform(validateString);
  Stream<String> get recipientAccount => _recipientAccount.stream.transform(validateString);
  Stream<String> get debitAccount => _debitAccount.stream.transform(validateString);
  Stream<String> get recipientName => _recipientAccountName.stream.transform(validateString);
  Stream<String> get bankCode => _bankCodeSubject.stream.transform(validateString);
  Stream<String> get bankName => _bankNameSubject.stream.transform(validateString);
  Stream<String> get narration => _narrationSubject.stream.transform(validateString);

  Stream<bool> get validateTransferForm => Rx.combineLatest6(
      amount, recipientAccount, recipientName, bankCode, bankName, narration,
          (amount, recipientAccount, recipientName, bankCode, bankName, narration) => true);


  final validateString = StreamTransformer<String, String>.fromHandlers (
      handleData: (value, sink) {
        if (value.isEmpty) {
          sink.addError('Please enter a value');
        } else {
          sink.add(value);
        }
      }
  );
  TransferRequest createTransactionRequest(type){
    return TransferRequest(
        debitAcct: _selectedAccount.stream.value.accountnumber ?? "",
        creditAcct:  _recipientAccount.stream.value,
        creditAcctName: _recipientAccountName.stream.value,
        benificiaryBank: _bankNameSubject.stream.value,
        bankCode: _bankCodeSubject.stream.value,
        payamount: double.parse(_amountSubject.stream.value.replaceAll(",", "")),
        narration1: _narrationSubject.stream.value,
        transType: type,
        transactionPin: "",
        otpCode: "11111",
        sg: ""
    );
  }
  SaveBeneficiaryRequest createBeneficiaryRequest(){
    return SaveBeneficiaryRequest(
        beneficiaryBankcode: _bankCodeSubject.stream.value,
        beneficiaryBankname: _bankNameSubject.stream.value,
        beneficiaryFullName: _recipientAccountName.stream.value,
        beneficiaryAccoutNumber: _recipientAccount.stream.value,
        alias: _bankNameSubject.stream.value,
    );
  }
}