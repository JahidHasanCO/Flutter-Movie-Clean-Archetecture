import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';

BlocProvider<T> buildRemoteBlocProvider<T extends Bloc<dynamic, dynamic>>(
    {required T bloc, required dynamic event}) {
  return BlocProvider<T>(
    create: (context) {
      return locator()
        ..add(
          event,
        );
    },
  );
}
