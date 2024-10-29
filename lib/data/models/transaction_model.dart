class TransactionModel {
  final String type; // "Scratch Reward" or "Redeemed Item"
  final String date; // e.g., "2024-10-29"
  final int amount;  // Reward or redemption amount

  TransactionModel({
    required this.type,
    required this.date,
    required this.amount,
  });
}