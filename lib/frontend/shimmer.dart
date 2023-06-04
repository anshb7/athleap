import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:athleap/frontend/skeleton.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Skeleton(
          height: 120,
          width: 120,
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Skeleton(width: 80),
            const SizedBox(height: 16 / 2),
            const Skeleton(),
            const SizedBox(height: 16 / 2),
            const Skeleton(),
            const SizedBox(height: 16 / 2),
            Row(
              children: const [
                Expanded(
                  child: Skeleton(),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Skeleton(),
                ),
              ],
            )
          ],
        ),
      )
    ]);
  }
}
