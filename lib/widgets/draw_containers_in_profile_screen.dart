import 'package:flutter/material.dart';


class DrawContainers extends StatelessWidget {
  final String text;
  final Function onPressed;
  DrawContainers({this.text,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 40,
        width: 370,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.3),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.transparent,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:15),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xffAE0001),
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(Icons.arrow_forward_ios,size: 30,color: Colors.black,),
            )
          ],
        ),
      ),
      onTap: onPressed,
    );
  }
}
