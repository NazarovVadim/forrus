import 'package:flutter/material.dart';
import 'package:forrus/styles/style_library.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.title, this.onTap}) : super(key: key);

  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: (onTap != null )
            ? StyleLibrary.color.primary
            : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          child: Container(
            constraints: BoxConstraints(
                minHeight: 60,
                minWidth: MediaQuery.of(context).size.width/2),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Center(child: Text(title, style: StyleLibrary.font.body,)),
          ),
        ),
      ),
    );
  }
}

class WaitButton extends StatelessWidget {
  const WaitButton({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: StyleLibrary.color.primary,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          constraints: BoxConstraints(
              minHeight: 60,
              minWidth: MediaQuery.of(context).size.width/2),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Center(child: CircularProgressIndicator(color: Colors.black,)),
        ),
      ),
    );
  }
}

