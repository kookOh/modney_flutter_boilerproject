import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/custom_alert_modal.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/default_appbar.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/primary_button.dart';
import 'package:modney_flutter_boilerplate/features/payment/presentation/widgets/medicine_list_view.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';
import 'package:modney_flutter_boilerplate/utils/r.dart';

@RoutePage()
class CustomerPaymentScreen extends StatefulWidget {
  const CustomerPaymentScreen({Key? key}) : super(key: key);

  @override
  _CustomerPaymentScreenState createState() => _CustomerPaymentScreenState();
}

class _CustomerPaymentScreenState extends State<CustomerPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(context: context, title: '가나다 약국 투약기'),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: MedicineListView(),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 250.h,
                width: double.maxFinite,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 30.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '결제 금액',
                      style: getTextTheme(context).bodyLarge!,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 40.h,
                      margin: EdgeInsets.symmetric(
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '12,500원',
                        textAlign: TextAlign.center,
                        style: getTextTheme(context).headlineSmall!.copyWith(
                              color: getCustomOnPrimaryColor(context),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pretendard',
                              fontSize: 20.r,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      '결제 방식을 선택해주세요.',
                      style: getTextTheme(context).bodyLarge!,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PrimaryButton(
                          text: '선불',
                          width: 150.w,
                          height: 40.h,
                          radius: 10.r,
                          onPressed: () {
                            // TODO : 카드결제 모듈 호출  => BlocListner
                            // ! 프론트엔드 임시코드 연동필요.

                            // TODO : 결제모듈 호출 완료 후 QR 코드 생성 => BlocListner 처리할때 상위 로직으로 변경.
                            // ! 프론트엔드 임시코드 연동필요
                            CustomAlertModal.showAlert(
                              context,
                              width: 80,
                              height: 140,
                              fontSize: 16,
                              text:
                                  'QR코드가 생성되었습니다. 마이페이지에서 생성된 QR코드를 확인한 후에 선택된 약국의 QR리더기에 QR을 인식하게 해 주세요.',
                              onPressed: () {
                                context.popRoute();
                              },
                            );
                          },
                        ),
                        PrimaryButton(
                          text: '후불',
                          width: 150.w,
                          height: 40.h,
                          primary: false,
                          radius: 10.r,
                          onPressed: () {
                            // TODO : 후불 ->  QR 코드 생성 및 화상채팅 페이지로 이동
                            // ! 임시코드
                            CustomAlertModal.showAlert(
                              context,
                              width: 80,
                              height: 140,
                              fontSize: 16,
                              text:
                                  'QR코드가 생성되었습니다. 마이페이지에서 생성된 QR코드를 확인한 후에 선택된 약국의 QR리더기에 QR을 인식하게 해 주세요.',
                              onPressed: () => context.popRoute(),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
