class Singleton {
  static Singleton? _instance;
  Singleton._internal() {
    _instance = this;
  }
  factory Singleton() => _instance ?? Singleton._internal();

  double latitude = 0.0;
  double longitude = 0.0;

  double latitudeUser1 = 0.0;
  double longitudeUser1 = 0.0;

  String usuario = "";
  String correo = "";

  String selectRoute = "";
}
