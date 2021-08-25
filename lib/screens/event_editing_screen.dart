import 'package:flutter/material.dart';
import 'package:personal_calender/model/event.dart';
import 'package:personal_calender/provider/event_provider.dart';
import 'package:personal_calender/utils.dart';
import 'package:provider/provider.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({Key? key, this.event}) : super(key: key);

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime fromDate;
  late DateTime toDate;

  TextEditingController eventName = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 24));
    }
  }

  @override
  void dispose() {
    eventName.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        actions: buildEditingActions(),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                buildEventNameTextField(),
                SizedBox(
                  height: 50,
                ),
                buildHeader(
                  header: 'From',
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: buildDropdownField(
                            text: Utils.toDate(fromDate),
                            onClicked: () {
                              pickFromDateTime(pickDate: true);
                            }),
                      ),
                      Expanded(
                        child: buildDropdownField(
                            text: Utils.toTime(fromDate),
                            onClicked: () {
                              pickFromDateTime(pickDate: false);
                            }),
                      ),
                    ],
                  ),
                ),
                buildHeader(
                  header: 'To',
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: buildDropdownField(
                          text: Utils.toDate(toDate),
                          onClicked: () {
                            pickToDateTime(pickDate: true);
                          },
                        ),
                      ),
                      Expanded(
                        child: buildDropdownField(
                          text: Utils.toTime(toDate),
                          onClicked: () {
                            pickToDateTime(pickDate: false);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildEventNameTextField() {
    return TextFormField(
      controller: eventName,
      validator: (title) =>
          title != null && title.isEmpty ? 'Title can not be empty' : null,
      onFieldSubmitted: (_) => saveForm(),
      decoration: InputDecoration(
        labelText: 'Title',
        labelStyle: TextStyle(color: Colors.deepOrange),
        hintText: 'Name this event',
        hintStyle: TextStyle(fontSize: 20),
        focusedBorder: OutlineInputBorder(
          //borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.deepOrange, width: 1.0),
        ),
      ),
    );
  }

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      fromDate,
      pickDate: pickDate,
    );
    if (date == null) return;
    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() {
      fromDate = date;
    });
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(toDate,
        pickDate: pickDate, firstDate: pickDate ? fromDate : null);
    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() {
      toDate = date;
    });
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2100),
      );

      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (timeOfDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  List<Widget> buildEditingActions() => [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent, shadowColor: Colors.transparent),
          icon: Icon(Icons.done),
          onPressed: () {
            saveForm();
          },
          label: Text('SAVE'),
        )
      ];

  buildDropdownField(
          {required String text, required Null Function() onClicked}) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  buildHeader({required String header, required Widget child}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          child,
        ],
      );

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final event = Event(
        title: eventName.text,
        description: 'Description',
        from: fromDate,
        to: toDate,
        isAllDay: false,
      );

      final provider = Provider.of<EventProvider>(context, listen: false);
      provider.addEvent(event);
      Navigator.of(context).pop();
    }
  }
}
