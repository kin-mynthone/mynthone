import 'package:flutter/material.dart';

import '../../../constants/app_numbers.dart';

class IntroductionView extends StatelessWidget {
  const IntroductionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Placeholder(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppNumbers.screenPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Mynthone',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Proceed'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
