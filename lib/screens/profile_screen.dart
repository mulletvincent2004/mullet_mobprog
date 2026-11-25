import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mullet_mobprog/constants.dart';
import 'package:mullet_mobprog/widgets/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
      child: Column(
        children: [
          CircleAvatar(
            radius: ScreenUtil().setSp(40),
            backgroundColor: fbLightPrimary,
            child: Icon(
              Icons.person,
              size: ScreenUtil().setSp(40),
              color: Colors.white,
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(15)),
          CustomText(
            text: profileName,
            fontSize: ScreenUtil().setSp(22),
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
          SizedBox(height: ScreenUtil().setHeight(5)),
          CustomText(
            text: 'Member of $appName',
            fontSize: ScreenUtil().setSp(13),
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
        ],
      ),
    );
  }
}
