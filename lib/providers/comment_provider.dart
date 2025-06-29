import 'package:flutter/material.dart';

class Comment {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String text;
  final DateTime timestamp;
  final List<String> hashtags;
  int likes;
  bool isLiked;

  Comment({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.text,
    required this.timestamp,
    required this.hashtags,
    this.likes = 0,
    this.isLiked = false,
  });
}

class CommentProvider with ChangeNotifier {
  final Map<String, List<Comment>> _comments = {};
  final Set<String> _trendingHashtags = {};

  CommentProvider() {
    // Add sample comments for each video
    _addSampleComments();
  }

  void _addSampleComments() {
    final sampleComments = {
      '1': [
        Comment(
          id: '1',
          userId: 'user1',
          userName: 'John Doe',
          userAvatar: 'assets/images/default_avatar.png',
          text: 'Great workout routine! #fitness #motivation',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          hashtags: ['fitness', 'motivation'],
          likes: 12,
        ),
        Comment(
          id: '2',
          userId: 'user2',
          userName: 'Jane Smith',
          userAvatar: 'assets/images/default_avatar.png',
          text: 'This is exactly what I needed! #workout #health',
          timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
          hashtags: ['workout', 'health'],
          likes: 8,
        ),
      ],
      '2': [
        Comment(
          id: '3',
          userId: 'user3',
          userName: 'Mike Johnson',
          userAvatar: 'assets/images/default_avatar.png',
          text: 'These recipes look delicious! #healthyfood #cooking',
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          hashtags: ['healthyfood', 'cooking'],
          likes: 15,
        ),
      ],
      '3': [
        Comment(
          id: '4',
          userId: 'user4',
          userName: 'Sarah Wilson',
          userAvatar: 'assets/images/default_avatar.png',
          text: 'Perfect for beginners! #meditation #mindfulness',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          hashtags: ['meditation', 'mindfulness'],
          likes: 20,
        ),
      ],
    };

    _comments.addAll(sampleComments);

    // Extract all hashtags from sample comments
    for (var comments in sampleComments.values) {
      for (var comment in comments) {
        _trendingHashtags.addAll(comment.hashtags);
      }
    }
  }

  List<Comment> getCommentsForVideo(String videoId) {
    return _comments[videoId] ?? [];
  }

  List<String> getTrendingHashtags() {
    return _trendingHashtags.toList();
  }

  void addComment(String videoId, Comment comment) {
    if (!_comments.containsKey(videoId)) {
      _comments[videoId] = [];
    }
    _comments[videoId]!.add(comment);

    // Update trending hashtags
    _trendingHashtags.addAll(comment.hashtags);
    notifyListeners();
  }

  void likeComment(String videoId, String commentId) {
    final comment = _comments[videoId]?.firstWhere((c) => c.id == commentId);
    if (comment != null) {
      comment.isLiked = !comment.isLiked;
      comment.likes += comment.isLiked ? 1 : -1;
      notifyListeners();
    }
  }

  List<String> extractHashtags(String text) {
    final hashtagRegex = RegExp(r'#\w+');
    return hashtagRegex
        .allMatches(text)
        .map((match) => match.group(0)!.substring(1))
        .toList();
  }

  int getCommentCount(String videoId) {
    return _comments[videoId]?.length ?? 0;
  }
}
