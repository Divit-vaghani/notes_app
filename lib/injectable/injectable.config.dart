// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_core/firebase_core.dart' as _i982;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:notes_app/injectable/injectable.dart' as _i15;
import 'package:notes_app/services/auth_service.dart' as _i830;
import 'package:notes_app/services/firestore_service.dart' as _i289;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i982.FirebaseApp>(
      () => registerModule.initializeFireBase(),
      preResolve: true,
    );
    gh.factory<_i289.FirestoreService>(() => _i289.FirestoreService());
    gh.factory<_i830.AuthService>(() => _i830.AuthService());
    return this;
  }
}

class _$RegisterModule extends _i15.RegisterModule {}
