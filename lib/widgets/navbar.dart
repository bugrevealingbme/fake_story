import 'package:fake_story/screens/home.dart';
import 'package:fake_story/screens/profile.dart';
import 'package:fake_story/utils/app_constans.dart';
import 'package:flutter/material.dart';

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
  List<IconData> _iconList = [
    Icons.home,
    Icons.card_giftcard,
    Icons.file_upload_outlined,
    Icons.bookmark,
    Icons.person,
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

    for (var i = 0; i < _iconList.length; i++) {
      _navBarItemList.add(buildNavBarItem(_iconList[i], i));
    }

    return Row(
      children: _navBarItemList,
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    List<String> _stringList = [
      'Home',
      'Premium',
      'Upload',
      'Saved',
      'Tools',
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        height: 80,
        width: MediaQuery.of(context).size.width / _iconList.length,
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
            : const BoxDecoration(),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Icon(
              icon,
              color: index == _selectedIndex
                  ? Constants.themeColor
                  : index == 2
                      ? Colors.grey
                      : Colors.grey,
            ),
            const SizedBox(height: 5),
            Text(
              _stringList[index],
              style: TextStyle(
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
