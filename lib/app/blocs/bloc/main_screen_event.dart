part of 'main_screen_bloc.dart';

@immutable
///AAbstract event
sealed class MainScreenEvent {}

/// Event adds on tap 
final class MainScreenTap extends MainScreenEvent {}

/// Event adds on animation end
final class MainScreenEnd extends MainScreenEvent {}
