import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/createAcctRepo.dart';
import 'createUserFormValidation.dart';

part 'create_acct_state.dart';

class CreateAcctCubit extends Cubit<CreateAcctState> {
  final CreateUserAcctRepo repo;
  CreateAcctCubit({required this.repo}) : super(CreateAcctInitialState());
  CreateUserFormValidation validation = CreateUserFormValidation();
}
