import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    required bool isLoading,
    String? error,
    String? web1,
    String? web2,
    String? web3,
    String? web4,
  }) = _MainState;

  factory MainState.initial({
    String? id,
  }) =>
      MainState(
        isLoading: false,
      );
}
