import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/core/network/gemini_provider.dart';
import 'package:riseup/features/ai_chat/models/message.dart';
import 'package:riseup/features/ai_chat/providers/chat_provider.dart';
import 'package:riseup/features/settings/providers/user_profile_provider.dart';
import 'package:riseup/features/goals/providers/todo_provider.dart';

class AIChatScreen extends ConsumerStatefulWidget {
  const AIChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends ConsumerState<AIChatScreen>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();
  late final AnimationController _ambientController;
  late final AnimationController _introController;
  late final Animation<double> _introAnimation;
  bool _isLoading = false;

  final List<String> _suggestions = [
    'How do I stay consistent?',
    'I feel low on energy today.',
    'Help me plan my morning.',
  ];

  @override
  void initState() {
    super.initState();
    _ambientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat(reverse: true);
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _introAnimation = CurvedAnimation(
      parent: _introController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _messageFocusNode.dispose();
    _introController.dispose();
    _ambientController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage([String? suggestedText]) async {
    final messageText = (suggestedText ?? _messageController.text).trim();
    if (messageText.isEmpty) return;

    _messageController.clear();

    final history = ref
            .read(conversationMessagesProvider)
            .value
            ?.take(6)
            .map((msg) => '${msg.sender == SenderType.user ? 'User' : 'RiseUp'}: ${msg.text}')
            .toList() ??
        [];

    await ref
        .read(conversationMessagesProvider.notifier)
        .addMessage(messageText, SenderType.user);

    setState(() => _isLoading = true);

    try {
      final gemini = ref.read(geminiServiceProvider);
      final profile = ref.read(userProfileProvider).value;
      final activeTodosList = ref.read(activeTodosProvider).value ?? [];

      final userName = (profile != null &&
              profile.name.trim().isNotEmpty &&
              profile.name.trim() != 'User')
          ? profile.name.trim()
          : 'Friend';

      final activeGoalsText = activeTodosList.isNotEmpty
          ? activeTodosList.map((t) => '- ${t.title} (${t.subTodos.length} subtasks)').join(', ')
          : 'None set yet today.';

      final systemContext = await gemini.buildContext(
        userName: userName,
        currentMood: 4,
        currentEnergy: 4,
        activeGoals: activeGoalsText,
        recentWins: 'Consistent focus on promises and daily tasks.',
      );

      final response = await gemini.promptChat(
        context: systemContext + '\nKeep replies highly practical, encouraging, and concise (1-2 sentences).',
        history: history,
        userMessage: messageText,
      );

      ref
          .read(conversationMessagesProvider.notifier)
          .addMessage(response, SenderType.ai);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: const Text('Delete Chat'),
        content: const Text(
          'Are you sure you want to delete this conversation? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFE07165),
            ),
            onPressed: () {
              Navigator.pop(context);
              _deleteChatMessages();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteChatMessages() async {
    try {
      await ref.read(conversationMessagesProvider.notifier).clearMessages();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Chat cleared successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error deleting chat: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final messagesState = ref.watch(conversationMessagesProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF7F4ED),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        titleSpacing: 20,
        title: const Row(
          children: [
            _MiniLogo(),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RiseUp Chat',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF20332F),
                  ),
                ),
                Text(
                  'Steady, practical support',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF65706B),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white.withValues(alpha: 0.82)),
              ),
              child: IconButton(
                icon: const Icon(Icons.delete_sweep_rounded),
                color: const Color(0xFF20332F),
                tooltip: 'Delete chat',
                onPressed: _showDeleteDialog,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _ambientController,
              builder: (context, _) {
                return CustomPaint(
                  painter: _ChatBackdropPainter(_ambientController.value),
                );
              },
            ),
          ),
          SafeArea(
            child: FadeTransition(
              opacity: _introAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.035),
                  end: Offset.zero,
                ).animate(_introAnimation),
                child: Column(
                  children: [
                    Expanded(
                      child: messagesState.when(
                        data: (messages) {
                          if (messages.isEmpty) {
                            return _EmptyChatState(
                              suggestions: _suggestions,
                              onSuggestionTap: _sendMessage,
                            );
                          }

                          return _MessageList(
                            messages: messages,
                            isLoading: _isLoading,
                          );
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(strokeWidth: 3),
                        ),
                        error: (error, _) => _ChatErrorState(
                          message: 'Error: $error',
                        ),
                      ),
                    ),
                    _Composer(
                      controller: _messageController,
                      focusNode: _messageFocusNode,
                      isLoading: _isLoading,
                      onSend: _sendMessage,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageList extends StatelessWidget {
  const _MessageList({required this.messages, required this.isLoading});

  final List<Message> messages;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      itemCount: messages.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (isLoading && index == 0) {
          return const _TypingBubble();
        }

        final messageIndex = messages.length - 1 - (index - (isLoading ? 1 : 0));
        final message = messages[messageIndex];

        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: Duration(milliseconds: 280 + (index.clamp(0, 5) * 35)),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 12 * (1 - value)),
              child: Opacity(opacity: value, child: child),
            );
          },
          child: _MessageBubble(message: message),
        );
      },
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == SenderType.user;
    final maxWidth = MediaQuery.of(context).size.width * (isUser ? 0.78 : 0.86);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isUser) ...[
              const _MiniLogo(small: true),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Container(
                constraints: BoxConstraints(maxWidth: maxWidth),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: isUser
                      ? const LinearGradient(
                          colors: [Color(0xFF25463C), Color(0xFF4D8C76)],
                        )
                      : null,
                  color: isUser ? null : Colors.white.withValues(alpha: 0.86),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(18),
                    topRight: const Radius.circular(18),
                    bottomLeft: Radius.circular(isUser ? 18 : 6),
                    bottomRight: Radius.circular(isUser ? 6 : 18),
                  ),
                  border: isUser
                      ? null
                      : Border.all(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF27463C).withValues(alpha: 0.08),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: isUser ? Colors.white : const Color(0xFF243C36),
                    fontSize: 15,
                    height: 1.42,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyChatState extends StatelessWidget {
  const _EmptyChatState({
    required this.suggestions,
    required this.onSuggestionTap,
  });

  final List<String> suggestions;
  final ValueChanged<String> onSuggestionTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
      child: Column(
        children: [
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF25463C), Color(0xFF6F9E88)],
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF25463C).withValues(alpha: 0.24),
                  blurRadius: 32,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -12,
                  top: -18,
                  child: Icon(
                    Icons.forum_rounded,
                    size: 116,
                    color: Colors.white.withValues(alpha: 0.12),
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _MiniLogo(inverted: true),
                    SizedBox(height: 18),
                    Text(
                      'What feels heavy right now?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        height: 1.05,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Share the messy version. RiseUp will help turn it into a calm, doable next move.',
                      style: TextStyle(
                        color: Color(0xFFEAF4EF),
                        fontSize: 15,
                        height: 1.45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Try a prompt',
              style: TextStyle(
                color: const Color(0xFF20332F).withValues(alpha: 0.9),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 12),
          for (final suggestion in suggestions)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _SuggestionTile(
                text: suggestion,
                onTap: () => onSuggestionTap(suggestion),
              ),
            ),
        ],
      ),
    );
  }
}

class _SuggestionTile extends StatelessWidget {
  const _SuggestionTile({required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.82),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              const Icon(
                Icons.auto_awesome_rounded,
                color: Color(0xFFE99572),
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF243C36),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_rounded, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.focusNode,
    required this.isLoading,
    required this.onSend,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isLoading;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final hasKeyboard = MediaQuery.viewInsetsOf(context).bottom > 0;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, hasKeyboard ? 12 : 96),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: Colors.white.withValues(alpha: 0.9)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF27463C).withValues(alpha: 0.13),
                blurRadius: 28,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    enabled: !isLoading,
                    minLines: 1,
                    maxLines: 5,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => onSend(),
                    decoration: const InputDecoration(
                      hintText: 'Share what is on your mind...',
                      hintStyle: TextStyle(color: Color(0xFF8B9691)),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 12,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.3,
                      color: Color(0xFF243C36),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 48,
                  height: 48,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder(),
                      backgroundColor: const Color(0xFF25463C),
                      disabledBackgroundColor: const Color(0xFFB8C5BF),
                    ),
                    onPressed: isLoading ? null : onSend,
                    child: isLoading
                        ? const SizedBox(
                            width: 19,
                            height: 19,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.arrow_upward_rounded, size: 21),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MiniLogo(small: true),
            SizedBox(width: 8),
            _TypingDots(),
          ],
        ),
      ),
    );
  }
}

class _TypingDots extends StatefulWidget {
  const _TypingDots();

  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.86),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (index) {
              final wave = math.sin((_controller.value * math.pi * 2) + index);
              return Container(
                width: 7,
                height: 7,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF4D8C76).withValues(
                    alpha: 0.35 + (wave + 1) * 0.25,
                  ),
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

class _ChatErrorState extends StatelessWidget {
  const _ChatErrorState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.86),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded, color: Color(0xFFE07165)),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                message,
                style: const TextStyle(color: Color(0xFF243C36)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniLogo extends StatelessWidget {
  const _MiniLogo({this.small = false, this.inverted = false});

  final bool small;
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    final size = small ? 30.0 : 38.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: inverted
              ? const [Colors.white, Color(0xFFFFE7C8)]
              : const [Color(0xFF25463C), Color(0xFF6F9E88)],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.auto_awesome_rounded,
        size: small ? 17 : 21,
        color: inverted ? const Color(0xFF25463C) : Colors.white,
      ),
    );
  }
}

class _ChatBackdropPainter extends CustomPainter {
  const _ChatBackdropPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final backgroundPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFF8F3E7), Color(0xFFEAF4EC), Color(0xFFFFECE0)],
      ).createShader(rect);

    canvas.drawRect(rect, backgroundPaint);

    void drawGlow(Color color, Offset center, double radius) {
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [color.withValues(alpha: 0.28), color.withValues(alpha: 0)],
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawCircle(center, radius, paint);
    }

    drawGlow(
      const Color(0xFF77A98E),
      Offset(size.width * (0.12 + progress * 0.08), size.height * 0.18),
      size.width * 0.56,
    );
    drawGlow(
      const Color(0xFFE99572),
      Offset(size.width * (0.9 - progress * 0.08), size.height * 0.22),
      size.width * 0.48,
    );
    drawGlow(
      const Color(0xFF6F8EDB),
      Offset(size.width * 0.76, size.height * (0.78 - progress * 0.08)),
      size.width * 0.46,
    );
  }

  @override
  bool shouldRepaint(covariant _ChatBackdropPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
