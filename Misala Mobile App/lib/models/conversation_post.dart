// TODO Implement this library.import 'package:intl/intl.dart';

class ConversationPost {
  final int? id;
  final String title;
  final String content;
  final String author;
  final DateTime timestamp;
  final int likes;
  final int comments;
  final String category;

  ConversationPost({
    this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.timestamp,
    this.likes = 0,
    this.comments = 0,
    this.category = 'General',
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'content': content,
    'author': author,
    'timestamp': timestamp.toIso8601String(),
    'likes': likes,
    'comments': comments,
    'category': category,
  };

  factory ConversationPost.fromMap(Map<String, dynamic> map) => ConversationPost(
    id: map['id'],
    title: map['title'],
    content: map['content'],
    author: map['author'],
    timestamp: DateTime.parse(map['timestamp']),
    likes: map['likes'],
    comments: map['comments'],
    category: map['category'],
  );
}