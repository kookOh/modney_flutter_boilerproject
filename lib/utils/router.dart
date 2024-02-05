import 'package:auto_route/auto_route.dart';
import 'package:modney_flutter_boilerplate/utils/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          initial: true,
          page: AppWrapper.page,
          path: '/',
          children: [
            AutoRoute(page: LoginRoute.page, path: 'login'),
            AutoRoute(page: AppNavigator.page, path: 'home'),
            AutoRoute(page: SignupRoute.page, path: 'signup'),
            AutoRoute(page: MainMapRoute.page, path: 'main'),
            AutoRoute(page: ReserveRoute.page, path: 'reserve'),
            AutoRoute(page: FacechatRoute.page, path: 'chat'),
            AutoRoute(page: CustomerPaymentRoute.page, path: 'payment'),
            AutoRoute(page: PaymentRequestRoute.page, path: 'request_payment'),
            AutoRoute(page: MypageRoute.page, path: 'mypage'),
            AutoRoute(page: MyInfoRoute.page, path: 'myinfo'),
            AutoRoute(page: MyConsultListRoute.page, path: 'myconsult'),
            AutoRoute(page: QrRoute.page, path: 'qr'),
            AutoRoute(page: ConsultListRoute.page, path: 'consultlist'),
          ],
        ),
      ];
}
