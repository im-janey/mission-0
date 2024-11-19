import 'package:flutter/material.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            flex: 3,
            child: Placeholder(), // Replace with HistoryListView if available
          ),
          const SizedBox(height: 10),
          Card(
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Replace with content",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Toggle favorite functionality
                },
                icon: const Icon(Icons.favorite_border),
                label: const Text('Like'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Next button functionality
                },
                child: const Text('Next'),
              ),
            ],
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
