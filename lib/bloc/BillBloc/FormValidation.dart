
import 'dart:async';


import 'package:rxdart/rxdart.dart';



import '../../models/requests/BillsCustomerLookUpRequest.dart';
import '../../models/requests/EncRequest.dart';
import '../../models/requests/VendRequest.dart';
import '../../models/response/BillsResponse/BillerGroupsDetailsResponse.dart';
import '../../models/response/BillsResponse/BillerPackageResponse.dart';
import '../../models/response/BillsResponse/NetworkPlansResponse.dart';
import '../../models/response/UserAccountResponse.dart';
import '../../utils/appUtil.dart';

class BillFormValidation{

  final _subscribedService = BehaviorSubject<SubscribedService>();
  final _amountSubject = BehaviorSubject<String>();
  final _phoneSubject = BehaviorSubject<String>();
  final _selectedAccount = BehaviorSubject<UserAccount>();
  final _selectedProduct = BehaviorSubject<PresetAmountList>();

  final _selectedBillerCategorySubject = BehaviorSubject<BillerGroupsDetailsResponse>();
  final _selectedBillerPackageSubject = BehaviorSubject<BillerPackageResponse>();
  final _customerIDSubject = BehaviorSubject<String>();



  //final _phoneSubject = BehaviorSubject<String>();

  Function(String) get setAmount => _amountSubject.sink.add;
  Function(String) get setPhone => _phoneSubject.sink.add;
  Function(PresetAmountList) get setProduct => _selectedProduct.sink.add;
  Function(SubscribedService) get setSubscribedService => _subscribedService.sink.add;
  Function(UserAccount) get setSelectedAccount => _selectedAccount.sink.add;

  // Function(BillerGroupsDetailsResponse) get setSelectedBillerCategory => _selectedBillerCategorySubject.sink.add;
  // Function(BillerPackageResponse) get setSelectedBillerPackage => _selectedBillerPackageSubject.sink.add;
  // Function(String) get setCustomerID => _customerIDSubject.sink.add;
  //


  Stream<String> get amount => _amountSubject.stream.transform(validateString);
  Stream<String> get phone => _phoneSubject.stream.transform(validateString);

  // Stream<String> get customerID => _customerIDSubject.stream.transform(validateString);
  //
  // Stream<BillerGroupsDetailsResponse> get selectedBillerCategory => _selectedBillerCategorySubject.stream.transform(validateBillerCategory);
  // Stream<BillerPackageResponse> get selectedBillerPackage => _selectedBillerPackageSubject.stream.transform(validateBillerPackage);
  //

  Stream<SubscribedService> get subscribedService => _subscribedService.stream.transform(validateSubscribedService);
  Stream<PresetAmountList> get selectedProduct => _selectedProduct.stream.transform(validateSubscribedProduct);


  Stream<bool> get validateAirtimeForm => Rx.combineLatest3(amount, phone, subscribedService, (amount, phone, subscribedService) => true);
  Stream<bool> get validateDataForm => Rx.combineLatest4(amount, phone, subscribedService, selectedProduct, (amount, phone, subscribedService, selectedProduct) => true);

  // Stream<bool> get validateCustomerLookUoForm => Rx.combineLatest3(customerID, selectedBillerCategory, selectedBillerPackage, (customerID, selectedBillerCategory, selectedBillerPackage,) => true);


  final validateString = StreamTransformer<String, String>.fromHandlers (
      handleData: (value, sink) {
        if (value.isEmpty) {
          sink.addError('Please enter a value');
        } else {
          sink.add(value);
        }
      }
  );
  final validateSubscribedService = StreamTransformer<SubscribedService, SubscribedService>.fromHandlers (
      handleData: (value, sink) {
         sink.add(value);
      }
  );
  final validateSubscribedProduct = StreamTransformer<PresetAmountList, PresetAmountList>.fromHandlers (
      handleData: (value, sink) {
        sink.add(value);
      }
  );
  final validateBillerCategory = StreamTransformer<BillerGroupsDetailsResponse, BillerGroupsDetailsResponse>.fromHandlers (
      handleData: (value, sink) {
        sink.add(value);
      }
  );
  final validateBillerPackage = StreamTransformer<BillerPackageResponse, BillerPackageResponse>.fromHandlers (
      handleData: (value, sink) {
        sink.add(value);
      }
  );

  EncRequest getVendRequest(String pin,{ bool? isData = false}){
    return VendRequest(
        accountNumber: _selectedAccount.stream.value.accountnumber ?? "",
        amountPaid: double.parse(_amountSubject.stream.value.replaceAll(",", "")),
        phoneNumber: _phoneSubject.stream.value,
        transactionDate: AppUtils.convertDateSystem(DateTime.now()),
        networkProvider: (_subscribedService.stream.value.name ?? "").replaceAll(" ", ""),
        vendingCode: _subscribedService.stream.value.vendCode ?? "",
        subCode: isData == true ? (_selectedProduct.stream.value.subCode ?? "") : "",
        transactionPin: pin,
        usesPreset: true,
        bsig: "",
        otpCode: "11111"
    ).encryptedRequest();
  }

  BillsCustomerLookUpRequest getBillsCustomerLookUpRequest(){
    return BillsCustomerLookUpRequest(
        customerId: _customerIDSubject.stream.value ??'',
        billerSlug: _selectedBillerCategorySubject.stream.value.slug ?? "",
        productName: _selectedBillerPackageSubject.stream.value.slug ?? ""
    );
  }
}