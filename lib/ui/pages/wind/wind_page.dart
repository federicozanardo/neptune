import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../blocs/wind/wind_bloc.dart';
import '../../../models/ui/wind.dart';
import '../../../repositories/repository_socket.dart';
import '../../../utils/ui/themes/theme_handler.dart';
import '../../common_widgets/grid_box/grid_box_widget.dart';

/// This class implements the page for [Wind] data. It uses [GridBox].
class WindPage extends StatefulWidget {
  WindPage({Key key, @required this.windBloc, @required this.themeHandler})
      : super(key: key);
  final WindBloc windBloc;
  final ThemeHandler themeHandler;

  /// This method provides to set up the BLoC of this page.
  static Widget create(BuildContext context) {
    final RepositorySocket repository =
        Provider.of<RepositorySocket>(context, listen: false);

    final ThemeHandler themeHandler =
        Provider.of<ThemeHandler>(context, listen: false);

    return Provider<WindBloc>(
      create: (_) =>
          WindBloc(repository: repository, socketData: repository.socketData),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<WindBloc>(
        builder: (context, bloc, _) => WindPage(
          windBloc: bloc,
          themeHandler: themeHandler,
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _WindPageState();
}

class _WindPageState extends State<WindPage>
    with AutomaticKeepAliveClientMixin<WindPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GridBox(
      bloc: widget.windBloc,
      themeHandler: widget.themeHandler,
      initialData: Wind(),
    );
  }
}
