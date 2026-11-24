# mullet_mobprog

# mullet_mobprog

Lab Activity 1A: File Structuring | Design Pattern

A Flutter Facebook newsfeed replication that uses `flutter_screenutil` for responsive sizing and a structured folder layout (`screens/`, `widgets/`, `constants.dart`).

## Lab Activity 1: Discussion

Question: Discuss how you integrate the Image to the `newsfeed_card.dart` and make it dynamic whether it has image or not.

Answer:

In the original code, the image was hard-coded: `NewsfeedCard` received a `hasImage` boolean, and when it was `true` the card always showed the same file, `assets/images/iron_man.jpg`. This meant every post with an image would display the same picture, and the card could not show different images.

To integrate the image dynamically, I made these changes in `newsfeed_card.dart`:

1. Replaced `hasImage` with a nullable `imagePath`.** The constructor now takes `final String? imagePath;`. A `null` value means the post has no image, and a string value is the asset path of the image to show. This one field answers both questions: whether there is an image and which one.

2. *Used the `Image` widget (`Image.asset`) with a conditional.** Inside the `Column`, I used a collection `if`:

   ```dart
   if (imagePath != null)
     ClipRRect(
       borderRadius: BorderRadius.circular(ScreenUtil().setSp(6)),
       child: Image.asset(
         imagePath!,
         width: double.infinity,
         fit: BoxFit.cover,
         errorBuilder: (context, error, stackTrace) { ... },
       ),
     ),
   ```

   If `imagePath` is `null`, nothing is added to the column, so the card has no empty space where an image would be. If it has a value, the image fills the card width, is cropped with `BoxFit.cover`, and has rounded corners from `ClipRRect`.

3. Added an `errorBuilder`.** If the asset file is missing or the path is wrong, the card shows a grey placeholder with a broken-image icon instead of crashing with a red error screen.

4. Passed the path from `newsfeed_screen.dart`. Steve Rogers' post gives no `imagePath`, so it shows text only. Tony Stark's post gives `imagePath: 'assets/images/iron_man.jpg'`, so it shows the image. Any post can now show any image just by passing a different path.

Other enhancements:**
- Avatar:** the profile `Icon(Icons.person)` was replaced by a reusable `CircleAvatar` widget. It can show a photo through an optional `avatarPath`, and falls back to a person icon when none is given.
- Like and Comment buttons:** Like, Comment, and Share are now all `TextButton.icon` widgets built by one reusable `_buildActionButton` method, wrapped in `Expanded` so they are evenly spaced. Comment was previously plain text and is now a tappable widget.
