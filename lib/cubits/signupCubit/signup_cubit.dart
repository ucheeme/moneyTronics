import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/signupRepo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignUpRepository repository;
  SignupCubit({required this.repository}) : super(SignupInitialState());


}
