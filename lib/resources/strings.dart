class Strings {
  static String controlPanelSystemStatusTitle = "Статус системы";
  static String controlPanelPowerTitle = "Питание";
  static String controlPanelFlameSizeTitle = "Уровень пламени";
  static String controlPanelFuelVolumeTitle = "Уровень топлива";
  static String controlPanelOderFuelTitle = "Заказ топлива";
  static String controlPanelMakeCallButton = "По телефону";
  static String controlPanelOpenWebsiteButton = "Через сайт";
  static String controlPanelError = "Произошла ошибка";
  static String startScreenStartButton = "Начать";

  static String deviceSearch = "Поиск устройства";
  static String chooseFireplace =
      "Выберите ваш камин среди доступных устройств с bluetooth";
  static String availableDevices = "Доступные устройства";
  static String otherDevices = "Другие устройства";
  static String connected = "Подключено";
  static String disabled = "Отключено";
  static String connecting = "Подключить";

  static String connectionEstablishedTitle = "Соединение установлено";
  static String connectionEstablishedDescription =
      "Приятного отдыха у биокамина ZEFIRE!";
  static String canceling = "Отмена";
  static String next = "Дальше";
  static String deviceConnection = "Соединение с устройством";
  static String enterCode =
      '''Введите код с устройства и нажмите “Разрешить”''';
  static String allow = "Разрешить";

  static String permissionConnect(String device) =>
      'Устройство “$device” запрашивает разрешение на синхронизацию с вашим телефоном.';
  static String start = "Начать";

  static String routeToDeviceSearchScreen = '/device_search';
  static String routeToConnectionStateScreen = '/connection_state';
  static String routeToControlPaneScreen = '/control_pane';
  static String routeToStartScreen = '/';

  static String errorTitle = "Ошибка";

  static String unknownError = "Что-то пошло не так";
  static String connectionNotEstablishedTitle = "Соединение не установлено";

  static String retry = "Повторить";
  static String isEmptyDiscovery = "Устройство не найдены";
}
