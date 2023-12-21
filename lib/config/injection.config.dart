// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../ApiService/ApiService.dart' as _i3;
import '../Repository/BillRepository.dart' as _i5;
import '../bloc/AuthBloc/auth_bloc.dart' as _i11;
import '../repository/AuthRepo.dart'as _i4;
import '../repository/DashboardRepository.dart' as _i6;
import '../repository/ProfileRepository.dart' as _i7;
import '../repository/SettingsRepository.dart' as _i9;
import '../repository/TransactionRepository.dart' as _i10;
import '../repository/securityQuestionTransactionPInRepo.dart' as _i8;
// import '../Bloc/AuthBloc/auth_bloc.dart' as _i5;
// import '../Repository/AuthRepository.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.ApiService>(() => _i3.ApiService());
    gh.factory<_i4.AuthRepo>(() => _i4.AuthRepo());
    gh.factory<_i5.BillRepository>(() => _i5.BillRepository());
    gh.factory<_i6.DashboardRepository>(() => _i6.DashboardRepository());
    gh.factory<_i7.ProfileRepository>(() => _i7.ProfileRepository());
    gh.factory<_i8.SecurityQuestionTransactionPinRepository>(
            () => _i8.SecurityQuestionTransactionPinRepository());
    gh.factory<_i9.SettingsRepository>(() => _i9.SettingsRepository());
    gh.factory<_i10.TransactionRepository>(() => _i10.TransactionRepository());
    gh.factory<_i11.AuthBloc>(
            () => _i11.AuthBloc(repository: gh<_i4.AuthRepo>()));
    return this;
  }
}

