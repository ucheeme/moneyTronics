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
    // gh.factory<_i4.AuthRepo>(() => _i4.AuthRepo());
    // gh.factory<_i5.AuthBloc>(
    //     () => _i5.AuthBloc(repository: gh<_i4.AuthRepo>()));
    return this;
  }
}
