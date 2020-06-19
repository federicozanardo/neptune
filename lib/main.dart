import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'models/settings/server/server_settings.dart';
import 'models/settings/server/server_settings_file.dart';
import 'repositories/repository_socket.dart';
import 'ui/pages/dashboard/dashboard_page.dart';
import 'ui/pages/gps/gps_page.dart';
import 'ui/pages/navigation/navigation_page.dart';
import 'ui/pages/settings/settings_page.dart';
import 'ui/pages/wind/wind_page.dart';
import 'utils/ui/themes/default_theme.dart';
import 'utils/ui/themes/theme_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ServerSettingsFile.readSettings(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var map = jsonDecode(snapshot.data);
          var serverSettings = ServerSettings.fromJson(map);

          return Provider<ThemeHandler>(
            create: (context) => ThemeHandler(theme: DefaultTheme()),
            child: Provider<RepositorySocket>(
              create: (context) =>
                  RepositorySocket(serverSettings: serverSettings),
              dispose: (context, repository) => repository.dispose(),
              child: MaterialApp(
                title: 'Neptune',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  pageTransitionsTheme: PageTransitionsTheme(builders: {
                    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  }),
                  textTheme: GoogleFonts.manropeTextTheme(
                    Theme.of(context).textTheme,
                  ),
                ),
                /*
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.blue,
            ),*/
                home: MyHomePage(title: 'Neptune'),
              ),
            ),
          );
        } else {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
            color: Colors.white,
          );
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  PageController _pageController;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: _currentIndex,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getSelectedTab(index) async {
    if (index == _currentIndex + 1 || index == _currentIndex - 1) {
      await _pageController.animateToPage(
        index,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      );
      setState(() {
        _currentIndex = index;
      });
    } else {
      setState(() {
        _currentIndex = index;
        _pageController.jumpToPage(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          kToolbarHeight * 2.5,
        ), // kToolbarHeight = 56.0
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                  top: 30.0,
                  bottom: 30.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () => _scaffoldKey.currentState.openDrawer(),
                      child: Icon(Icons.menu),
                    ),
                    /*
                    InkWell(
                      child: Icon(Icons.more_vert),
                      onTap: () {},
                    ),*/
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage("assets/images/logo.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            title: Text("Dashboard"),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.water),
            title: Text("Navigation"),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.locationArrow),
            title: Text("GPS"),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.wind),
            title: Text("Wind"),
          ),
        ],
        onTap: (index) {
          _getSelectedTab(index);
        },
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        children: <Widget>[
          DashboardPage(),
          NavigationPage.create(context),
          GPSPage.create(context),
          WindPage.create(context),
        ],
        onPageChanged: (index) {
          _getSelectedTab(index);
        },
      ),
    );
  }
}
