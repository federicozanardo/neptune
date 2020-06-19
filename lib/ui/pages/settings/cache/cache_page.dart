import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/repository/repository_data_model.dart';
import '../../../../models/settings/cache/cache.dart';
import '../../../../repositories/repository_socket.dart';
import '../../../common_widgets/app_bar/page_app_bar.dart';

/// This class allows the user to clean the cache.
class CachePage extends StatefulWidget {
  final String title = "Cache";
  CachePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CachePage();
}

class _CachePage extends State<CachePage> {
  bool isButtonDisabled = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    // Get the Repository through Provider.
    final RepositorySocket repository =
        Provider.of<RepositorySocket>(context, listen: false);

    // Get the Repository's cache.
    Cache<RepositoryDataModel> cache = repository.cache;

    // Get the number of elements saved in the cache.
    int numberOfObjectsInCache = cache.size;

    // Enable the button if [cache.size] is greater than zero.
    // Otherwise, keep the button disabled.
    setState(() {
      isButtonDisabled = cache.isCacheEmpty();
    });

    return Scaffold(
      appBar: PageAppBar(context: context, title: widget.title),
      body: ListView(
        children: <Widget>[
          Padding(
            key: _scaffoldKey,
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: <Widget>[
                InkWell(
                  child: Container(
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Data saved in cache"),

                        // Listen as soon as new data arrives.
                        ValueListenableBuilder(
                            valueListenable: repository.socketData,
                            builder: (context, value, _) {
                              return Text(repository.cache.size.toString());
                            }),
                      ],
                    ),
                  ),
                  onTap: () {
                    if (numberOfObjectsInCache > 0) {
                      Platform.isIOS
                          ? showCupertinoDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: Text("Clear cache"),
                                  content:
                                      Text("Are you sure to clear the cache?"),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text("Clear"),
                                      onPressed: () {
                                        Navigator.of(context).pop();

                                        if (!isButtonDisabled) {
                                          cache.emptyCache();
                                          setState(() {
                                            numberOfObjectsInCache = cache.size;
                                            isButtonDisabled =
                                                cache.isCacheEmpty();
                                          });
                                        }
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      //isDefaultAction: true,
                                      child: Text(
                                        "Close",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              })
                          : showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Clear cache"),
                                  content:
                                      Text("Are you sure to clear the cache?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Clear"),
                                      onPressed: () {
                                        Navigator.of(context).pop();

                                        if (!isButtonDisabled) {
                                          cache.emptyCache();
                                          setState(() {
                                            numberOfObjectsInCache = cache.size;
                                            isButtonDisabled =
                                                cache.isCacheEmpty();
                                          });
                                        }
                                      },
                                    ),
                                    FlatButton(
                                      child: Text(
                                        "Close",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                    }
                  },
                ),
                Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
