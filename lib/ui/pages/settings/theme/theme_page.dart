import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/ui/themes/theme_handler.dart';
import '../../../../utils/ui/themes/themes.dart';
import '../../../common_widgets/app_bar/page_app_bar.dart';

/// This class allows the user to modify the currently active theme of the app.
class ThemePage extends StatefulWidget {
  final String title = "Theme";
  ThemePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  bool _isHighContrastActivate = false;

  @override
  Widget build(BuildContext context) {

    // Get the ThemeHandler through Provider.
    final ThemeHandler themeHandler =
        Provider.of<ThemeHandler>(context, listen: false);

    // Verify that the [HighContrastTheme] is currently active.
    if(themeHandler.themeChosen == Themes.HIGH_CONTRAST) {
      _isHighContrastActivate = true;
    }

    return Scaffold(
      appBar: PageAppBar(context: context, title: widget.title),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text((_isHighContrastActivate ? "Deactivate" : "Activate") +
                      " the High Contrast theme"),
                  Switch(
                    value: _isHighContrastActivate,
                    onChanged: (value) {

                      // Switch the theme.
                      setState(() {
                        _isHighContrastActivate = value;
                        setState(() {
                          _isHighContrastActivate
                              ? themeHandler.applyTheme(Themes.HIGH_CONTRAST)
                              : themeHandler.applyTheme(Themes.DEFAULT);
                        });
                      });
                    },
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
