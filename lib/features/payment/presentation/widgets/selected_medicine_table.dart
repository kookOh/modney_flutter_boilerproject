import 'package:flutter/material.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';

class SelectedMedicineTable extends StatefulWidget {
  const SelectedMedicineTable({Key? key}) : super(key: key);

  @override
  _SelectedMedicineTableState createState() => _SelectedMedicineTableState();
}

class _SelectedMedicineTableState extends State<SelectedMedicineTable> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    TextStyle textTheme = getTextTheme(context).bodySmall!;
    return Container(
      padding: EdgeInsets.all($constants.insets.md),
      child: DataTable(
        headingRowColor: MaterialStatePropertyAll(const Color(0xFFF4F4F4)),
        columns: [
          DataColumn(
            label: Expanded(
              child: Text(
                '선택',
                style: textTheme,
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                '약품명',
                style: textTheme,
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                '가격',
                style: textTheme,
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                '수량',
                style: textTheme,
              ),
            ),
          ),
        ],
        rows: [
          buildDataRow(context),
          buildDataRow(context),
          buildDataRow(context),
          buildDataRow(context),
          buildDataRow(context),
          buildDataRow(context),
        ],
      ),
    );
  }

  DataRow buildDataRow(BuildContext context) {
    TextStyle textTheme = getTextTheme(context).bodySmall!;
    return DataRow(
      cells: [
        DataCell(
          Text(
            '${index++}',
            style: textTheme,
          ),
        ),
        DataCell(
          Text(
            '약품명',
            style: textTheme,
          ),
        ),
        DataCell(
          Text(
            '5,000',
            style: textTheme,
          ),
        ),
        DataCell(
          Text(
            '2',
            style: textTheme,
          ),
        ),
      ],
    );
  }
}
