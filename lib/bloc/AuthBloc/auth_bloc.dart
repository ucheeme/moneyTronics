import 'dart:async';



import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:moneytronic/bloc/AuthBloc/LoginFormValidation.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/requests/CreateAccountRequest.dart';
import '../../models/response/AccountNumberResponse.dart';
import '../../models/response/ApiResponse.dart';
import '../../repository/AuthRepo.dart';
import '../../utils/appUtil.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@Injectable()
class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final AuthRepo repository;
  CreateUserFormValidation validation = CreateUserFormValidation();
  AuthBloc({required this.repository})  : super(AuthInitial()) {
    on<AuthEventCreateUser>((event, emit) async {
      handleAccountCreateEvent(event);
    });
  }

initial(){
    emit(AuthInitial());
}


handleAccountCreateEvent(event) async{
  emit(AuthStateLoading());
  try {
    final response = await repository.createUser(event.request );
    if (response is AccountNumberResponse) {
      emit(AuthStateUserCreated(response));
      AppUtils.debug("success");
    }else{
      emit(AuthStateError(response as ApiResponse));
      AppUtils.debug("error");
    }
  }catch(e){
    emit(AuthStateError(AppUtils.defaultErrorResponse()));
  }
}
}

