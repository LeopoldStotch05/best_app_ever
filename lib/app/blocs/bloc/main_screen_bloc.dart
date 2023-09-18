// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

/// Main screen bloc (almost empty but useful)
class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  /// Main screen bloc constructor
  MainScreenBloc() : super(MainScreenInitialState()) {
    on<MainScreenTap>((event, emit) {
      emit(MainScreenStartState());
    });

    on<MainScreenEnd>((event, emit) {
      emit(MainScreenEndState());
    });
  }
}
