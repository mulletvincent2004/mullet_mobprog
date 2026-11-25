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

Lab Activity 2A: List Widgets

A Flutter social media app called **Facebook**, built on the Lab Activity 1 newsfeed. It adds a notification screen, a profile screen, and dynamic lists of posts and notifications.

## Lab Activity 2: Discussion

**Question:** Discuss how you manage to do the posts and the notification efficiently. Also, how you've accomplished the enhancement, state the challenges and how you address them.

**Answer:**

### Managing posts and notifications efficiently

In the base version, every post and notification was written out by hand as its own widget. That works for two items, but it does not scale to 10 posts and 20 notifications, because the same code gets repeated and any change has to be made many times.

To manage this efficiently, I separated the data from the widgets:

1. **Posts:** I created a small `_Post` class holding the user name, content, date, number of likes, image path, and a placeholder flag. The posts live in one `const` list, and `NewsfeedScreen` uses `ListView.builder` to turn each item into a `NewsfeedCard`. Adding a new post only means adding one entry to the list.
2. **Notifications:** `NotificationScreen` uses `ListView.separated` with `itemCount: 20`. The name, post number, and description are generated from short lists with `index % list.length`, so 20 notifications come from 10 names and 5 actions without writing 20 widgets. `ListView.separated` also draws the `Divider` between items.
3. **Lazy building:** both lists use the builder constructors, so Flutter only builds the items that are on screen, which keeps scrolling smooth even with longer lists.

### Enhancements, challenges, and solutions

- **Enhancement 1 (dynamic posts):** each post has its own number of likes and date, and the card shows a real image, a placeholder box, or nothing. *Challenge:* the card had a single `hasImage` flag, which could not express three cases. *Solution:* I used a nullable `imagePath` plus a `hasPlaceholder` boolean, and a `_buildMedia()` method returns the image, a `CustomPaint` placeholder (a box with an X), or `SizedBox.shrink()`.
- **Enhancement 2 (dynamic AppBar title):** I kept a `_titles` list in the same order as the tabs, and the AppBar shows `_titles[_selectedIndex]`. *Challenge:* the title must change both when tapping the bottom bar and when swiping the `PageView`. *Solution:* `_selectedIndex` is updated in both `onTap` and `onPageChanged`, so the title always matches the visible page.
- **Enhancement 3 (more BottomNavigationBarItem):** I added a Profile item and a `ProfileScreen`. *Challenge:* the number of nav items, titles, and pages must stay in sync or the app throws an index error. *Solution:* I kept all three lists in the same order and checked each tab after the change.
- **Enhancement 4 (app name):** I kept the name **Facebook** and stored it in a single `appName` constant in `constants.dart`, used in the AppBar, the `MaterialApp` title, and the profile screen. *Challenge:* when I changed the constant, the screen still showed the old name because hot reload does not rebuild values that were already created. *Solution:* I used a hot restart, which re-runs the app from the start and applies the new value everywhere.
- **Enhancement 5 (color palette):** I changed the five color constants to a teal and navy palette. *Challenge:* hot reload did not always apply constant changes. *Solution:* I used a hot restart, and because every widget already used the named constants, the whole app recolored without editing the widgets.