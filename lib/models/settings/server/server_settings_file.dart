import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'server_settings.dart';

/// This class represents an interface between the app and the JSON file.
class ServerSettingsFile {

  /// This method permits you to read the content in the JSON file.
  ///
  /// Create the file when it is not present in local storage.
  static Future<String> readSettings() async {

    // Get the path of local storage.
    final path = (await getApplicationDocumentsDirectory()).path;

    // Get the path of the file.
    final file = File('$path/settings.json');

    // Encode the settings data in JSON.
    var defaultSettings = jsonEncode((ServerSettings()).toJson());

    try {
      // Create the file if it doesn't exists. If the file doesn't exist, write
      // the settings on it.
      if (await file.exists() == false) {
        file.create();
        writeSettings(defaultSettings);
        return defaultSettings;
      } else {
        String contents = await file.readAsString();

        if (contents == "") {
          writeSettings(defaultSettings);
          return defaultSettings;
        }
        return contents;
      }
    } catch (e) {
      return "";
    }
  }

  /// This method allows you to write the settings in JSON file.
  static Future<File> writeSettings(String serverSettings) async {

    // Get the path of local storage.
    final path = (await getApplicationDocumentsDirectory()).path;

    // Get the path of the file.
    final file = File('$path/settings.json');

    // Write the settings on JSON file.
    return file.writeAsString(serverSettings.toString());
  }
}
