import 'package:flutter/material.dart';

// Placeholder implementation for student search.
// In a real app, this would fetch data from Supabase.
class StudentSearchDelegate extends SearchDelegate<String?> {
  final _mockData =
      List.generate(10, (index) => 'a2a8a99f-81a6-42a1-a163-4b8b156a03a${index % 10}');
  final _recentSearches = <String>[];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // For simplicity, just return the selected query as the result.
    // In a real app, you'd return the student's ID.
    final results = _mockData.where((id) => id.contains(query)).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Santri with ID: ${results[index]}'),
          onTap: () => close(context, results[index]),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? _recentSearches
        : _mockData.where((id) => id.contains(query)).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Santri ID: ${suggestions[index]}'),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}
