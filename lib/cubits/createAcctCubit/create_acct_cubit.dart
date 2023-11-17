import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/response/AccountNumberResponse.dart';
import '../../models/response/ApiResponse.dart';
import '../../repository/createAcctRepo.dart';
import '../../utils/appUtil.dart';
import 'createUserFormValidation.dart';

part 'create_acct_state.dart';

class CreateAcctCubit extends Cubit<CreateAcctState> {
  final CreateUserAcctRepo repo;
  CreateAcctCubit({required this.repo}) : super(CreateAcctInitialState());
  CreateUserFormValidation validation = CreateUserFormValidation();
  initial(){
    emit(CreateAcctInitialState());
  }


  handleAccountCreateEvent(event) async{
    emit(CreateAcctLoadingState());
    try {
      final response = await repo.createUser(event.request );
      if (response is AccountNumberResponse) {
        emit(CreateAcctSuccessfulState(response));
        AppUtils.debug("success");
      }else{
        emit(CreateAcctErrorState(response as ApiResponse));
        AppUtils.debug("error");
      }
    }catch(e){
      emit(CreateAcctErrorState(AppUtils.defaultErrorResponse()));
    }
  }
}
