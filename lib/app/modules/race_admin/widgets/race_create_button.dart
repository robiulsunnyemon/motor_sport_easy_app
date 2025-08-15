
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RaceCreateButton extends StatelessWidget {
  final VoidCallback onTap;
  final String level;
  const RaceCreateButton({super.key, required this.onTap, required this.level});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed:onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(
            const Color(0xFFDC2626),
          ),
          elevation: WidgetStatePropertyAll<double>(0.2),
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ),
        child: SizedBox(
          height: 50,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/svg/addIcon.svg",),
                SizedBox(width: 10,),
                Text(
                  level,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}