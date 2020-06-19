import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../blocs/dashboard/dashboard_widget_bloc.dart';
import '../../../../models/acronyms.dart';
import '../../../../models/ui/dashboard.dart';
import '../../../../repositories/repository_socket.dart';
import '../../../../utils/ui/colors_palette.dart';
import '../../../../utils/ui/themes/theme_handler.dart';
import '../../../common_widgets/app_bar/sensor_data_app_bar.dart';

/// This class implements the main Widget of [DashboardPage].
class DashboardWidget extends StatefulWidget {
  DashboardWidget(
      {Key key, @required this.dashboardBloc, @required this.themeHandler})
      : super(key: key);
  final DashboardWidgetBloc dashboardBloc;
  final ThemeHandler themeHandler;

  /// This method provides to set up the BLoC of this page.
  static Widget create(BuildContext context) {
    final RepositorySocket repository =
        Provider.of<RepositorySocket>(context, listen: false);

    final ThemeHandler themeHandler =
        Provider.of<ThemeHandler>(context, listen: false);

    return Provider<DashboardWidgetBloc>(
      create: (_) => DashboardWidgetBloc(
          repository: repository, socketData: repository.socketData),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<DashboardWidgetBloc>(
          builder: (context, bloc, _) =>
              DashboardWidget(dashboardBloc: bloc, themeHandler: themeHandler)),
    );
  }

  @override
  State<StatefulWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget>
    with AutomaticKeepAliveClientMixin<DashboardWidget> {
  @override
  bool get wantKeepAlive => true;

  /// This method sets up the stream.
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<Dashboard>(
      stream: widget.dashboardBloc.stream,
      initialData: Dashboard(),
      builder: (context, snapshot) {
        return _buildGrid(snapshot.data.toMap());
      },
    );
  }

  /// This method provides to build a grid for showing all the sensors data.
  Widget _buildGrid(Map<String, dynamic> dashboardData) {
    final List<String> keys = dashboardData.keys.toList();

    return Container(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 30.0,
        right: 30.0,
      ),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              top: 20.0,
              bottom: 20.0,
              left: 20.0,
              right: 20.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: widget.themeHandler.getBackgroundColorOfBox(),
              border: Border.all(
                  color: widget.themeHandler
                      .getBackgroundBorderOfBox()), //ColorsPalette.softGrey,
            ),
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 3,
              children: List.generate(
                dashboardData.length,
                (index) {
                  return _buildSingleBox(dashboardData, keys[index]);
                },
              ),
            ),
          ),
          SizedBox(height: 15.0),
          _buildButtons(),
        ],
      ),
    );
  }

  /// This method builds the base element of the grid. It shows text and value
  /// of sensors data.
  ///
  /// Through this method, the user can tap on one of these element to open
  /// a specific page of a sensor data.
  Widget _buildSingleBox(Map<String, dynamic> dashboardData, String key) {
    return InkWell(
      onTap: () async {
        Future<Widget> buildPageAsync() async {
          return Future.microtask(() {
            return Scaffold(
              appBar: SensorDataAppBar(context: context, title: key),
            );
          });
        }

        Widget page = await buildPageAsync();
        MaterialPageRoute route = MaterialPageRoute(builder: (_) => page);
        Navigator.push(context, route);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridTile(
          header: Center(
            child: Text(
              Acronym.reduceAcronym(key),
              style: TextStyle(
                color: widget.themeHandler
                    .getTitleOfSensorDataInDashboard(), //Colors.white,
              ),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: widget.themeHandler.getBackgroundColorOfSensorData(),
              border: Border.all(
                color: widget.themeHandler.getBorderColorOfSensorData(),
              ),
            ),
            child: Center(
              child: Text(
                dashboardData[key],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: widget.themeHandler.getTextColorOfSensorValues(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// This method provides to set up the buttons.
  ///
  /// These buttons allow you to start or stop the polling of the socket.
  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              height: 52.0,
              child: RaisedButton(
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                color: ColorsPalette.coolGreen,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                    Text(
                      "Start",
                      style: GoogleFonts.manrope(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  widget.dashboardBloc.start();
                },
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            flex: 2,
            child: Container(
              height: 52.0,
              child: RaisedButton(
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                color: ColorsPalette.redButton,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.stop,
                      color: Colors.white,
                    ),
                    Text(
                      "Stop",
                      style: GoogleFonts.manrope(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  widget.dashboardBloc.stop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
