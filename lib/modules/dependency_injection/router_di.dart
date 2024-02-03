import 'package:modney_flutter_boilerplate/utils/router.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RouterInjection {
  AppRouter router() => AppRouter();
}
