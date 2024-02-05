import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/default_appbar.dart';
import 'package:modney_flutter_boilerplate/features/mypage/presentation/widgets/consult_item.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';

@RoutePage()
class MyConsultListScreen extends StatefulWidget {
  MyConsultListScreen({super.key});

  @override
  _MyConsultListState createState() => _MyConsultListState();
}

class _MyConsultListState extends State<MyConsultListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppbar(context: context, title: '상담 내역 확인'),
        body: Container(
          child: Column(
            children: [
              // TODO : 상담내역 데이터 연동
              // @ example : ConsultItem(item : consultList[i])
              //
              ConsultItem(),
              ConsultItem(),
              ConsultItem(),
            ],
          ),
        ));
  }
}
