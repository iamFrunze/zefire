part of 'devices_list_bloc.dart';

@immutable
abstract class DevicesListEvent {}

class DevicesDiscoveryEvent extends DevicesListEvent {}

class UpdateDiscoveryListEvent extends DevicesListEvent{

  BluetoothDevice device;
  UpdateDiscoveryListEvent({this.device});

}

