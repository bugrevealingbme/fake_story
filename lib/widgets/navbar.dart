import 'dart:ui';

import 'package:fake_story/screens/home.dart';
import 'package:fake_story/screens/profile.dart';
import 'package:fake_story/utils/app_constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'widgets.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;

  CustomBottomNavigationBar(
      {this.defaultSelectedIndex = 0, required this.onChange});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  final List<String> _svgList = [
    'assets/icons/home.svg',
    'assets/icons/diamond.svg',
    'assets/icons/upload.svg',
    'assets/icons/vector.svg',
    'assets/icons/user.svg'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _selectedIndex = widget.defaultSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _navBarItemList = [];

    for (var i = 0; i < _svgList.length; i++) {
      _navBarItemList.add(buildNavBarItem(_svgList[i], i));
    }

    return Align(
      alignment: FractionalOffset.bottomCenter,
      heightFactor: 1,
      child: ClipRect(
        //I'm using BackdropFilter for the blurring effect
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 7,
            sigmaY: 7,
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.970),
                border: const Border(
                    top: BorderSide(width: 0.5, color: Colors.grey))),
            child: Row(
              children: _navBarItemList,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavBarItem(String icon, int index) {
    List<String> _stringList = [
      'Home',
      'Premium',
      'Upload',
      'Tools',
      'Profile',
    ];

    return GestureDetector(
      onTap: () {
        widget.onChange(index);
        setState(() {
          if (index == 4 && _selectedIndex != index) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfilePage(),
                ));
          } else if (index == 1 && _selectedIndex != index) {
            GeneralWidgets.vipDialog(context);
          } else if (index == 0 && _selectedIndex != index) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MyHomePage(),
                ));
          }

          _selectedIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / _svgList.length,
        decoration: index == 2
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Constants.themeColor.withOpacity(0.1),
                    Constants.themeColor.withOpacity(0.015),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              )
            : const BoxDecoration(color: Colors.transparent),
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(icon,
                  color: index == _selectedIndex
                      ? Constants.themeColor
                      : Colors.grey,
                  semanticsLabel: _stringList[index]),
            ),
            const SizedBox(height: 5),
            Text(
              _stringList[index],
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: index == _selectedIndex
                      ? Constants.themeColor
                      : Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
