import 'package:flutter/material.dart';

class Conversation {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final String avatar;
  final bool isOnline;

  Conversation({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.avatar,
    required this.isOnline,
  });
}

class ConversationProvider with ChangeNotifier {
  final List<Conversation> _conversations = [
    Conversation(
      id: '1',
      name: 'Dr. Sarah Johnson',
      lastMessage: 'Of course! What would you like to know?',
      time: '10:02 AM',
      unreadCount: 2,
      avatar: 'S',
      isOnline: true,
    ),
    Conversation(
      id: '2',
      name: 'Dr. Michael Chen',
      lastMessage: 'Your test results are ready',
      time: 'Yesterday',
      unreadCount: 0,
      avatar: 'M',
      isOnline: false,
    ),
    Conversation(
      id: '3',
      name: 'Dr. Emily Brown',
      lastMessage: 'See you at your next appointment',
      time: '2 days ago',
      unreadCount: 0,
      avatar: 'E',
      isOnline: true,
    ),
    Conversation(
      id: '4',
      name: 'Dr. James Wilson',
      lastMessage: 'The prescription has been sent to your pharmacy',
      time: '3 days ago',
      unreadCount: 0,
      avatar: 'J',
      isOnline: false,
    ),
  ];

  List<Conversation> get conversations => _conversations;

  List<Conversation> searchConversations(String query) {
    if (query.isEmpty) return _conversations;

    return _conversations.where((conversation) {
      final nameLower = conversation.name.toLowerCase();
      final messageLower = conversation.lastMessage.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower) ||
          messageLower.contains(searchLower);
    }).toList();
  }

  void addConversation(Conversation conversation) {
    _conversations.insert(0, conversation);
    notifyListeners();
  }

  void removeConversation(String id) {
    _conversations.removeWhere((conversation) => conversation.id == id);
    notifyListeners();
  }

  void updateLastMessage(String id, String message) {
    final index = _conversations.indexWhere((conv) => conv.id == id);
    if (index != -1) {
      final conversation = _conversations[index];
      _conversations[index] = Conversation(
        id: conversation.id,
        name: conversation.name,
        lastMessage: message,
        time: 'Just now',
        unreadCount: conversation.unreadCount,
        avatar: conversation.avatar,
        isOnline: conversation.isOnline,
      );
      notifyListeners();
    }
  }

  void markAsRead(String id) {
    final index = _conversations.indexWhere((conv) => conv.id == id);
    if (index != -1) {
      final conversation = _conversations[index];
      _conversations[index] = Conversation(
        id: conversation.id,
        name: conversation.name,
        lastMessage: conversation.lastMessage,
        time: conversation.time,
        unreadCount: 0,
        avatar: conversation.avatar,
        isOnline: conversation.isOnline,
      );
      notifyListeners();
    }
  }

  void updateOnlineStatus(String id, bool isOnline) {
    final index = _conversations.indexWhere((conv) => conv.id == id);
    if (index != -1) {
      final conversation = _conversations[index];
      _conversations[index] = Conversation(
        id: conversation.id,
        name: conversation.name,
        lastMessage: conversation.lastMessage,
        time: conversation.time,
        unreadCount: conversation.unreadCount,
        avatar: conversation.avatar,
        isOnline: isOnline,
      );
      notifyListeners();
    }
  }
}
