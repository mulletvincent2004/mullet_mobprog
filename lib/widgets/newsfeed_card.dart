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
  final bool hasPlaceholder;
  final String? avatarPath;

  const NewsfeedCard({
    super.key,
    required this.userName,
    required this.postContent,
    required this.date,
    this.numOfLikes,
    this.imagePath,
    this.hasPlaceholder = false,
    this.avatarPath,
  });

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

  // Enhancement 1: shows a real image, a placeholder box, or nothing
  Widget _buildMedia() {
    if (imagePath != null) {
      return ClipRRect(
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
      );
    }
    if (hasPlaceholder) {
      return SizedBox(
        width: double.infinity,
        height: ScreenUtil().setHeight(200),
        child: CustomPaint(painter: _PlaceholderPainter()),
      );
    }
    return const SizedBox.shrink();
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
            CustomText(
              text: postContent,
              fontSize: ScreenUtil().setSp(12),
              color: Colors.black,
            ),
            SizedBox(height: ScreenUtil().setHeight(5)),
            _buildMedia(),
            Row(
              children: [
                _buildActionButton(
                  icon: Icons.thumb_up,
                  iconColor: fbPrimary,
                  label: numOfLikes?.toString() ?? '0',
                  onPressed: () {},
                ),
                _buildActionButton(
                  icon: Icons.chat_bubble_outline,
                  iconColor: fbDarkPrimary,
                  label: 'Comment',
                  onPressed: () {},
                ),
                _buildActionButton(
                  icon: Icons.redo,
                  iconColor: fbDarkPrimary,
                  label: 'Share',
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              children: [
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

// Draws a box with an X, like a typical image placeholder
class _PlaceholderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawRect(Offset.zero & size, paint);
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
