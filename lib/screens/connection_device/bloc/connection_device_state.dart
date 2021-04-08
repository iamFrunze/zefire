part of 'connection_device_bloc.dart';

@immutable
abstract class ConnectionDeviceState {}

class ConnectionDeviceInitial extends ConnectionDeviceState {}

class ConnectionSuccessState extends ConnectionDeviceState {}

class ConnectionFailureState extends ConnectionDeviceState {}
