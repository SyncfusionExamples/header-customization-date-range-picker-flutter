import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

void main() => runApp(CustomHeader());

class CustomHeader extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HeaderCustomization(),
    );
  }
}

class HeaderCustomization extends StatefulWidget {
  @override
  _HeaderCustomizationState createState() => _HeaderCustomizationState();
}

class _HeaderCustomizationState extends State<HeaderCustomization> {
  final DateRangePickerController _controller = DateRangePickerController();
  String headerString = '';

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double cellWidth = width / 9;

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: cellWidth,
              width: cellWidth + 10,
            ),
            Container(
                width: cellWidth,
                height: cellWidth,
                color: Color(0xFFfa697c),
                child: IconButton(
                  icon: Icon(Icons.arrow_left),
                  color: Colors.white,
                  iconSize: 20,
                  highlightColor: Colors.lightGreen,
                  onPressed: () {
                    setState(() {
                      _controller.backward!();
                    });
                  },
                )),
            Container(
              color: Color(0xFFfa697c),
              height: cellWidth,
              width: cellWidth * 4.5,
              child: Text(headerString,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25, color: Colors.white, height: 1.4)),
            ),
            Container(
                width: cellWidth,
                height: cellWidth,
                color: Color(0xFFfa697c),
                child: IconButton(
                  icon: Icon(Icons.arrow_right),
                  color: Colors.white,
                  highlightColor: Colors.lightGreen,
                  onPressed: () {
                    setState(() {
                      _controller.forward!();
                    });
                  },
                )),
            Container(
              height: cellWidth,
              width: cellWidth,
            )
          ],
        ),
        Card(
          margin: const EdgeInsets.fromLTRB(50, 0, 50, 50),
          child: SfDateRangePicker(
              controller: _controller,
              view: DateRangePickerView.month,
              headerHeight: 0,
              onViewChanged: viewChanged,
              monthViewSettings: DateRangePickerMonthViewSettings(
                  showTrailingAndLeadingDates: true,
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                      backgroundColor: Color(0xFFfcc169))),
              monthCellStyle: DateRangePickerMonthCellStyle(
                  cellDecoration: BoxDecoration(color: Color(0xFF6fb98f)),
                  leadingDatesDecoration:
                      BoxDecoration(color: Color(0xFF6fb98f)),
                  trailingDatesDecoration:
                      BoxDecoration(color: Color(0xFF6fb98f)))),
        )
      ],
    ));
  }

  void viewChanged(DateRangePickerViewChangedArgs args) {
    final DateTime visibleStartDate = args.visibleDateRange.startDate!;
    final DateTime visibleEndDate = args.visibleDateRange.endDate!;
    final int totalVisibleDays =
        (visibleStartDate.difference(visibleEndDate).inDays);
    final DateTime midDate =
        visibleStartDate.add(Duration(days: totalVisibleDays ~/ 2));
    headerString = DateFormat('MMMM yyyy').format(midDate).toString();
    SchedulerBinding.instance!.addPostFrameCallback((duration) {
      setState(() {});
    });
  }
}
