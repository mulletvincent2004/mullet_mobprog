import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mullet_mobprog/widgets/notification.dart';

const List<String> _names = [
  'Steve Rogers',
  'Tony Stark',
  'Natasha Romanoff',
  'Bruce Banner',
  'Thor Odinson',
  'Clint Barton',
  'Wanda Maximoff',
  'Peter Parker',
  'Stephen Strange',
  'Carol Danvers',
];

const List<String> _actions = [
  'liked your post',
  'commented on your post',
  'shared your post',
  'mentioned you in a comment',
  'reacted to your photo',
];

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final int _totalNotifications = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().screenWidth,
      child: ListView.separated(
        itemCount: _totalNotifications,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return NotificationWidget(
            name: _names[index % _names.length],
            post: 'Post #${index + 1}',
            description: _actions[index % _actions.length],
          );
        },
      ),
    );
  }
}
