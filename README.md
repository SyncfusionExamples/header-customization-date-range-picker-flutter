## How to customize the header view of the Flutter date range picker?

In the flutter date range picker, you can add your custom header, and it can be achieved by hiding the default header and placing your custom header in the date range picker.

## Step 1:
Set the `headerHeight` property value to 0 to hide the default header. Please find the following image for date picker without header.

```xml
body: Column(
  children: <Widget>[
    Card(
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 50),
      child: SfDateRangePicker(
          controller: _controller,
          view: DateRangePickerView.month,
          headerHeight: 0, 
    )
  ],
);
```
<img alt="header height"  src="http://www.syncfusion.com/uploads/user/kb/flut/flut-864/flut-864_img1.png" width="250" height="250" />|

## Step 2:
For design own custom header using the Row widget inside the Column widget for the header customization.

```xml
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
``` 
## Step 3:
Then, add the custom header in the date range picker.

```xml
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
```

## Step 4:
Using the `onViewChanged` callback of the date picker, you can get the mid date of the visible date range and assign it to the header string.

```xml
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
```
**[View document in Syncfusion Flutter Knowledge base](https://www.syncfusion.com/kb/11427/how-to-customize-the-header-view-of-the-flutter-date-range-picker)**

**Screenshot**

<img alt="Custom header"  src="http://www.syncfusion.com/uploads/user/kb/flut/flut-864/flut-864_img2.png" width="250" height="250" />|
