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
}
