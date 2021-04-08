part of 'devices_list_bloc.dart';

@immutable
abstract class DevicesListState {}

class DevicesListInitial extends DevicesListState {}

class DeviceListEmptyState extends DevicesListState {}

class DeviceListLoadedState extends DevicesListState {
  final List<BluetoothDevice> arrayOfResult;

  DeviceListLoadedState({this.arrayOfResult});
}

class DeviceListLoadingState extends DevicesListState {}

class DeviceListFailureState extends DevicesListState {
  String titleErrorText;
  String descErrorText;

  DeviceListFailureState({this.titleErrorText, this.descErrorText});
}
