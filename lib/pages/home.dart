import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quad_mk2/Model/ChatModel.dart';
import '../components/navbar.dart';
import '../components/searchbar.dart';
import '../pages/profile.dart';
import '../pages/announcements.dart';
import '../pages/threads.dart';
import '../pages/work.dart';
import '../theme_notifier.dart';
import '../customchat/card.dart' as chat_card;
import 'chatpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _selectedChatFilter = 'All';

  // Dummy chat models
  final List<ChatModel> chats = [
    ChatModel(
      name: 'Alice',
      isGroup: false,
      currentMessage: 'Hey there!',
      time: '10:00 AM',
    ),
    ChatModel(
      name: 'Bob',
      isGroup: false,
      currentMessage: 'Whats up?',
      time: '9:45 AM',
    ),
    ChatModel(
      name: 'Study Group',
      isGroup: true,
      currentMessage: 'Lets meet at 5',
      time: '8:30 AM',
    ),
  ];

  // Only add external pages for index 1, 2, and 3
  final List<Widget?> pages = [
    null,
    const AnnouncementsPage(),
    const ThreadsPage(),
    const WorkPage(),
  ];

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget _buildFilterChip(String label, ThemeData theme) {
    final isSelected = _selectedChatFilter == label;
    final backgroundColor = isSelected
        ? theme.colorScheme.secondary.withOpacity(0.2)
        : theme.cardColor;
    final textColor = isSelected
        ? theme.colorScheme.secondary
        : theme.colorScheme.onBackground.withOpacity(0.7);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label, style: TextStyle(color: textColor)),
        selected: isSelected,
        onSelected: (_) {
          setState(() => _selectedChatFilter = label);
        },
        backgroundColor: Colors.transparent,
        selectedColor: backgroundColor,
        showCheckmark: false,
        labelPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QUAD',
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: theme.colorScheme.secondary,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: theme.colorScheme.onPrimary),
            onSelected: (value) {
              if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              } else if (value == 'toggle_theme') {
                Provider.of<ThemeNotifier>(
                  context,
                  listen: false,
                ).toggleTheme();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'profile', child: Text('Profile')),
              const PopupMenuItem(value: 'settings', child: Text('Settings')),
              const PopupMenuItem(value: 'logout', child: Text('Logout')),
              PopupMenuItem(
                value: 'toggle_theme',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Theme'),
                    Icon(
                      theme.brightness == Brightness.dark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      size: 18,
                      color: theme.colorScheme.secondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.15,
            child: Image.asset(
              'assets/bgchat.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          if (_selectedIndex == 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: SearchBarWithFilters(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('All', theme),
                        _buildFilterChip('Unread', theme),
                        _buildFilterChip('Groups', theme),
                        _buildFilterChip('Favourites', theme),
                        const SizedBox(width: 8),
                        RawMaterialButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/grouping'),
                          fillColor: theme.cardColor,
                          shape: const CircleBorder(),
                          constraints: const BoxConstraints.tightFor(
                            width: 40,
                            height: 40,
                          ),
                          elevation: 0,
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ChatPage(contactName: chats[index].name),
                            ),
                          );
                        },
                        child: chat_card.Card(),
                      );
                    },
                  ),
                ),
              ],
            )
          else
            Expanded(child: pages[_selectedIndex]!),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
