import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../models/settings/server/server_parameters.dart';
import '../../../../models/settings/server/server_settings.dart';
import '../../../../models/settings/server/server_settings_file.dart';
import '../../../../repositories/repository_socket.dart';
import '../../../../utils/ui/colors_palette.dart';
import '../../../common_widgets/app_bar/page_app_bar.dart';

/// This class allows the user to change the server connection and polling
/// parameters. It also allows the user to save these parameters in a JSON file.
class ServerPage extends StatefulWidget {
  final String title = "Server";
  ServerPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> {
  final TextEditingController _ipAddressController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _pollingController = TextEditingController();
  var _subscription;
  String _connectivityStatus = "";
  bool _saveAsDefaultParameters = false;
  final snackBar =
      SnackBar(content: Text("Parameters has been updated correctly!"));

  @override
  void initState() {
    super.initState();

    // Get the initial status of the Internet connection.
    getInitialStatus();

    // Add a listener that will changed the status every time the Internet
    // connection changes.
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        _connectivityStatus = getTextStatus(result);
      });
    });
  }

  /// This method gets the initial status of the Internet connection.
  void getInitialStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      _connectivityStatus = getTextStatus(connectivityResult);
    });
  }

  /// Get the text based on the new detected Internet connection status.
  String getTextStatus(ConnectivityResult connectivityResult) {
    switch (connectivityResult) {
      case ConnectivityResult.wifi:
        return "WiFi";
        break;
      case ConnectivityResult.mobile:
        return "Mobile";
        break;
      case ConnectivityResult.none:
        return "Offline";
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {

    // Get the Repository through Provider.
    final RepositorySocket repository =
        Provider.of<RepositorySocket>(context, listen: false);

    // Get the ServerParameters through Provider.
    final ServerParameters _serverParameters =
        ServerParameters(repositorySocket: repository);

    // Get the parameters and show them on the page.
    String ipAddress = repository.socketService.serverIPAddress;
    int port = repository.socketService.serverPort;
    int pollingInterval = repository.pollingInterval;

    return Scaffold(
      appBar: PageAppBar(context: context, title: widget.title),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Builder(builder: (context) {
          return ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Connectivity status",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 3.0,
                      bottom: 3.0,
                      left: 15.0,
                      right: 15.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.0),
                      color: _connectivityStatus != "Offline"
                          ? ColorsPalette.greenBackground
                          : ColorsPalette.redBackground,
                    ),
                    child: Text(
                      _connectivityStatus,
                      style: TextStyle(
                        color: _connectivityStatus != "Offline"
                            ? ColorsPalette.coolGreen
                            : ColorsPalette.redAccent,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 10.0,
                  bottom: 10.0,
                ),
                decoration: BoxDecoration(
                  color: ColorsPalette.softGrey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text("IP Address"),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: 150,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(
                              20.0,
                              10.0,
                              20.0,
                              10.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: ipAddress,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          autofocus: false,
                          controller: _ipAddressController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 10.0,
                  bottom: 10.0,
                ),
                decoration: BoxDecoration(
                  color: ColorsPalette.softGrey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text("Port"),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: 150,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(
                              20.0,
                              10.0,
                              20.0,
                              10.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: port.toString(),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          autofocus: false,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: false,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          controller: _portController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 10.0,
                  bottom: 10.0,
                ),
                decoration: BoxDecoration(
                  color: ColorsPalette.softGrey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text("Polling"),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: 150,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(
                              20.0,
                              10.0,
                              20.0,
                              10.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: pollingInterval.toString() +
                                (pollingInterval == 1 ? " second" : " seconds"),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          autofocus: false,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: false,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          controller: _pollingController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: CheckboxListTile(
                      value: _saveAsDefaultParameters,
                      title: Text("Save as default parameters"),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool value) {
                        setState(() {
                          _saveAsDefaultParameters = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 62,
                    width: 320.0,
                    child: RaisedButton(
                      elevation: 0.0,
                      color: ColorsPalette.coolGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      onPressed: () {
                        _checkValues(ipAddress, port, pollingInterval,
                            repository, _serverParameters,
                            context: context, restart: false);
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 62,
                    width: 320.0,
                    child: RaisedButton(
                      elevation: 0.0,
                      color: ColorsPalette.yellowButton,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          "Save and Restart",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      onPressed: () {
                        _checkValues(ipAddress, port, pollingInterval,
                            repository, _serverParameters,
                            context: context, restart: true);
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 62,
                    width: 320.0,
                    child: RaisedButton(
                      elevation: 0.0,
                      color: ColorsPalette.redButton,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      onPressed: () {
                        _clearTextFields();
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  /// Clear all the [TextField]s of the page.
  void _clearTextFields() {
    _ipAddressController.clear();
    _portController.clear();
    _pollingController.clear();
  }

  /// Show an [AlertDialog] when new errors occur. It will be shown a specific
  /// [AlertDialog] for Android and one for iOS.
  _showAlertDialog(String textError) {
    return Platform.isIOS
        ? showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text("Attention"),
                content: Text(textError),
                actions: [
                  CupertinoDialogAction(
                    //isDefaultAction: true,
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            })
        : showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Attention"),
                content: Text(textError),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
  }

  /// This methods checks that the values insert by the user are correct.
  ///
  /// If the values insert are correct, this methods does:
  /// 1. Stop the [Timer] (and therefore, stop also the polling)
  /// 2. Save the new data (it could save the data also in the JSON file, only
  /// upon user request)
  /// 3. Restart the [Timer]
  ///
  /// If the values insert are not correct, this methods does:
  /// 1. Don't stop or restart the [Timer]
  /// 2. Present an [AlertDialog] for showing to the user the errors that
  /// occurred.
  void _checkValues(String ipAddress, int port, int pollingInterval,
      RepositorySocket repository, ServerParameters serverParameters,
      {@required BuildContext context, @required bool restart}) {

    // Get the values from the [TextField].
    String rawIPAddress = _ipAddressController.text;
    String rawPort = _portController.text;
    String rawPollingInterval = _pollingController.text;

    // Set some boolean values. They are necessary to detect if the app has to
    // shown an [AlertDialog].

    // Boolean values indicating whether the fields are empty or not.
    bool isIPAddressEmpty = false;
    bool isPortEmpty = false;
    bool isPollingIntervalEmpty = false;

    // Boolean values indicating if the variable can be updated with the value
    // received from the [TextField].
    bool isIPAddressUpdatable = false;
    bool isPortUpdatable = false;
    bool isPollingIntervalUpdatable = false;

    // Check if someone field is not empty.
    if (serverParameters.isSomeoneFilled(
        rawIPAddress, rawPort, rawPollingInterval)) {

      // Stop the timer.
      repository.stop();

      // Check if the values received by the user are empty.
      isIPAddressEmpty = serverParameters.isIPAddressEmpty(rawIPAddress);
      isPortEmpty = serverParameters.isPortEmpty(rawPort);
      isPollingIntervalEmpty =
          serverParameters.isPollingIntervalEmpty(rawPollingInterval);

      // If the parameter insert is not empty, check if the new value entered is
      // correct.
      if (!isIPAddressEmpty) {
        isIPAddressUpdatable =
            serverParameters.canUpdateIPAddress(rawIPAddress);
      }

      if (!isPortEmpty) {
        isPortUpdatable = serverParameters.canUpdatePort(rawPort);
      }

      if (!isPollingIntervalEmpty) {
        isPollingIntervalUpdatable =
            serverParameters.canUpdatePollingInterval(rawPollingInterval);
      }
    }

    // If the value insert are not correct, show an [AlertDialog].
    // Otherwise, update the parameters with the new values.
    // If the user requested it, save the new values in the JSON file.
    if ((!isIPAddressEmpty && !isIPAddressUpdatable) ||
        (!isPortEmpty && !isPortUpdatable) ||
        (!isPollingIntervalEmpty && !isPollingIntervalUpdatable)) {
      _showAlertDialog(serverParameters.textError);
    } else {
      if (!isIPAddressEmpty) {
        serverParameters.updateIP(rawIPAddress);
        setState(() {
          ipAddress = rawIPAddress.trim();
        });
        _ipAddressController.clear();
      }

      if (!isPortEmpty) {
        serverParameters.updatePort(rawPort);
        setState(() {
          port = int.parse(rawPort.trim());
        });
        _portController.clear();
      }

      if (!isPollingIntervalEmpty) {
        serverParameters.updatePollingInterval(rawPollingInterval);
        setState(() {
          pollingInterval = int.parse(rawPollingInterval.trim());
        });
        _pollingController.clear();
      }

      // Write the new server settings parameters in the JSON file.
      if (_saveAsDefaultParameters) {
        ServerSettingsFile.writeSettings(jsonEncode((ServerSettings(
                ipAddress: ipAddress,
                port: port.toString(),
                pollingInterval: pollingInterval.toString()))
            .toJson()));

        setState(() {
          _saveAsDefaultParameters = false;
        });
      }

      // Restart the timer.
      if (restart) {
        repository.start();
      }

      // Show the [SnackBar] to notify the user that all the data has been saved
      // correctly.
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
