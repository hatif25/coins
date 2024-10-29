import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reward_bloc.dart';
import '../bloc/reward_event.dart';

class ScratchCardWidget extends StatefulWidget {
  @override
  _ScratchCardWidgetState createState() => _ScratchCardWidgetState();
}

class _ScratchCardWidgetState extends State<ScratchCardWidget> {
  bool isScratched = false;
  DateTime nextScratchTime = DateTime.now().subtract(Duration(hours: 1));

  void handleScratch() {
    if (DateTime.now().isAfter(nextScratchTime)) {
      context.read<RewardBloc>().add(ScratchCardEvent());
      setState(() {
        isScratched = true;
        nextScratchTime = DateTime.now().add(Duration(hours: 1));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleScratch,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isScratched ? Colors.green : Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: isScratched
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Scratched!",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Next scratch available at: ${nextScratchTime.hour}:${nextScratchTime.minute}",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              )
            : Text(
                "Scratch Here",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
      ),
    );
  }
}