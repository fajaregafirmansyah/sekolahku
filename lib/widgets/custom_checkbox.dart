import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String text;

  const CustomCheckBox({Key key, this.onChanged, this.value, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onChanged(!value);
      },
      child: Row(
        children: [
          Checkbox(
              value: value,
              onChanged: (newValue){
                onChanged(newValue);
              }
          ),
          Text(text),
        ],
      ),
    );
  }
}
