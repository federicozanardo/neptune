import 'package:flutter/material.dart';

import '../../../blocs/bloc.dart';
import '../../../models/acronyms.dart';
import '../../../models/repository/repository_data_model.dart';
import '../../../models/ui/base_model.dart';
import '../../../utils/ui/themes/theme_handler.dart';
import '../app_bar/sensor_data_app_bar.dart';
import '../location/location_widget.dart';

/// This class provides to build a grid Widget.
class GridBox<T extends BaseModel> extends StatefulWidget {
  final Bloc bloc;
  final ThemeHandler themeHandler;
  T initialData;

  GridBox(
      {Key key,
      @required this.bloc,
      @required this.themeHandler,
      @required this.initialData})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _GridBox();
}

class _GridBox<T extends BaseModel> extends State<GridBox>
    with AutomaticKeepAliveClientMixin<GridBox> {
  BaseModel _model;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildUI();
  }

  /// This method sets up the Widget with the stream.
  Widget _buildUI() {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        LocationWidget.create(context),
        Container(
          child: StreamBuilder<T>(
            stream: widget.bloc.stream,
            initialData:
                null, // Because in this way I can load the data from cache
            builder: (context, snapshot) {
              RepositoryDataModel cachedData =
                  widget.bloc.repository.cache.lastData;

              // Cached data is never empty because I start the polling in the DashboardPage.
              // So, when the polling has started, I already have cached data.

              if (snapshot.data == null && cachedData == null) {
                _model = widget.initialData;
              } else if (snapshot.data == null) {
                _model = widget.bloc.getDataFromJSON(cachedData);
              } else {
                _model = snapshot.data;
              }
              return Padding(
                padding: const EdgeInsets.only(
                  top: 80,
                  left: 30.0,
                  right: 30.0,
                ),
                child: _buildGrid(_model.toMap()),
              );
            },
          ),
        ),
      ],
    );
  }

  /// This method sets up the Grid.
  Widget _buildGrid(Map<String, dynamic> navigationData) {
    final List<String> keys = navigationData.keys.toList();

    return Container(
      padding: const EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
        left: 20.0,
        right: 20.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: widget.themeHandler.getBackgroundColorOfBox(),
        border:
            Border.all(color: widget.themeHandler.getBackgroundBorderOfBox()),
      ),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        children: List.generate(
          navigationData.length,
          (index) {
            return _buildGridTile(Acronym.getExtendedName(keys[index]),
                navigationData[keys[index]].toString());
          },
        ),
      ),
    );
  }

  /// This method provides to set the title of every single element of the grid.
  Widget _buildGridTile(String title, String value) {
    return GridTile(
      header: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      child: Center(
        child: _setupBox(title, value),
      ),
    );
  }

  /// This method sets up the basic element of the grid.
  ///
  /// Through this method, the user can tap on it to open a specific page
  /// (sensor data page).
  Widget _setupBox(String title, String value) {
    return InkWell(
      onTap: () async {
        Future<Widget> buildPageAsync() async {
          return Future.microtask(() {
            return Scaffold(
              appBar: SensorDataAppBar(context: context, title: title),
              body: Column(
                children: <Widget>[
                  Center(
                    child: _buildBox(title, value),
                  ),
                ],
              ),
            );
          });
        }

        Widget page = await buildPageAsync();
        MaterialPageRoute route = MaterialPageRoute(builder: (_) => page);
        Navigator.push(context, route);
      },
      child: _buildBox(title, value),
    );
  }

  /// This method provides to build the basic element of the grid.
  Widget _buildBox(String title, String value) {
    return Container(
      width: 110.0,
      height: 110.0,
      decoration: BoxDecoration(
        color: widget.themeHandler.getBackgroundColorOfSensorData(),
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(
          color: widget.themeHandler.getBorderColorOfSensorData(),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: widget.themeHandler.getTextColorOfSensorValues(),
            ),
          ),
        ],
      ),
    );
  }
}
