import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;

const String _kAsset0 = 'assets/chedo.jpg';
const String _kAsset1 = 'assets/back.png';
const String _kGalleryAssetsPackage = 'assets';

class NoteDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteDrawer();
  }
}

class _NoteDrawer extends State<NoteDrawer> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const List<String> _drawerContents = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
  ];

  static final Animatable<Offset> _drawerDetailsTween = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  ).chain(CurveTween(
    curve: Curves.fastOutSlowIn,
  ));

  AnimationController _controller;
  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;
  bool _showDrawerContents = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _drawerContentsOpacity = CurvedAnimation(
      parent: ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = _controller.drive(_drawerDetailsTween);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showNotImplementedMessage() {
    Navigator.pop(context); // Dismiss the drawer.
    _scaffoldKey.currentState.showSnackBar(const SnackBar(
      content: Text("The drawer's items don't do anything"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.down,
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          alignment: Alignment.centerLeft,
          tooltip: 'Back',
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        title: const Text('Navigation drawer'),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: const Text('Chedo Tech'),
              accountEmail: const Text('trevor.widget@example.com'),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage(
                  _kAsset0,
                  package: _kGalleryAssetsPackage,
                ),
              ),
              otherAccountsPictures: <Widget>[
                GestureDetector(
                  dragStartBehavior: DragStartBehavior.down,
                  onTap: () {
                    _onOtherAccountsTap(context);
                  },
                  child: Semantics(
                    label: 'Switch to Account B',
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(
                        _kAsset1,
                        package: _kGalleryAssetsPackage,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  dragStartBehavior: DragStartBehavior.down,
                  onTap: () {
                    _onOtherAccountsTap(context);
                  },
                ),
              ],
              margin: EdgeInsets.zero,
              onDetailsPressed: () {
                _showDrawerContents = !_showDrawerContents;
                if (_showDrawerContents)
                  _controller.reverse();
                else
                  _controller.forward();
              },
            ),
            MediaQuery.removePadding(
              context: context,
              // DrawerHeader consumes top MediaQuery padding.
              removeTop: true,
              child: Expanded(
                child: ListView(
                  dragStartBehavior: DragStartBehavior.down,
                  padding: const EdgeInsets.only(top: 8.0),
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        // The initial contents of the drawer.
                        FadeTransition(
                          opacity: _drawerContentsOpacity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: _drawerContents.map<Widget>((String id) {
                              return ListTile(
                                leading: CircleAvatar(child: Text(id)),
                                title: Text('Drawer item $id'),
                                onTap: _showNotImplementedMessage,
                              );
                            }).toList(),
                          ),
                        ),
                        // The drawer's "details" view.
                        SlideTransition(
                          position: _drawerDetailsPosition,
                          child: FadeTransition(
                            opacity: ReverseAnimation(_drawerContentsOpacity),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.add),
                                  title: const Text('Add account'),
                                  onTap: _showNotImplementedMessage,
                                ),
                                ListTile(
                                  leading: const Icon(Icons.settings),
                                  title: const Text('Manage accounts'),
                                  onTap: _showNotImplementedMessage,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Semantics(
          button: true,
          label: 'Open drawer',
          excludeSemantics: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 100.0,
                height: 100.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      _kAsset0,
                      package: _kGalleryAssetsPackage,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Page Body',
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              Container(
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  },
                  color: Colors.blueAccent,
                  child: Text(
                    "back",
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onOtherAccountsTap(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Account switching not implemented.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
