import 'dart:io';

import 'package:desk_img/color_print/color_print.dart';
import 'package:desk_img/path_bloc/path_bloc.dart';
import 'package:desk_img/state_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_links/uni_links.dart';
import 'package:uni_links_desktop/uni_links_desktop.dart';
import 'package:window_manager/window_manager.dart';

import 'home/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // App State observer
  Bloc.observer = const AppStateObserver();

  // Unilink setup
  if (Platform.isWindows) {
    registerProtocol('unilinks');
  }

  // Window manager setup
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    title: 'Photo Gallery',
    size: Size(925, 610),
    minimumSize: Size(925, 610),
    center: true,
    // backgroundColor: Colors.black,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () {
    windowManager.setBrightness(Brightness.dark);
    windowManager.show();
    windowManager.focus();
  });

  // runApp
  runApp(BlocProvider(
    create: (context) => PathBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialUriIsHandled = false;

  // ignore: unused_field
  Uri? _initialUri;

  // ignore: unused_field
  Object? _err;

  // ignore: unused_field
  final _scaffoldKey = GlobalKey();

  Future<void> _handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      printY('_handleInitialUri called');
      try {
        final uri = await getInitialUri();
        if (!mounted) return;
        printC(uri.toString());
        // || uri.path.isEmpty
        if (uri == null) {
          BlocProvider.of<PathBloc>(context).add(NoInitailUriEvent());
        } else {
          final nonUri = Uri.parse("file:E:/sunset.jpg");
          BlocProvider.of<PathBloc>(context).add(HasInitialRouteEvent(
              initialUri: Uri.parse("file:${nonUri.path}")));
          // BlocProvider.of<PathBloc>(context).add(HasInitialRouteEvent(
          //     initialUri: Uri.parse("file:e:/23068779.webp")));
          // printR('got initial uri: $uri');
        }
        if (!mounted) return;
        setState(() => _initialUri = uri);
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
        printR('falied to get initial uri');
      } on FormatException catch (err) {
        if (!mounted) return;
        printR('malformed initial uri');
        setState(() => _err = err);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _handleInitialUri();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        // colorScheme: ColorScheme.fromSwatch()
        //     .copyWith(primary: SystemTheme.accentColor.accent),
      ),
      home: const HomeView(),
    );
  }
}
