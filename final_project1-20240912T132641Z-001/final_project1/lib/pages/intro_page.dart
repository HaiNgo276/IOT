import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IntroPageState();
  }
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/image/intro.png"),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.5),
              Colors.transparent,
            ],
          ),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 80, bottom: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Configure Your\n Moment',
                        style: GoogleFonts.notoSerif(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff03aed2))),
                    Text(
                      'Manage your home\n from anytime, anywhere.',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        color: Color(0xff874ccc),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white38
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/LoginPage');
                          },
                          child: Text("Get Start",style: GoogleFonts.notoSerif(
                            fontSize: 40,
                            color: Colors.yellowAccent
                          ),),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
