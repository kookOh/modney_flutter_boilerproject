import 'package:modney_flutter_boilerplate/features/app/models/env_model.dart';
import 'package:modney_flutter_boilerplate/modules/dependency_injection/di.dart';
import 'package:modney_flutter_boilerplate/utils/helpers/logging_helper.dart';
import 'package:modney_flutter_boilerplate/utils/router.dart';

final LoggingHelper logIt = getIt<LoggingHelper>();
final EnvModel env = getIt<EnvModel>();
final AppRouter appRouter = getIt<AppRouter>();
