class Bioburner {
  BioburnerStatus status;
  String statusText;
  String model;
  int flameSize;
  final int maxFlameSize = 6;
  int fuelVolume;
  bool powerIsOn;

  Bioburner(
      this.model, this.flameSize, this.fuelVolume, this.status, this.powerIsOn)
      : statusText = _bioburnerStatusToText[status];
}

enum BioburnerStatus {
  ready,
  warming,
  ignition,
  work,
  cooling,
  lidNotClosed,
  fuelSpill,
  fuelOverflow,

}

Map<BioburnerStatus, String> _bioburnerStatusToText = {
  BioburnerStatus.ready: "система готова",
  BioburnerStatus.warming: "Разогрев",
  BioburnerStatus.ignition: "Розжиг",
  BioburnerStatus.work: "Работа",
  BioburnerStatus.cooling: "Остывание",
  BioburnerStatus.lidNotClosed: "Не закрыт люк",
  BioburnerStatus.fuelSpill: "Разлив топлива, остывание",
  BioburnerStatus.fuelOverflow: "Перелив топлива",

};
