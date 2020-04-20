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
  DateRangePickerController _controller;
  int _startDate;
  String headerString;
  DateTime midDate;
  double width, cellWidth, height, cellHeight;

  @override
  void initState() {
    // TODO: implement initState
    _controller = DateRangePickerController();
    _startDate = 0;
    width = 0.0;
    cellWidth = 0.0;
    height = 0.0;
    cellHeight = 0.0;
    midDate = DateTime.now();
    headerString = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    cellWidth = width / 9;
    height = MediaQuery.of(context).size.height;
    cellHeight = height / 17;

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
                      _controller.backward();
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
                      _controller.forward();
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
    _startDate = (args.visibleDateRange.startDate
        .difference(args.visibleDateRange.endDate)
        .inDays);
    var middleDate = (_startDate ~/ 2).toInt();
    midDate = args.visibleDateRange.startDate.add(Duration(days: middleDate));
    headerString = DateFormat('MMMM yyyy').format(midDate).toString();
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      setState(() {});
    });
  }
}
