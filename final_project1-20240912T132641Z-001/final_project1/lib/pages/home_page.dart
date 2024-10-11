
import 'package:final_project1/provider/firebase_provider.dart';
import 'package:final_project1/widget/box_device.dart';
import 'package:final_project1/widget/circle_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> _devicesLiving = [
    {"title": "Lighting 1", "icon": "lighting.png"},
    {"title": "Lighting 2", "icon": "lighting.png"},
  ];
  final List<Map<String, String>> _devicesBed = [
    {"title": "Lighting", "icon": "lighting.png"},
  ];
  final List<Map<String, String>> _devicesKitchen = [
    {"title": "Lighting", "icon": "lighting.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseProvider>(builder: (context, fire, child) {
      fire.getData();
      return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffeff1f5),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Hello ",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                        Text(
                          "Welcome back",
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: const Color(0xffa8a8a8)),
                        )
                      ],
                    ),
                    TextButton(onPressed: () {
                      fire.logout(context);
                    }, child: const Text("Logout"))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 160,
                      height: 80,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Color(0xff00fff0), Color(0xff0029ff)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "${fire.temp} °C",
                          style: GoogleFonts.poppins(
                              fontSize: 35, color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: 160,
                      height: 80,
                      decoration: BoxDecoration(
                          color: const Color(0xffeaeaea),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "${fire.hum} %",
                          style: GoogleFonts.poppins(
                              fontSize: 35,
                              color: const Color(0xff09d642),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: DynamicTabBarWidget(
                  dynamicTabs: [
                    TabData(
                        index: 0,
                        title: const Tab(
                          child: Text("Living room"),
                        ),
                        content: Container(
                          padding: const EdgeInsets.all(20),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            itemBuilder: (context, index) {
                              return BoxDevice(
                                title: _devicesLiving.elementAt(index)["title"],
                                icon: _devicesLiving.elementAt(index)["icon"],
                                value:
                                    _devicesLiving.elementAt(index)["title"] ==
                                            "Lighting 1"
                                        ? fire.led1LivingRoom
                                        : fire.led2LivingRoom,
                                onChanged: (value) {
                                  String title =
                                      _devicesLiving.elementAt(index)["title"]!;
                                  if (title == "Lighting 1") {
                                    fire.setLivingRoomLed1(value);
                                  } else {
                                    fire.setLivingRoomLed2(value);
                                  }
                                },
                              );
                            },
                            itemCount: _devicesLiving.length,
                          ),
                        )),
                    TabData(
                      index: 1,
                      title: const Tab(
                        child: Text("Bedroom"),
                      ),
                      content: Container(
                        padding: const EdgeInsets.all(20),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemBuilder: (context, index) {
                            return BoxDevice(
                              title: _devicesBed.elementAt(index)["title"],
                              icon: _devicesBed.elementAt(index)["icon"],
                              value: fire.ledBadRoom,
                              onChanged: (bool value) {
                                fire.setBedRoomLed(value);
                              },
                            );
                          },
                          itemCount: _devicesBed.length,
                        ),
                      ),
                    ),
                    TabData(
                        index: 2,
                        title: const Tab(
                          child: Text("Kitchen"),
                        ),
                        content: Container(
                          padding: const EdgeInsets.all(20),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            itemBuilder: (context, index) {
                              return BoxDevice(
                                title:
                                    _devicesKitchen.elementAt(index)["title"],
                                icon: _devicesKitchen.elementAt(index)["icon"],
                                value: fire.ledKitchen,
                                onChanged: (bool value) {
                                  fire.setKitchenLed(value);
                                },
                              );
                            },
                            itemCount: _devicesKitchen.length,
                          ),
                        ))
                  ],
                  onTabControllerUpdated: (TabController) {},
                  dividerHeight: 0,
                  indicator:
                      CircleTabIndicator(color: Colors.deepOrange, radius: 4),
                  labelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.blueGrey,
                  unselectedLabelStyle: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
