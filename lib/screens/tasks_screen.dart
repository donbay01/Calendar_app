import 'package:flutter/material.dart';
import 'package:personal_calender/model/event_data_source.dart';
import 'package:personal_calender/provider/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;

    if (selectedEvents.isEmpty) {
      return Center(
        child: Text('No Events found!',style: TextStyle(color: Colors.white,fontSize: 24),),
      );
    }

    return SfCalendar(
      view: CalendarView.timelineDay,
      dataSource: EventDataSource(provider.events),
      initialDisplayDate: provider.selectedDate,
      headerHeight: 50,
      onTap: (details) {

      },
    );

  }
}
