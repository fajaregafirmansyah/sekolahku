import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;
  final Color activeColor;
  final String label;

  const CustomRadio(
      {Key key,
      this.value,
      this.groupValue,
      this.onChanged,
      this.activeColor,
      this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: (value){
              onChanged(value);
            }
        ),
        Text(label)
      ],
    );
  }
}
