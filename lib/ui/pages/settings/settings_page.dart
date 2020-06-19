import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/ui/colors_palette.dart';
import '../../common_widgets/app_bar/page_app_bar.dart';
import 'cache/cache_page.dart';
import 'server/server_page.dart';
import 'theme/theme_page.dart';

///
class SettingsPage extends StatefulWidget {
  final String title = "Settings";

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with AutomaticKeepAliveClientMixin<SettingsPage> {

  /// Map the name of the page selected with the respective page, title,
  /// subtitle and leading.
  final Map<String, dynamic> options = {
    "cache": {
      "title": Text("Cache"),
      "leading": Icon(Icons.cached),
      "subtitle": Text("Delete the data saved from the app"),
      "page": CachePage(),
    },
    "server": {
      "title": Text("Server"),
      "leading": Icon(Icons.perm_data_setting),
      "subtitle": Text("Choose the server to connect to"),
      "page": ServerPage(),
    },
    "theme": {
      "title": Text("Theme"),
      "leading": Icon(Icons.color_lens),
      "subtitle": Text("Choose the theme of the app"),
      "page": ThemePage(),
    },
  };

  /// This method allows you to get the page's object from the map.
  StatefulWidget _getSettingPage(String option) {
    return options[option]["page"];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: PageAppBar(context: context, title: widget.title),
      body: ListView.builder(
        itemCount: options.length,
        itemBuilder: (ctx, i) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 25.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: ColorsPalette.softGrey,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                leading: options[options.keys.toList()[i]]["leading"],
                title: options[options.keys.toList()[i]]["title"],
                subtitle: options[options.keys.toList()[i]]["subtitle"],
                trailing: Icon(CupertinoIcons.forward),
                onTap: () async {
                  Future<Widget> buildPageAsync() async {
                    return Future.microtask(() {
                      return _getSettingPage(options.keys.toList()[i]);
                    });
                  }

                  Widget page = await buildPageAsync();
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (_) => page);
                  Navigator.push(context, route);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
