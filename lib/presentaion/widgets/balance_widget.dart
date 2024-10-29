import 'package:flutter/material.dart';

class BalanceWidget extends StatelessWidget {
  final int balance;

  BalanceWidget({required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_balance_wallet, color: Colors.white, size: 32),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              'Balance: $balance coins',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}