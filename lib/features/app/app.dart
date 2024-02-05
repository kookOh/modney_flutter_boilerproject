import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modney_flutter_boilerplate/features/app/blocs/app_cubit.dart';
import 'package:modney_flutter_boilerplate/i18n/strings.g.dart';
import 'package:modney_flutter_boilerplate/modules/dependency_injection/di.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/methods/aliases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:statsfl/statsfl.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return StatsFl(
      maxFps: 120,
      align: Alignment.bottomRight,
      isEnabled: env.debug,
      child: BlocProvider(
        create: (context) => getIt<AppCubit>(),
        child: BlocBuilder<AppCubit, AppState>(
          buildWhen: (p, c) => p.theme != c.theme,
          builder: (context, state) {
            return ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              splitScreenMode: true,
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                child: MaterialApp.router(
                  /// Theme configuration.
                  theme: state.theme.light,
                  darkTheme: state.theme.dark,
                  themeMode: state.theme.mode,

                  /// Environment configuration.
                  title: $constants.appTitle,
                  debugShowCheckedModeBanner: env.debugShowCheckedModeBanner,
                  debugShowMaterialGrid: env.debugShowMaterialGrid,

                  /// AutoRouter configuration.
                  routerDelegate: AutoRouterDelegate(
                    appRouter,
                    // Sentrie's tracking navigation events with the usage of autorouter.
                    navigatorObservers: () => [
                      SentryNavigatorObserver(),
                    ],
                  ),
                  routeInformationParser: appRouter.defaultRouteParser(),

                  /// EasyLocalization configuration.
                  locale: TranslationProvider.of(context).flutterLocale,
                  supportedLocales: AppLocaleUtils.supportedLocales,
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
