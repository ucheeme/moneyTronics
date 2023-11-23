import 'dart:async';
import 'package:bloc/bloc.dart';


import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../UiUtil/bottomsheet/receiptBottomSheet.dart';
import '../../utils/appUtil.dart';
import '../../models/requests/AccountVerification.dart';
import '../../models/requests/SaveBeneficiaryRequest.dart';
import '../../models/requests/TransferRequest.dart';
import '../../models/response/AccountVerificationResponse.dart';
import '../../models/response/ApiResponse.dart';
import '../../models/response/Bank.dart';
import '../../models/response/SimpleApiResponse.dart';
import '../../models/response/TransactionHistory.dart';
import '../../models/response/TransferResponse.dart';
import '../../repository/TransactionRepository.dart';

import '../../views/appScreens/dashboard/tranferScreens/TransactionConfirmationScreen.dart';
import '../../views/appScreens/history/transactionReceipt.dart';
import '../../views/startScreen/login/loginFirstTime.dart';
import 'TransactionFormsValidation.dart';


part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionFormValidation formValidation = TransactionFormValidation();
  TransactionRepository repository;
  String requestID = "";
  List<Bank> bankList = [];
  final _bankListSubject = BehaviorSubject<List<Bank>>();
  Stream<List<Bank>> get beneficiaryListStream =>  _bankListSubject.stream;
  TransactionBloc(this.repository) : super(TransactionInitial()) {
    on<TransactionEvent>((event, emit) {
    });
    on<TransactionBankEvent>((event, emit) {
      handleBankEvent(event);
    });
    on<TransactionPostEvent>((event, emit) {
      handleTransactionPost(event);
    });
    on<TransactionSaveBeneficiaryEvent>((event, emit) {
      handleSaveBeneficiaryEvent(event);
    });
    on<TransactionAccountVerificationEvent>((event, emit) {
      handleAccountVerificationEvent(event);
    });
  }
  initial(){
    emit(TransactionInitial());
  }
  handleBankEvent(event) async {
    if (bankList.isNotEmpty){
      _bankListSubject.add(bankList);
      emit( TransactionBankState(bankList));
      return;
    }
    emit(TransactionStateLoading());
    try {
      final response = await repository.getBanks();
      if (response is List<Bank>) {
        bankList.clear();
        bankList.addAll(response);
        _bankListSubject.add(bankList);
        emit( TransactionBankState(response));
        AppUtils.debug("bank fetched");
      }else{
        response as ApiResponse;
        emit(TransactionStateError(response));
        AppUtils.debug("error");
      }
    }catch(e) {
      emit(TransactionStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }
  handleTransactionPost(event) async {
    emit(TransactionStateLoading());
    try {
      final response = await repository.performTransaction(event.request);
      if (response is TransactionResponse) {
        emit(TransactionPostState(response));
        requestID = response.requestId;
        AppUtils.debug("transfer posted");
      }else{
        response as ApiResponse;
        emit(TransactionStateError(response));
        AppUtils.debug("error");
      }
    }catch(e) {
      emit(TransactionStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }
  handleSaveBeneficiaryEvent(event) async {
    try {
      final response = await repository.saveBeneficiary(event.request);
      if (response is SimpleResponse) {

        AppUtils.debug("beneficiary saved");
      }else{
        response as ApiResponse;
        AppUtils.debug("could not save beneficiary");
      }
    }catch(e){
      AppUtils.debug("could not save beneficiary");
    }
  }
  handleAccountVerificationEvent(event) async {
    try {
      emit(TransactionClearBankState());
      final response = await repository.getAccountVerification(event.request);
      if (response is AccountVerificationResponse) {
        emit(TransactionAccountVerificationState(response));
        AppUtils.debug("Account verified successfully");
      }else{
        response as ApiResponse;
        AppUtils.debug("could not verify account");
      }
    }catch(e){
      AppUtils.debug("exceptions occurs");
    }
  }
  showTransferConfirmation(BuildContext context, type) async{
    var request = formValidation.createTransactionRequest(type);
    if (request.debitAcct == request.creditAcct){
      emit(TransactionStateError(AppUtils.defaultErrorResponse(msg: "Both debit and credit accounts are the same")));
      return;
    }
    await showModalBottomSheet(
        isDismissible: false,
        enableDrag: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => SafeArea(
          child: Container(height: MediaQuery.of(context).size.height * 0.7,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child:  TransferConfirmationScreen(response: request)
          ),
        )
    ).then((r) {
      if (r is TransferRequest){
        add(TransactionPostEvent(r));
      }
    });
  }
  receiptBottomSheet(BuildContext context) {
    var request = formValidation.createTransactionRequest("");
    TransactionHistoryResponse response = TransactionHistoryResponse();
    response.beneficiaryAccount = request.creditAcct;
    response.destinationBank = request.benificiaryBank;
    response.narration = request.narration1;
    response.amount = "-${request.payamount}";
    response.trandate = AppUtils.convertDate(DateTime.now());
    response.beneficiaryName = request.creditAcctName;
    response.accountHolderName = loginResponse?.fullname ?? "";
    response.accountNo = request.debitAcct;
    response.requestId = requestID;
    nonDismissibleBottomSheet(context, ReceiptBottomSheet(
        isSuccessful: true, type: "Transfer successful",
        description: "We’ve completed your transfer, You will be notified shortly",
        shareTap: (){
          Navigator.pop(context);
          Navigator.pop(context);
        dismissibleBottomSheet(context, Receipt(response: response),  MediaQuery.of(context).size.height * 0.9);
        }, downloadTap: (){
          dismissibleBottomSheet(context, Receipt(response: response),  MediaQuery.of(context).size.height * 0.9);
    }, returnTap: (){
          Navigator.pop(context);
          Navigator.pop(context);
        })
    );
  }
}
