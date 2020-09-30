import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({
    @required Key key,
    @required this.text,
    this.isHighlighted = true,
    this.onTap,
  }) :  assert(key != null, 'Key must be not null'),
        assert(text != null, 'Text must be not null'),
        super(key: key);

  final String text;
  final bool isHighlighted;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 163.0,
        height: 48.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isHighlighted ? Color(0xFFF06500) : Color(0x00000000),
          borderRadius: BorderRadius.all(
            Radius.circular(100.0),
          ),
          border: Border.all(
            width: 1.0,
            color: isHighlighted ? Color(0xFFF06500) : Color(0xFF979797),
          )
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isHighlighted ? Color(0xFFFFFFFF) : Color(0xFF979797),
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
