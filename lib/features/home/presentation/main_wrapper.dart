import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modney_flutter_boilerplate/features/auth/login/blocs/auth_cubit.dart';
import 'package:modney_flutter_boilerplate/modules/dependency_injection/di.dart';

@RoutePage()
class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  _MainWrapperState createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      bloc: getIt<AuthCubit>(),
      listener: (context, state) {
        // context.router.replaceAll([]);
      },
      child: RepaintBoundary(
        key: _key,
        child: const AutoRouter(),
      ),
    );
  }
}
