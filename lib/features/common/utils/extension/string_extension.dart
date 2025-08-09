extension StringExtension on String {
  String toTitleCase() {
    if (isEmpty) {
      return '';
    }
    return split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : '')
        .join(' ');
  }

  String getInitials() {
    if (trim().isEmpty) {
      return '';
    }

    final List<String> words =
        trim().split(' ').where((word) => word.isNotEmpty).toList();
    if (words.isEmpty) {
      return '';
    }

    String initials = words.first[0];
    if (words.length > 1) {
      initials += words[1][0];
    }
    if (words.length > 2) {
      initials += words[2][0];
    }

    return initials.toUpperCase();
  }
}
