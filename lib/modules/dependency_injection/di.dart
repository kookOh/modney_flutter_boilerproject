import 'package:modney_flutter_boilerplate/features/app/models/auth_model.dart';
import 'package:modney_flutter_boilerplate/modules/dependency_injection/di.config.dart';
import 'package:fresh_graphql/fresh_graphql.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  ignoreUnregisteredTypes: [TokenStorage<AuthModel>],
  asExtension: false,
)
Future<GetIt> configureDependencyInjection() async => init(getIt);
