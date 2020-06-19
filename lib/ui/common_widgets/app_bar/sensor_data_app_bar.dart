import 'package:flutter/material.dart';

/// This class implements a custom App Bar for sensor data pages.
class SensorDataAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final String title;
  SensorDataAppBar({@required this.context, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 30.0,
              bottom: 30.0,
            ),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.arrow_back_ios),
                  onTap: () {
                    Navigator.pop(this.context);
                  },
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * 2.5);
}