import 'package:flutter_bloc/flutter_bloc.dart';

import 'color_print/color_print.dart';

class AppStateObserver extends BlocObserver {
  const AppStateObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    printY('${bloc.runtimeType} $change');
  }
}
