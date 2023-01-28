import 'package:flutter/material.dart';

class SearchbarContainer extends StatelessWidget {
  const SearchbarContainer({
    Key? key,
    this.controller,
    this.onFieldSubmitted,
    this.hintText = "Search your place",
  }) : super(key: key);

  final TextEditingController? controller;

  final void Function(String)? onFieldSubmitted;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(1, 1),
            blurRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Center(
        child: TextFormField(
          textInputAction: TextInputAction.search,
          controller: controller,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            hintText: hintText,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
