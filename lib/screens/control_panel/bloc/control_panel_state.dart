part of 'control_panel_bloc.dart';

@immutable
abstract class ControlPanelState {}

class ControlPanelLoadState extends ControlPanelState {}

class ControlPanelInitial extends ControlPanelState {
  final Bioburner bioburner;

  ControlPanelInitial(this.bioburner);
}

class ControlPanelConnected extends ControlPanelState {
  final Bioburner bioburner;

  ControlPanelConnected(this.bioburner);
}

class ControlPanelConnectionInProgress extends ControlPanelState {}

class ControlPanelError extends ControlPanelState {
  final String error;

  ControlPanelError(this.error);
}
