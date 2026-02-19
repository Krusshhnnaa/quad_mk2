import 'package:flutter/material.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  // track which card is hovered
  final Set<int> _hovered = {};

  // dummy data
  final List<_Announcement> _items = List.generate(
    3,
    (i) => _Announcement(
      headline: 'Announcement #${i + 1}',
      body:
          'Here is the full text of announcement #${i + 1}. It contains more details and possibly links or attachments.',
      author: 'Hettie Marshall',
      timeAgo: '${2 + i} hours ago',
    ),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // full-screen background
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Image.asset('assets/bgchat.jpg', fit: BoxFit.cover),
            ),
          ),

          //
          // announcements list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _items.length,
              itemBuilder: (context, idx) {
                final item = _items[idx];
                final hovering = _hovered.contains(idx);

                return MouseRegion(
                  onEnter: (_) => setState(() => _hovered.add(idx)),
                  onExit: (_) => setState(() => _hovered.remove(idx)),
                  child: GestureDetector(
                    onTap: () => _showDetail(context, item),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 16),
                      transform: hovering
                          ? (Matrix4.identity()..translate(0, -4))
                          : Matrix4.identity(),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: hovering ? 12 : 4,
                            offset: Offset(0, hovering ? 8 : 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.headline,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: theme.colorScheme.secondary,
                                child: Text(
                                  item.author[0],
                                  style: TextStyle(
                                    color: theme.colorScheme.onSecondary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item.author,
                                style: theme.textTheme.bodyMedium,
                              ),
                              const Spacer(),
                              Text(
                                item.timeAgo,
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDetail(BuildContext context, _Announcement item) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => Dialog(
        backgroundColor: theme.scaffoldBackgroundColor.withOpacity(0.9),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.headline,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(item.body, style: theme.textTheme.bodyLarge),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    // TODO: open attachment
                  },
                  icon: const Icon(Icons.link),
                  label: const Text('View Attachment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// simple data model
class _Announcement {
  final String headline, body, author, timeAgo;
  _Announcement({
    required this.headline,
    required this.body,
    required this.author,
    required this.timeAgo,
  });
}
