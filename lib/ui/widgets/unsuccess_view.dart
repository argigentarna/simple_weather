// ignore_for_file: must_be_immutable

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart' as lt;

class UnsuccessView extends StatelessWidget {
  UnsuccessView({
    Key? key,
    required this.type,
  }) : super(key: key);
  String type;

  @override
  Widget build(BuildContext context) {
    return lt.Lottie.asset(
      type,
      height: 200,
      width: 200,
    );
  }
}
