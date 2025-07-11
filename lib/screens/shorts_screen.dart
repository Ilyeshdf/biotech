import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../providers/video_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/comment_section.dart';
import 'profile_screen.dart';

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({super.key});

  @override
  ShortsScreenState createState() => ShortsScreenState();
}

class ShortsScreenState extends State<ShortsScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final Map<int, VideoPlayerController> _controllers = {};
  final Map<int, bool> _isLoading = {};
  final Map<int, String?> _errorMessages = {};

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeVideo(int index, String videoUrl) {
    if (_controllers.containsKey(index)) return;

    setState(() {
      _isLoading[index] = true;
      _errorMessages[index] = null;
    });

    final controller = VideoPlayerController.network(videoUrl);
    _controllers[index] = controller;

    controller.initialize().then((_) {
      if (mounted) {
        setState(() {
          _isLoading[index] = false;
        });
        controller.play();
        controller.setLooping(true);
      }
    }).catchError((error) {
      if (mounted) {
        setState(() {
          _isLoading[index] = false;
          _errorMessages[index] = 'Failed to load video: ${error.toString()}';
        });
      }
    });
  }

  void _disposeVideo(int index) {
    if (_controllers.containsKey(index)) {
      _controllers[index]?.dispose();
      _controllers.remove(index);
      _isLoading.remove(index);
      _errorMessages.remove(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Consumer<VideoProvider>(
            builder: (context, videoProvider, child) {
              final videos = videoProvider.videos;

              if (videos.isEmpty) {
                return Center(
                  child: Text(
                    'No videos available',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }

              return PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: videos.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                  _initializeVideo(index, videos[index].videoUrl);
                  if (index > 0) _disposeVideo(index - 1);
                  if (index < videos.length - 1) _disposeVideo(index + 1);
                },
                itemBuilder: (context, index) {
                  final video = videos[index];
                  return _buildVideoCard(video, videoProvider, index);
                },
              );
            },
          ),
          Positioned(
            top: 40,
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(ShortVideo video, VideoProvider provider, int index) {
    final controller = _controllers[index];
    final isInitialized = controller?.value.isInitialized ?? false;
    final isLoading = _isLoading[index] ?? false;
    final errorMessage = _errorMessages[index];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (isInitialized)
          AspectRatio(
            aspectRatio: controller!.value.aspectRatio,
            child: VideoPlayer(controller),
          )
        else if (isLoading)
          Container(
            color: isDark
                ? const Color(0xFF121212)
                : Theme.of(context).scaffoldBackgroundColor,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          )
        else if (errorMessage != null)
          Container(
            color: isDark
                ? const Color(0xFF121212)
                : Theme.of(context).scaffoldBackgroundColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Theme.of(context).colorScheme.error,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    errorMessage,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _initializeVideo(index, video.videoUrl),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          )
        else
          Container(
            color: isDark
                ? const Color(0xFF121212)
                : Theme.of(context).scaffoldBackgroundColor,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  isDark
                      ? const Color(0xFF1E1E1E).withOpacity(0.9)
                      : Theme.of(context).colorScheme.surface.withOpacity(0.8),
                ],
                stops: const [0.7, 1.0],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  isDark
                      ? const Color(0xFF1E1E1E).withOpacity(0.95)
                      : Theme.of(context).colorScheme.surface.withOpacity(0.9),
                  isDark
                      ? const Color(0xFF1E1E1E).withOpacity(0.8)
                      : Theme.of(context).colorScheme.surface.withOpacity(0.7),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          isDark ? Colors.grey[800] : Colors.grey[200],
                      child: ClipOval(
                        child: Image.asset(
                          video.authorAvatar,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              color:
                                  isDark ? Colors.grey[600] : Colors.grey[400],
                              size: 24,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                userId: video.authorId,
                                userName: video.authorName,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              video.authorName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                            Text(
                              '@${video.authorName.toLowerCase().replaceAll(' ', '')}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.7),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        video.isLiked ? Icons.favorite : Icons.favorite_border,
                        color: video.isLiked
                            ? AppTheme.error
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                      onPressed: () {
                        provider.likeVideo(video.id);
                      },
                    ),
                    Text(
                      '${video.likes}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  video.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  video.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: video.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '#$tag',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  video.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: video.isLiked
                      ? AppTheme.error
                      : Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () {
                  provider.likeVideo(video.id);
                },
              ),
              Text(
                '${video.likes}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: 16),
              IconButton(
                icon: Icon(
                  Icons.comment_outlined,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => DraggableScrollableSheet(
                      initialChildSize: 0.7,
                      minChildSize: 0.5,
                      maxChildSize: 0.95,
                      builder: (context, scrollController) => CommentSection(
                        videoId: video.id,
                      ),
                    ),
                  );
                },
              ),
              Text(
                '${video.comments}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: 16),
              IconButton(
                icon: Icon(
                  Icons.share_outlined,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Share functionality coming soon!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
