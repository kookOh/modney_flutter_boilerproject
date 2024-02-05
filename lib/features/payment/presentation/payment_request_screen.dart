import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/custom_alert_modal.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/default_appbar.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/primary_button.dart';
import 'package:modney_flutter_boilerplate/features/payment/presentation/widgets/medicine_list_view.dart';
import 'package:modney_flutter_boilerplate/features/payment/presentation/widgets/selected_medicine_table.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';
import 'package:modney_flutter_boilerplate/utils/r.dart';

@RoutePage()
class PaymentRequestScreen extends StatefulWidget {
  const PaymentRequestScreen({Key? key}) : super(key: key);

  @override
  _PaymentRequestScreenState createState() => _PaymentRequestScreenState();
}

class _PaymentRequestScreenState extends State<PaymentRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(context: context, title: '가나다 약국 투약기'),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.zero,
            child: Accordion(
              headerBackgroundColor: Colors.white,
              disableScrolling: true,
              rightIcon: Icon(
                Icons.keyboard_arrow_down,
                color: getCustomOnPrimaryColor(context),
                size: 35,
              ),
              contentHorizontalPadding: 0,
              headerBorderWidth: 1,
              scrollIntoViewOfItems: ScrollIntoViewOfItems.fast,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              contentBorderWidth: 0,
              contentBackgroundColor: const Color(0xFFF4F4F4),
              headerPadding: EdgeInsets.symmetric(
                  horizontal: $constants.insets.md,
                  vertical: $constants.insets.xs),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              paddingListHorizontal: 0,
              children: [
                AccordionSection(
                  header: Text('감기약'),
                  content: MedicineListView(),
                  // isOpen: true,
                  leftIcon: Image.asset(
                    R.images.icon_drug,
                    width: 20.r,
                  ),
                ),
                AccordionSection(
                  header: Text('감기약'),
                  content: MedicineListView(),
                  leftIcon: Image.asset(
                    R.images.icon_drug,
                    width: 20.r,
                  ),
                ),
                AccordionSection(
                  header: Text('감기약'),
                  content: MedicineListView(),
                  leftIcon: Image.asset(
                    R.images.icon_drug,
                    width: 20.r,
                  ),
                ),
                AccordionSection(
                  header: Text('감기약'),
                  content: MedicineListView(),
                  leftIcon: Image.asset(
                    R.images.icon_drug,
                    width: 20.r,
                  ),
                ),
              ],
            ),
          ),
          SelectedMedicineTable(),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 300.h,
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
                    // TODO
                    // ??? 결제금액 변경 관련 내용 질문필요
                    '결제 금액 변경',
                    style: getTextTheme(context).titleLarge!,
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
                            // color: getCustomOnPrimaryColor(context),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pretendard',
                            fontSize: 20.r,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '총 수량',
                            style: getTextTheme(context).bodyLarge!,
                          ),
                          Container(
                            width: 150.w,
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
                              '3개',
                              textAlign: TextAlign.center,
                              style:
                                  getTextTheme(context).headlineSmall!.copyWith(
                                        color: getCustomOnPrimaryColor(context),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Pretendard',
                                        fontSize: 20.r,
                                      ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '총 결제금액',
                            style: getTextTheme(context).bodyLarge!,
                          ),
                          Container(
                            width: 150.w,
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
                              style:
                                  getTextTheme(context).headlineSmall!.copyWith(
                                        color: getCustomOnPrimaryColor(context),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Pretendard',
                                        fontSize: 20.r,
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PrimaryButton(
                        text: '결제 요청',
                        radius: 10.r,
                        width: 330,
                        onPressed: () {
                          // TODO : 결제요청 -> Stream 데이터 전송
                          // ! 프론트엔드 임시코드 연동필요.

                          // TODO : 결제모듈 호출 완료 후 QR 코드 생성 => BlocListner 처리할때 상위 로직으로 변경.
                          // ! 프론트엔드 임시코드 연동필요
                          CustomAlertModal.showAlert(
                            context,
                            width: 80,
                            height: 140,
                            fontSize: 16,
                            text: '결제요청이 완료되었습니다.',
                            onPressed: () {
                              context.popRoute();
                            },
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
