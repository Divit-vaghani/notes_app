import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/firebase_options.dart';
import 'package:notes_app/injectable/injectable.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configuration({required void Function() runApp}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await getIt.init();
  runApp();
}

@module
abstract class RegisterModule {
  @preResolve
  Future<FirebaseApp> initializeFireBase() =>
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
