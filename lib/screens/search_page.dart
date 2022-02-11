import 'package:fake_story/utils/app_constans.dart';
import 'package:fake_story/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  bool viewer = false;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, initialIndex: 0, length: 3);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Constants.primaryColor,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: const Color(0xffF2F4F5),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff222222)),
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: const TextStyle(
                            color: Color(0xff8f8f8f), fontSize: 17),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xff8f8f8f),
                        ),
                      ),
                      onChanged: (val) {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 16),
                      )),
                ],
              ),
              const SizedBox(height: 30),
              GeneralWidgets.crtLabel('Categories'),
              const SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GeneralWidgets.categoryC("Girls"),
                    GeneralWidgets.categoryC("Travel"),
                    GeneralWidgets.categoryC("Holiday"),
                    GeneralWidgets.categoryC("Sports"),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Theme(
                    data: ThemeData(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color(0xfff0dff3),
                      ),
                      labelPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 0),
                      padding: const EdgeInsets.all(0),
                      indicatorPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 4),
                      labelColor: Colors.black,
                      labelStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                      unselectedLabelColor:
                          const Color.fromARGB(255, 139, 139, 139),
                      unselectedLabelStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                      isScrollable: true,
                      tabs: <Widget>[
                        Tab(
                          text: "All",
                        ),
                        Tab(
                          text: "Videos",
                        ),
                        Tab(
                          text: "Photos",
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        viewer = viewer ? false : true;
                      });
                    },
                    child: viewer
                        ? const Icon(Icons.calendar_view_day_rounded)
                        : const Icon(Icons.calendar_view_day),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              GridView.count(
                crossAxisCount: viewer ? 2 : 3,
                childAspectRatio: 0.571,
                shrinkWrap: true,
                primary: false,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: <Widget>[
                  GeneralWidgets.storyVideo(size, viewer, showCategory: false),
                  GeneralWidgets.storyVideo(size, viewer, showCategory: false),
                  GeneralWidgets.storyVideo(size, viewer, showCategory: false),
                  GeneralWidgets.storyVideo(size, viewer, showCategory: false),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
