part of 'control_panel_bloc.dart';

@immutable
abstract class ControlPanelEvent {}

class ControlPanelConnectionRequested extends ControlPanelEvent {}

class FlameSizeDecreaseEvent extends ControlPanelEvent {}

class FlameSizeIncreaseEvent extends ControlPanelEvent {}

class OpenShopEvent extends ControlPanelEvent {}

class PowerToggleEvent extends ControlPanelEvent {}

class MakeCallEvent extends ControlPanelEvent {}

class InitEvent extends ControlPanelEvent {}

class UpdateDataEvent extends ControlPanelEvent {}
