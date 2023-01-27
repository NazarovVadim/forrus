class TicketError implements Exception{
  String message;

  TicketError({required this.message});

  @override
  String toString() {
    return '$message';
  }
}