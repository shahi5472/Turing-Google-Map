import 'package:flutter/material.dart';

class LoaderView extends StatelessWidget {
  const LoaderView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
