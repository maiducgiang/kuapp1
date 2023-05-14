import 'dart:typed_data';
import 'dart:ui';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuapp1/cubit/main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState.initial());
  final _remoteConfig = FirebaseRemoteConfig.instance;
  void init() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 60),
      minimumFetchInterval: const Duration(seconds: 1),
    ));
    await _remoteConfig.ensureInitialized();
    await _remoteConfig.activate();
    await _remoteConfig.fetchAndActivate().then((value) {
      emit(state.copyWith(
        web1: _remoteConfig.getString('weblink1'),
        web2: _remoteConfig.getString('weblink2'),
        web3: _remoteConfig.getString('weblink3'),
        web4: _remoteConfig.getString('weblink4'),
      ));
    });
  }
}
