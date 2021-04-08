part of 'start_bloc.dart';

@immutable
abstract class StartEvent {}

class GetBondedDevices extends StartEvent {}
class TestService extends StartEvent {}