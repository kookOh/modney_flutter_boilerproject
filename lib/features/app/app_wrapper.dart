import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:modney_flutter_boilerplate/features/app/blocs/app_cubit.dart';
import 'package:modney_flutter_boilerplate/features/auth/login/blocs/auth_cubit.dart';
import 'package:modney_flutter_boilerplate/modules/dependency_injection/di.dart';
import 'package:modney_flutter_boilerplate/utils/router.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

@RoutePage()
class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> with WidgetsBindingObserver {
  final GlobalKey _key = GlobalKey();

  @override
  Future<void> didChangePlatformBrightness() async {
    getIt<AppCubit>().updateSystemOverlay(context);
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          // Remove splash screen after initialization.
          FlutterNativeSplash.remove();
          context.router.replaceAll([const AppNavigator()]);
        },
        child: RepaintBoundary(
          key: _key,
          child: const AutoRouter(),
        ),
      ),
    );
  }
}
