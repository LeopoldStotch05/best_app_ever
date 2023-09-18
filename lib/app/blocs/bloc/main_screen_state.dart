part of 'main_screen_bloc.dart';

@immutable
/// Abstract state
sealed class MainScreenState {}

/// Initial screen state
final class MainScreenInitialState extends MainScreenState {}

/// Start state. Emits after tap event.
final class MainScreenStartState extends MainScreenState {}

/// End state. Emits on anim complete.
final class MainScreenEndState extends MainScreenState {}
