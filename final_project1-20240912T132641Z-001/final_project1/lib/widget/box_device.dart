import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoxDevice extends StatefulWidget {
  String? title;
  String? icon;
  bool value;
  ValueChanged<bool>? onChanged;

  BoxDevice(
      {super.key,
      required this.title,
      required this.icon,
      required this.value,
      required this.onChanged});

  @override
  State<StatefulWidget> createState() {
    return _BoxDeviceState();
  }
}

class _BoxDeviceState extends State<BoxDevice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 205,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffe4e3e3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 50,
            height: 45,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffd6d6d6),
            ),
            child: Image.asset(
              'lib/image/${widget.icon}',
              color: Colors.black,
            ),
          ),
          Text(
            widget.title!,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.value ? 'ON' : "OFF",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              Switch(
                value: widget.value,
                onChanged: widget.onChanged,
                activeColor: const Color(0xffFFBA00),
              )
            ],
          )
        ],
      ),
    );
  }
}
