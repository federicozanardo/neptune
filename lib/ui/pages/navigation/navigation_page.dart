import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../blocs/navigation/navigation_bloc.dart';
import '../../../models/ui/navigation.dart';
import '../../../repositories/repository_socket.dart';
import '../../../utils/ui/themes/theme_handler.dart';
import '../../common_widgets/grid_box/grid_box_widget.dart';

/// This class implements the page for [Navigation] data.  It uses [GridBox].
class NavigationPage extends StatefulWidget {
  NavigationPage(
      {Key key, @required this.navigationBloc, @required this.themeHandler})
      : super(key: key);
  final NavigationBloc navigationBloc;
  final ThemeHandler themeHandler;

  /// This method provides to set up the BLoC of this page.
  static Widget create(BuildContext context) {
    final RepositorySocket repository =
        Provider.of<RepositorySocket>(context, listen: false);

    final ThemeHandler themeHandler =
        Provider.of<ThemeHandler>(context, listen: false);

    return Provider<NavigationBloc>(
      create: (_) => NavigationBloc(
          repository: repository, socketData: repository.socketData),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<NavigationBloc>(
          builder: (context, bloc, _) =>
              NavigationPage(navigationBloc: bloc, themeHandler: themeHandler)),
    );
  }

  @override
  State<StatefulWidget> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with AutomaticKeepAliveClientMixin<NavigationPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GridBox(
      bloc: widget.navigationBloc,
      themeHandler: widget.themeHandler,
      initialData: Navigation(),
    );
  }
}
