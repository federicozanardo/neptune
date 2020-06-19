import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common_widgets/location/location_widget.dart';
import 'widgets/dashboard_widget.dart';

/// This class implements the main page of the app.
class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with AutomaticKeepAliveClientMixin<DashboardPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildUI();
  }

  /// This method builds the dashboard UI
  ///
  /// This method calls [DashboardWidget] and [LocationWidget].
  Widget _buildUI() {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        LocationWidget.create(context),
        DashboardWidget.create(context),
      ],
    );
  }
}
