import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../blocs/location/location_widget_bloc.dart';
import '../../../models/repository/repository_data_model.dart';
import '../../../models/ui/location.dart';
import '../../../repositories/repository_socket.dart';
import '../../../utils/ui/themes/theme_handler.dart';
import '../app_bar/sensor_data_app_bar.dart';

/// These classes implement the [LocationWidget].
class LocationWidget extends StatefulWidget {
  LocationWidget(
      {Key key, @required this.locationBloc, @required this.themeHandler})
      : super(key: key);
  final LocationWidgetBloc locationBloc;
  final ThemeHandler themeHandler;

  /// This method provides to set up the BLoC of this Widget.
  static Widget create(BuildContext context) {
    final RepositorySocket repository = Provider.of<RepositorySocket>(context);

    final ThemeHandler themeHandler =
        Provider.of<ThemeHandler>(context, listen: false);

    return Provider<LocationWidgetBloc>(
      create: (_) => LocationWidgetBloc(
          repository: repository, socketData: repository.socketData),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<LocationWidgetBloc>(
        builder: (context, bloc, _) => LocationWidget(
          locationBloc: bloc,
          themeHandler: themeHandler,
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget>
    with AutomaticKeepAliveClientMixin<LocationWidget> {
  Location locationData;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: StreamBuilder<Location>(
        stream: widget.locationBloc.stream,
        initialData: null,
        builder: (context, snapshot) {
          RepositoryDataModel cachedData =
              widget.locationBloc.repository.cache.lastData;

          if (snapshot.data == null && cachedData == null) {
            locationData = Location();
          } else if (snapshot.data == null) {
            locationData = widget.locationBloc.getDataFromJSON(cachedData);
          } else {
            locationData = snapshot.data;
          }

          return _buildLocationBox(locationData);
        },
      ),
    );
  }

  /// This method draws the box where the data will be placed.
  Widget _buildLocationBox(Location locationData) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30.0,
        right: 30.0,
        bottom: 10.0,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: SensorDataAppBar(context: context, title: "Location"),
              ),
            ),
          );
        },
        child: Container(
          height: 60.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: widget.themeHandler.getBackgroundColorOfBox(),
            border: Border.all(
                color: widget.themeHandler.getBackgroundBorderOfBox()),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildElement("latitude", locationData.latitude),
              SizedBox(width: 10.0),
              _buildElement("longitude", locationData.longitude),
            ],
          ),
        ),
      ),
    );
  }

  /// This method provides to show the text and values.
  Widget _buildElement(String label, String parameter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(color: widget.themeHandler.getTextColorOfLocation()),
        ),
        Center(
          child: Text(
            parameter == null ? "NaN" : parameter,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: widget.themeHandler.getTextColorOfLocation(),
            ),
          ),
        ),
      ],
    );
  }
}
