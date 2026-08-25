/// Contextual companion messages based on time of day
class CompanionMessageService {
  /// Get time period for a given hour
  static String _getTimePeriod(int hour) {
    if (hour >= 6 && hour < 12) return 'morning';
    if (hour >= 12 && hour < 17) return 'afternoon';
    if (hour >= 17 && hour < 21) return 'evening';
    return 'night';
  }

  /// Morning messages (6 AM - 12 PM)
  static const List<String> morningMessages = [
    'What would make today a good day?',
    'How are you feeling this morning?',
    'Ready for a fresh start?',
    'What\'s on your mind today?',
    'How\'s your energy this morning?',
    'What would you like to focus on today?',
    'Excited about anything today?',
    'Let\'s make today count.',
  ];

  /// Afternoon messages (12 PM - 5 PM) - College focused
  static const List<String> afternoonMessages = [
    'How\'s college going?',
    'What are you focused on right now?',
    'Need a quick energy check?',
    'How\'s your focus holding up?',
    'What class or activity are you in?',
    'Keeping up with your goals?',
    'How\'s your momentum?',
    'What\'s happening in your day?',
  ];

  /// Evening messages (5 PM - 9 PM)
  static const List<String> eveningMessages = [
    'What would you like to work on tonight?',
    'How is your energy after today\'s classes?',
    'What\'s one thing you\'d like to accomplish?',
    'Ready for an evening focus session?',
    'How are you managing today?',
    'Time for a study session or a break?',
    'What\'s next for you today?',
    'How was your day so far?',
  ];

  /// Night messages (9 PM - 6 AM)
  static const List<String> nightMessages = [
    'What was today\'s small win?',
    'Anything you\'re proud of today?',
    'How are you feeling before sleep?',
    'Reflecting on your day?',
    'What\'s one good thing that happened?',
    'Ready to wind down?',
    'How\'s your energy level?',
    'Taking care of yourself tonight?',
  ];

  /// Get contextual messages for a given hour
  static List<String> getMessagesForHour(int hour) {
    final period = _getTimePeriod(hour);
    switch (period) {
      case 'morning':
        return morningMessages;
      case 'afternoon':
        return afternoonMessages;
      case 'evening':
        return eveningMessages;
      case 'night':
        return nightMessages;
      default:
        return morningMessages;
    }
  }

  /// Get a random contextual message for current time
  static String getRandomMessageForNow() {
    final hour = DateTime.now().hour;
    final messages = getMessagesForHour(hour);
    return messages[DateTime.now().microsecond % messages.length];
  }

  /// Get a random contextual message for a specific hour
  static String getRandomMessageForHour(int hour) {
    final messages = getMessagesForHour(hour);
    return messages[DateTime.now().microsecond % messages.length];
  }

  /// Time period names for analytics
  static String getTimePeriodName(int hour) {
    final period = _getTimePeriod(hour);
    switch (period) {
      case 'morning':
        return 'Morning';
      case 'afternoon':
        return 'Afternoon';
      case 'evening':
        return 'Evening';
      case 'night':
        return 'Night';
      default:
        return 'Unknown';
    }
  }
}
