import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reward_bloc.dart';
import '../bloc/reward_state.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transaction History")),
      body: BlocBuilder<RewardBloc, RewardState>(
        builder: (context, state) {
          final transactions = context.read<RewardBloc>().transactions;
          if (transactions == null || transactions.isEmpty) {
            return Center(child: Text('No transactions available'));
          }
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(
                    transaction['type'] == 'Scratch Card Reward'
                        ? Icons.card_giftcard
                        : Icons.shopping_cart,
                    color: Colors.blue,
                  ),
                  title: Text(
                    transaction['type'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(transaction['date']),
                  trailing: Text(
                    '${transaction['amount']} coins',
                    style: TextStyle(
                      color: transaction['amount'] > 0 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}