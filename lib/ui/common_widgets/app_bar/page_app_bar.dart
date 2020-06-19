import 'package:flutter/material.dart';

/// This class implements a custom App Bar.
class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final String title;
  PageAppBar({@required this.context, @required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * 2.5);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 27.0,
              right: 20.0,
              top: 30.0,
              bottom: 30.0,
            ),
            child: Row(
              children: <Widget>[
                InkWell(
                  child: Icon(Icons.arrow_back_ios),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
