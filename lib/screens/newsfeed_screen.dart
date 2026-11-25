import 'package:flutter/material.dart';
import 'package:mullet_mobprog/widgets/newsfeed_card.dart';

class _Post {
  final String userName;
  final String content;
  final String date;
  final int likes;
  final String? imagePath;
  final bool hasPlaceholder;

  const _Post({
    required this.userName,
    required this.content,
    required this.date,
    required this.likes,
    this.imagePath,
    this.hasPlaceholder = false,
  });
}

const List<_Post> _posts = [
  _Post(
    userName: 'Steve Rogers',
    content: 'I can do this all day! #AvengersAssemble',
    date: '2 hours ago',
    likes: 10,
  ),
  _Post(
    userName: 'Tony Stark',
    content: 'I am Iron Man. #GeniusBillionairePlayboyPhilanthropist',
    date: 'December 1, 2023',
    likes: 3000,
    imagePath: 'assets/images/elijah.jpg',
  ),
  _Post(
    userName: 'Natasha Romanoff',
    content: 'Coffee first, saving the world second.',
    date: 'November 30, 2023',
    likes: 842,
    hasPlaceholder: true,
  ),
  _Post(
    userName: 'Bruce Banner',
    content: 'Please do not make me angry today.',
    date: 'November 29, 2023',
    likes: 215,
  ),
  _Post(
    userName: 'Thor Odinson',
    content: 'Anyone seen my hammer? #Mjolnir',
    date: 'November 28, 2023',
    likes: 5120,
    hasPlaceholder: true,
  ),
  _Post(
    userName: 'Clint Barton',
    content: 'Hawkeye never misses. Target practice today.',
    date: 'November 27, 2023',
    likes: 97,
  ),
  _Post(
    userName: 'Wanda Maximoff',
    content: 'Just redecorated the living room.',
    date: 'November 26, 2023',
    likes: 1304,
    hasPlaceholder: true,
  ),
  _Post(
    userName: 'Peter Parker',
    content: 'Homework due tomorrow and I have not started. #Spidey',
    date: 'November 25, 2023',
    likes: 760,
    imagePath: 'assets/images/iron_man.jpg',
  ),
  _Post(
    userName: 'Stephen Strange',
    content: 'Time is complicated. Do not ask me about Tuesday.',
    date: 'November 24, 2023',
    likes: 433,
  ),
  _Post(
    userName: 'Carol Danvers',
    content: 'Higher, further, faster, baby!',
    date: 'November 23, 2023',
    likes: 2088,
    hasPlaceholder: true,
  ),
];

class NewsfeedScreen extends StatelessWidget {
  const NewsfeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        return NewsfeedCard(
          userName: post.userName,
          postContent: post.content,
          date: post.date,
          numOfLikes: post.likes,
          imagePath: post.imagePath,
          hasPlaceholder: post.hasPlaceholder,
        );
      },
    );
  }
}
