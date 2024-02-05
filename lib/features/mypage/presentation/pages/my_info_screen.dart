import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/custom_alert_modal.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/default_appbar.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/primary_button.dart';
import 'package:modney_flutter_boilerplate/features/auth/login/blocs/auth_cubit.dart';
import 'package:modney_flutter_boilerplate/modules/dependency_injection/di.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';
import 'package:modney_flutter_boilerplate/utils/router.gr.dart';

@RoutePage()
class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({Key? key}) : super(key: key);

  @override
  _MyInfoScreenState createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  @override
  Widget build(BuildContext context) {
    TextStyle _style = getTextTheme(context)
        .bodyMedium!
        .copyWith(fontWeight: FontWeight.w600, fontFamily: 'Pretendard');
    return Scaffold(
      appBar: DefaultAppbar(context: context, title: '내 정보'),
      body: Padding(
        padding: EdgeInsets.all(
          $constants.insets.lg,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(
                $constants.insets.md,
              ),
              height: 160.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Text(
                          '이름',
                          style: _style,
                        ),
                      ),
                      Text(
                        '홍길동',
                        style: _style,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Text(
                          '생년월일',
                          style: _style,
                        ),
                      ),
                      Text(
                        '2011. 01. 01',
                        style: _style,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Text(
                          '전화번호',
                          style: _style,
                        ),
                      ),
                      Text(
                        '010-1234-1234',
                        style: _style,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Text(
                          '아이디',
                          style: _style,
                        ),
                      ),
                      Text(
                        'pharmacy1234',
                        style: _style,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  bottom: 20.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // TODO : 회원탈퇴 API연동
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: PrimaryButton(
                        width: 140.w,
                        height: 40.h,
                        radius: 10.r,
                        primary: false,
                        text: '회원탈퇴',
                        onPressed: () {
                          CustomAlertModal.showAlert(
                            context,
                            text: '정말로 탈퇴 하시겠습니까?\n탈퇴 후 다시 재가입 할 수 없습니다.',
                            onCancelPressed: () {},
                            onPressed: () {
                              getIt<AuthCubit>().logOut();
                              // TODO :  회원탈퇴 로직 구현
                            },
                          );
                        },
                      ),
                    ),
                    // TODO : 로그아웃 연동
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: PrimaryButton(
                        width: 140.w,
                        height: 40.h,
                        radius: 10.r,
                        text: '로그아웃',
                        onPressed: () {
                          CustomAlertModal.showAlert(
                            context,
                            text: '정말로 로그아웃 하시겠습니까?',
                            onCancelPressed: () {},
                            onPressed: () {
                              // TODO : logOut()은 AppWrapper class에서 listner  연동시점에서 처리.
                              // TODO : listner 통한 state 값에 따라 지도화면/상담받기화면(약국) / 로그인화면 연동
                              // getIt<AuthCubit>().logOut();
                              // AutoRouter.of(context).popUntilRoot();
                              AutoRouter.of(context)
                                  .replaceAll([const AppNavigator()]);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
