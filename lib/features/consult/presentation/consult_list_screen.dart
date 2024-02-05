import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/default_appbar.dart';
import 'package:modney_flutter_boilerplate/features/consult/presentation/widgets/live_consult_item.dart';

@RoutePage()
class ConsultListScreen extends StatefulWidget {
  const ConsultListScreen({Key? key}) : super(key: key);

  @override
  _ConsultListScreenState createState() => _ConsultListScreenState();
}

class _ConsultListScreenState extends State<ConsultListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(context: context, title: '상담 내역 확인'),
      body: Container(
        child: Column(
          children: [
            // TODO : 상담채팅방 데이터 연동
            // @ example : ConsultItem(item : consultList[i])
            //
            LiveConsultItem(),
            LiveConsultItem(),
            LiveConsultItem(),
          ],
        ),
      ),
    );
  }
}
