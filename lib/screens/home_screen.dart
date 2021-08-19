import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'event_editing_screen.dart';

class CalenderHome extends StatefulWidget {
  @override
  _CalenderHomeState createState() => _CalenderHomeState();
}

class _CalenderHomeState extends State<CalenderHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.deepOrange[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Your Schedule'),
        backgroundColor: Colors.black,
      ),
      body: CalendarWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.deepOrange,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => EventEditingPage()));
        },
      ),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SfCalendar(
        initialSelectedDate: DateTime.now(),
          view: CalendarView.week,
        cellBorderColor: Colors.transparent,
        //backgroundColor: Colors.deepOrange[50],
      ),
    );
  }
}


