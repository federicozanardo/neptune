import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../blocs/gps/gps_bloc.dart';
import '../../../models/ui/gps.dart';
import '../../../repositories/repository_socket.dart';
import '../../../utils/ui/themes/theme_handler.dart';
import '../../common_widgets/grid_box/grid_box_widget.dart';

/// This class implements the page for [GPS] data. It uses [GridBox].
class GPSPage extends StatefulWidget {
  GPSPage({Key key, @required this.gpsBloc, @required this.themeHandler})
      : super(key: key);
  final GPSBloc gpsBloc;
  final ThemeHandler themeHandler;

  /// This method provides to set up the BLoC of this page.
  static Widget create(BuildContext context) {
    final RepositorySocket repository =
        Provider.of<RepositorySocket>(context, listen: false);

    final ThemeHandler themeHandler =
        Provider.of<ThemeHandler>(context, listen: false);

    return Provider<GPSBloc>(
      create: (_) =>
          GPSBloc(repository: repository, socketData: repository.socketData),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<GPSBloc>(
        builder: (context, bloc, _) => GPSPage(
          gpsBloc: bloc,
          themeHandler: themeHandler,
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _GPSPageState();
}

class _GPSPageState extends State<GPSPage>
    with AutomaticKeepAliveClientMixin<GPSPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GridBox(
      bloc: widget.gpsBloc,
      themeHandler: widget.themeHandler,
      initialData: GPS(),
    );
  }
}
