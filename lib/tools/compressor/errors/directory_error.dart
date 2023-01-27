class DirectoryError implements Exception{
  String message;

  DirectoryError({required this.message});

  @override
  String toString() {
    return 'DirectoryError{message: $message}';
  }
}