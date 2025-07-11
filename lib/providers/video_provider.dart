import 'package:flutter/material.dart';

class ShortVideo {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final String authorId;
  final String authorName;
  final String authorAvatar;
  final List<String> tags;
  int likes;
  int comments;
  int shares;
  bool isLiked;

  ShortVideo({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.authorId,
    required this.authorName,
    required this.authorAvatar,
    required this.tags,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.isLiked = false,
  });
}

class VideoProvider with ChangeNotifier {
  final List<ShortVideo> _videos = [
    ShortVideo(
      id: '1',
      title: 'Morning Workout Routine',
      description:
          'Start your day with this energizing workout routine! 💪 #fitness #morningworkout',
      videoUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      authorId: 'Fitness Pro',
      authorName: 'Fitness Pro',
      authorAvatar: 'assets/images/default_avatar.png',
      tags: ['fitness', 'workout', 'morning', 'health'],
      likes: 1234,
      comments: 0,
      shares: 45,
    ),
    ShortVideo(
      id: '2',
      title: 'Healthy Recipe Ideas',
      description:
          'Quick and healthy meal prep ideas for busy days 🥗 #healthyfood #mealprep',
      videoUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      authorId: 'Healthy Chef',
      authorName: 'Healthy Chef',
      authorAvatar: 'assets/images/default_avatar.png',
      tags: ['food', 'healthy', 'recipe', 'cooking'],
      likes: 856,
      comments: 0,
      shares: 34,
    ),
    ShortVideo(
      id: '3',
      title: 'Meditation for Beginners',
      description:
          'Learn the basics of meditation in just 5 minutes 🧘‍♀️ #meditation #mindfulness',
      videoUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      authorId: 'Mindful Living',
      authorName: 'Mindful Living',
      authorAvatar: 'assets/images/default_avatar.png',
      tags: ['meditation', 'mindfulness', 'wellness', 'mentalhealth'],
      likes: 2345,
      comments: 0,
      shares: 78,
    ),
  ];

  List<ShortVideo> get videos => _videos;

  List<ShortVideo> getVideosByTag(String tag) {
    return _videos.where((video) => video.tags.contains(tag)).toList();
  }

  List<ShortVideo> searchVideos(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _videos.where((video) {
      return video.title.toLowerCase().contains(lowercaseQuery) ||
          video.description.toLowerCase().contains(lowercaseQuery) ||
          video.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  void likeVideo(String id) {
    final videoIndex = _videos.indexWhere((video) => video.id == id);
    if (videoIndex != -1) {
      final video = _videos[videoIndex];
      video.isLiked = !video.isLiked;
      video.likes += video.isLiked ? 1 : -1;
      notifyListeners();
    }
  }

  void updateCommentCount(String id, int count) {
    final videoIndex = _videos.indexWhere((video) => video.id == id);
    if (videoIndex != -1) {
      _videos[videoIndex].comments = count;
      notifyListeners();
    }
  }

  void shareVideo(String id) {
    final videoIndex = _videos.indexWhere((video) => video.id == id);
    if (videoIndex != -1) {
      _videos[videoIndex].shares++;
      notifyListeners();
    }
  }
}
