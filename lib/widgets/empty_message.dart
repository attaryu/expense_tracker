import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyMessage extends StatelessWidget {
  const EmptyMessage(this.message, {super.key, this.height = 0});

  final double height;
  final String message;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: height >= 0 ? height : 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/cat.svg', height: 200),
            Text(
              message,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
