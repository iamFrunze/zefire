part of 'start_bloc.dart';

@immutable
abstract class StartState {}

class StartInitial extends StartState {}

class RouteToSearchState extends StartState {}

class RouteToControlState extends StartState {}

class SearchForDevices extends StartState {}
