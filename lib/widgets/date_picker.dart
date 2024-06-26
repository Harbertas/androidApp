import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../services/notifi_service.dart';

DateTime scheduleTime = DateTime.now();

class DatePickerIcon extends StatelessWidget {
  DateTime scheduleTime = DateTime.now();
  final String? notificationText;
  final String? id;
  DatePickerIcon({
    super.key,
    required this.notificationText,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.schedule),
      iconSize: 18,
      color: Colors.white,
      onPressed: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          onChanged: (date) => scheduleTime = date,
          onConfirm: (date) {
            NotificationService().scheduleNotification(
                id: int.parse(id.toString()),
                title: 'Scheduled Notification',
                body: '$notificationText',
                scheduledNotificationDateTime: scheduleTime);
          },
        );
      },
    );
  }
}
