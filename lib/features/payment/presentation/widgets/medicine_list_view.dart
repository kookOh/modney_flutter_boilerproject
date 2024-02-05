import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';
import 'package:modney_flutter_boilerplate/utils/r.dart';

class MedicineListView extends StatefulWidget {
  const MedicineListView({Key? key}) : super(key: key);

  @override
  _MedicineListViewState createState() => _MedicineListViewState();
}

class _MedicineListViewState extends State<MedicineListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.w,
      height: 320.h,
      margin: EdgeInsets.symmetric(vertical: $constants.insets.md),
      padding: EdgeInsets.fromLTRB(
        $constants.insets.xs,
        $constants.insets.md,
        $constants.insets.xs,
        $constants.insets.xs,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 10,
          runSpacing: 20,
          // runAlignment: WrapAlignment.end,
          alignment: WrapAlignment.spaceEvenly,
          clipBehavior: Clip.antiAlias,

          children:
              ['타이레놀', '배아제', '후시딘', '판피린', '마데카솔', '브루펜', '빨간약'].map((e) {
            return Container(
              width: 140.r,
              height: 140.r,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Padding(
                padding: EdgeInsets.all($constants.insets.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$e',
                      style: getTextTheme(context).bodyMedium!.copyWith(
                            color: getCustomOnPrimaryColor(context),
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Image.asset(
                      R.images.image_machine,
                      width: 100,
                      height: 80,
                    ),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '1개',
                            style: getTextTheme(context).labelSmall!.copyWith(
                                  // color: getCustomOnPrimaryColor(context),
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          Text(
                            '5,000',
                            style: getTextTheme(context).labelSmall!.copyWith(
                                  // color: getCustomOnPrimaryColor(context),
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
