class FileError implements Exception{
  String message;

  FileError({required this.message});

  @override
  String toString() {
    return 'FileError{message: $message}';
  }
}