import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneytronic/cubits/otpCubit/otp_cubit.dart';
import 'package:moneytronic/cubits/signupCubit/signup_cubit.dart';
import 'package:moneytronic/repository/createAcctRepo.dart';
import 'package:moneytronic/repository/loginRepo/login_repo.dart';
import 'package:nested/nested.dart';

import '../Repository/BillRepository.dart';
import '../Repository/SettingsRepository.dart';
import '../bloc/AuthBloc/auth_bloc.dart';
import '../bloc/BillBloc/bill_bloc.dart';
import '../bloc/Dashboard/dashboard_bloc.dart';
import '../bloc/FixedDepositCalculator/fixed_deposit_calculator_bloc.dart';
import '../bloc/TransactionBloc/transaction_bloc.dart';
import '../bloc/profileBloc/profile_bloc.dart';
import '../bloc/setSecreteQuestion/secreteQuestionBloc.dart';
import '../bloc/setTransactionPin/transaction_pin_bloc.dart';
import '../bloc/settings/setting_bloc.dart';
import '../cubits/createAcctCubit/create_acct_cubit.dart';
import '../cubits/loginCubit/login_user_cubit.dart';
import '../repository/AuthRepo.dart';
import '../repository/FDRepository.dart';
import '../repository/ProfileRepository.dart';
import '../repository/TransactionRepository.dart';
import '../repository/dashboardRepository.dart';
import '../repository/securityQuestionTransactionPInRepo.dart';
import '../repository/signupRepo.dart';

class ProviderWidget{
  static List<SingleChildWidget> blockProviders(){
    return [
      BlocProvider(create: (BuildContext context) =>  LoginUserCubit(repository: LoginRepository())),
      BlocProvider(create: (BuildContext context) =>  OtpCubit(authRepository: AuthRepo())),
      BlocProvider(create: (BuildContext context) =>  SignupCubit(repository: SignUpRepository())),
      BlocProvider(create: (BuildContext context) =>  CreateAcctCubit(repo: CreateUserAcctRepo())),
      BlocProvider(create: (BuildContext context) =>  SetSecreteQuestionBloc(repository: SecurityQuestionTransactionPinRepository())),
      BlocProvider(create: (BuildContext context) =>  TransactionPinBloc()),
      BlocProvider(create: (BuildContext context) =>  BillBloc(repository:BillRepository())),
      BlocProvider(create: (BuildContext context) =>  DashboardBloc(repository:DashboardRepository())),
      BlocProvider(create: (BuildContext context) =>  FixedDepositCalculatorBloc(repository: FDRepository())),
      BlocProvider(create: (BuildContext context) =>  ProfileBloc(repository: ProfileRepository())),
      BlocProvider(create: (BuildContext context) =>  SettingBloc(repository: SettingsRepository())),
      BlocProvider(create: (BuildContext context) =>  SettingBloc(repository: SettingsRepository())),
      BlocProvider(create: (BuildContext context) =>  TransactionBloc(TransactionRepository())),
      BlocProvider(create: (BuildContext context) =>  AuthBloc(repository: AuthRepo())),
    ];

  }
}