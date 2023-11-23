import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moneytronic/models/response/ApiResponse.dart';

part 'transaction_pin_event.dart';
part 'transaction_pin_state.dart';

class TransactionPinBloc extends Bloc<TransactionPinEvent, SetTransactionPinState> {
  TransactionPinBloc() : super(SetTransactionPinInitial()) {
    on<TransactionPinEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
