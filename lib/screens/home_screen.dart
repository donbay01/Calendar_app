import 'package:flutter/material.dart';
import 'package:personal_calender/model/event_data_source.dart';
import 'package:personal_calender/provider/event_provider.dart';
import 'package:personal_calender/screens/tasks_screen.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/widgets.dart';
import 'event_editing_screen.dart';

class CalenderHome extends StatefulWidget {
  @override
  _CalenderHomeState createState() => _CalenderHomeState();
}

class _CalenderHomeState extends State<CalenderHome> {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return Scaffold(
      body: SafeArea(
        child: SfCalendar(
          dataSource: EventDataSource(events),
          onTap: (details) {
            final provider = Provider.of<EventProvider>(context, listen: false);

            provider.setDate(details.date!);
            showModalBottomSheet(
                context: context,
                builder: (context) => TaskScreen(),
            );
          },
          view: CalendarView.month,
          showDatePickerButton: true,
          scheduleViewSettings: ScheduleViewSettings(
              monthHeaderSettings: MonthHeaderSettings(
                  monthFormat: 'MMMM, yyyy',
                  height: 100,
                  textAlign: TextAlign.left,
                  backgroundColor: Colors.deepOrange,
                  monthTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400))),
          headerHeight: 100,
          allowedViews: [
            CalendarView.day,
            CalendarView.week,
            CalendarView.month,
            CalendarView.schedule,
            CalendarView.timelineMonth
          ],
          initialDisplayDate: DateTime.now(),
          initialSelectedDate: DateTime.now(),
          cellBorderColor: Colors.transparent,
          //backgroundColor: Colors.deepOrange[50],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EventEditingPage()));
        },
      ),
    );
  }
}
