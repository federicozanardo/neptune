/// This class saves the data about server connection and polling.
class ServerSettings {
  String ipAddress;
  String port;
  String pollingInterval;

  /// Constructor.
  ///
  /// The default parameters represent the default data to establish a server
  /// connection.
  ServerSettings(
      {this.ipAddress = "192.168.1.10", this.port = "4545", this.pollingInterval = "5"});

  /// Through this method it allows you to parse the data from JSON.
  factory ServerSettings.fromJson(Map<String, dynamic> json) {
    return ServerSettings(
      ipAddress: json['ip'],
      port: json['port'],
      pollingInterval: json['polling'],
    );
  }

  /// This method permits you to get the data in JSON format.
  Map<String, dynamic> toJson() => {
        'ip': ipAddress,
        'port': port,
        'polling': pollingInterval,
      };
}
