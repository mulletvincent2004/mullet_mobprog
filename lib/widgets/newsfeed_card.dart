import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mullet_mobprog/constants.dart';
import 'package:mullet_mobprog/widgets/custom_text.dart';

class NewsfeedCard extends StatelessWidget {
  final String userName;
  final String postContent;
  final String date;
  final int? numOfLikes;
  final String? imagePath;
  final String? avatarPath;

  const NewsfeedCard({
    super.key,
    required this.userName,
    required this.postContent,
    required this.date,
    this.numOfLikes,
    this.imagePath,
    this.avatarPath,
  });

  // Enhancement 2: reusable avatar widget
  Widget _buildAvatar({String? path, required double radius}) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: fbLightPrimary,
      backgroundImage: path != null ? AssetImage(path) : null,
      child: path == null
          ? Icon(Icons.person, color: Colors.white, size: radius)
          : null,
    );
  }

  // Enhancement 3: reusable widget-based action button
  Widget _buildActionButton({
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: iconColor, size: ScreenUtil().setSp(18)),
        label: CustomText(
          text: label,
          fontSize: ScreenUtil().setSp(12),
          color: fbDarkPrimary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenUtilSp = ScreenUtil().setSp(10);
    final screenUtilWidth = ScreenUtil().setWidth(10);
    final screenUtilFontUserNameSize = ScreenUtil().setSp(15);
    final screenUtilIconSize = ScreenUtil().setSp(15);
    final avatarRadius = ScreenUtil().setSp(14);

    return Card(
      margin: EdgeInsets.all(screenUtilSp),
      child: Padding(
        padding: EdgeInsets.all(screenUtilSp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Enhancement 2: poster avatar
                _buildAvatar(path: avatarPath, radius: avatarRadius),
                SizedBox(width: screenUtilWidth),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: userName,
                      fontSize: screenUtilFontUserNameSize,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          text: date,
                          fontSize: ScreenUtil().setSp(12),
                          color: Colors.grey,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(3)),
                        Icon(
                          Icons.public,
                          color: Colors.grey,
                          size: screenUtilIconSize,
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.more_horiz),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(5)),
            // post content
            CustomText(
              text: postContent,
              fontSize: ScreenUtil().setSp(12),
              color: Colors.black,
            ),
            SizedBox(height: ScreenUtil().setHeight(5)),

            // Enhancement 1: dynamic image widget
            if (imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(6)),
                child: Image.asset(
                  imagePath!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: ScreenUtil().setHeight(150),
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    );
                  },
                ),
              ),

            // Enhancement 3: widget-based Like, Comment, Share buttons
            Row(
              children: [
                _buildActionButton(
                  icon: Icons.thumb_up,
                  iconColor: fbPrimary,
                  label: numOfLikes?.toString() ?? '0',
                  onPressed: () {
                    // print('Like button pressed');
                  },
                ),
                _buildActionButton(
                  icon: Icons.chat_bubble_outline,
                  iconColor: fbDarkPrimary,
                  label: 'Comment',
                  onPressed: () {
                    // print('Comment button pressed');
                  },
                ),
                _buildActionButton(
                  icon: Icons.redo,
                  iconColor: fbDarkPrimary,
                  label: 'Share',
                  onPressed: () {
                    // print('Share button pressed');
                  },
                ),
              ],
            ),
            Row(
              children: [
                // Enhancement 2: commenter avatar
                _buildAvatar(path: null, radius: avatarRadius),
                SizedBox(width: ScreenUtil().setWidth(10)),
                Container(
                  padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(10),
                    0,
                    0,
                    0,
                  ),
                  alignment: Alignment.centerLeft,
                  height: ScreenUtil().setHeight(25),
                  width: ScreenUtil().setWidth(300),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setSp(10)),
                    ),
                  ),
                  child: CustomText(
                    text: 'Write a comment...',
                    fontSize: ScreenUtil().setSp(11),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            CustomText(
              text: 'View all comments',
              fontSize: ScreenUtil().setSp(12),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
