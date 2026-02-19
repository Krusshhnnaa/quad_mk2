// lib/pages/threads.dart

import 'package:flutter/material.dart';

class ThreadsPage extends StatelessWidget {
  const ThreadsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Image.asset('assets/bgchat.jpg', fit: BoxFit.cover),
            ),
          ),

          // Theme toggle and content
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Card(
                      color: theme.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ExpansionTile(
                        title: Text(
                          'Thread #${index + 1}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: List.generate(
                          3,
                          (i) => ListTile(
                            title: Text(
                              'Message ${i + 1} in thread',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
