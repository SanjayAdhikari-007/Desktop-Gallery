import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData iconData;
  final Color? iconColor;
  final String msg;
  final Function()? onTap;
  const CustomButton(
      {Key? key,
      required this.iconData,
      required this.msg,
      this.onTap,
      this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: msg,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                // splashColor: Colors.blueAccent,
                // highlightColor: Colors.blueAccent,
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    iconData,
                    color: iconColor,
                    size: 30,
                  ),
                ))),
      ),
    );
  }
}
