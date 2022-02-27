import 'dart:math';

import 'package:fake_story/screens/allCategories.dart';
import 'package:fake_story/screens/category.dart';
import 'package:fake_story/screens/profile.dart';
import 'package:fake_story/screens/search_page.dart';
import 'package:fake_story/utils/app_constans.dart';
import 'package:fake_story/widgets/grid_gallery.dart';
import 'package:fake_story/widgets/navbar.dart';
import 'package:fake_story/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return Scaffold(
        backgroundColor: Constants.primaryColor,
        bottomNavigationBar: CustomBottomNavigationBar(
          onChange: (val) {
            if (val == 2) {
              gallerySheet(context);
            } else if (val == 3) {
              GeneralWidgets.showModalCreateAcc(context);
            }
            _selectedIndex = val;
          },
          defaultSelectedIndex: 0,
        ),
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: const Color(0xffF2F4F5),
          elevation: 0,
          iconTheme: const IconThemeData(color: Color(0xff222222)),
          actions: [
            const SizedBox(width: 20),
            Theme(
              data: ThemeData(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
              child: Center(
                child: Wrap(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: Theme(
                  //delete hover effect
                  data: ThemeData(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
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
                              fontSize: 15, fontWeight: FontWeight.w600),
                          unselectedLabelColor: Colors.grey,
                          unselectedLabelStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                          isScrollable: true,
                          tabs: <Widget>[
                            Tab(
                              text: "Videos",
                            ),
                            Tab(
                              text: "Photos",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Theme(
              data: ThemeData(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
              child: Center(
                child: Wrap(
                  children: [
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SearchPage(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.search,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [HomeVideosView(), HomePhotosView()],
        ));
  }
}

class HomeVideosView extends StatefulWidget {
  const HomeVideosView({Key? key}) : super(key: key);

  @override
  _HomeVideosViewState createState() => _HomeVideosViewState();
}

class _HomeVideosViewState extends State<HomeVideosView>
    with AutomaticKeepAliveClientMixin {
  categoryWithVideos(Size size, String category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          videoCategoryTop(category),
          const SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 1.2,
            child: SizedBox(
              width: double.infinity,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: 10),
                itemCount: 8,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                primary: false,
                itemBuilder: (context, index) {
                  return GeneralWidgets.storyVideo(context, size, true,
                      showCategory: false);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  videoCategoryTop(String category) {
    return Row(
      children: [
        SizedBox(
          width: 36,
          height: 36,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child:
                Image.network('https://picsum.photos/250', fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 7),
        Text(
          category,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryPage(category: category),
                ));
          },
          child: viewAll(),
        )
      ],
    );
  }

  bool viewer = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200, width: 3),
                  )),
                ),
                DefaultTabController(
                  length: 9,
                  child: Theme(
                    //delete hover effect
                    data: ThemeData(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    child: TabBar(
                      labelPadding: const EdgeInsets.only(left: 5, right: 5),
                      indicatorWeight: 0,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                            width: 3.0,
                            color: Theme.of(context).colorScheme.secondary),
                        insets: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                      ),
                      padding: const EdgeInsets.all(0),
                      indicatorPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      labelColor: Colors.black,
                      labelStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                      unselectedLabelColor:
                          const Color.fromARGB(255, 139, 139, 139),
                      unselectedLabelStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                      isScrollable: true,
                      tabs: [
                        Tab(
                          text: "Popular",
                        ),
                        Tab(
                          text: "New",
                        ),
                        Tab(
                          text: "Following",
                        ),
                        Tab(
                          text: "Cars",
                        ),
                        Tab(
                          text: "Girls",
                        ),
                        Tab(
                          text: "Holiday",
                        ),
                        Tab(
                          text: "Travel",
                        ),
                        Tab(
                          text: "Cars",
                        ),
                        Tab(
                          text: "Cars",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 22,
                  height: 22,
                  child: Image.asset(
                    'assets/icons/lightning.png',
                    color: const Color(0xffd3bc67),
                  ),
                ),
                const SizedBox(width: 7),
                GeneralWidgets.crtLabel('Fresh'),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      viewer = viewer ? false : true;
                    });
                  },
                  child: GeneralWidgets.viewerContainer(viewer),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: viewer ? 2 : 3,
                childAspectRatio: 0.571,
                crossAxisSpacing: Constants.gridSpacing,
                mainAxisSpacing: Constants.gridSpacing,
              ),
              shrinkWrap: true,
              primary: false,
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                return GeneralWidgets.storyVideo(context, size, viewer,
                    showCategory: false);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HomePhotosView extends StatefulWidget {
  const HomePhotosView({Key? key}) : super(key: key);

  @override
  _HomePhotosViewState createState() => _HomePhotosViewState();
}

class _HomePhotosViewState extends State<HomePhotosView>
    with AutomaticKeepAliveClientMixin {
  photoBuble(Size size, String category, viewer) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: viewer ? 2 : 3,
        childAspectRatio: 0.571,
        crossAxisSpacing: Constants.gridSpacing,
        mainAxisSpacing: Constants.gridSpacing,
      ),
      shrinkWrap: true,
      primary: false,
      itemCount: 12,
      itemBuilder: (BuildContext context, int index) {
        return GeneralWidgets.storyPhoto(size, viewer, showCategory: true);
      },
    );
  }

  videoCategoryTop(String category) {
    return Row(
      children: [
        SizedBox(
          width: 36,
          height: 36,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child:
                Image.network('https://picsum.photos/250', fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 7),
        Text(
          category,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryPage(category: category),
                ));
          },
          child: viewAll(),
        )
      ],
    );
  }

  bool viewer = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200, width: 3),
                  )),
                ),
                DefaultTabController(
                  length: 7,
                  child: Theme(
                    //delete hover effect
                    data: ThemeData(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    child: TabBar(
                      labelPadding: const EdgeInsets.only(left: 5, right: 5),
                      indicatorWeight: 0,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                            width: 3.0,
                            color: Theme.of(context).colorScheme.secondary),
                        insets: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                      ),
                      padding: const EdgeInsets.all(0),
                      indicatorPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      labelColor: Colors.black,
                      labelStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                      unselectedLabelColor:
                          const Color.fromARGB(255, 139, 139, 139),
                      unselectedLabelStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                      isScrollable: true,
                      tabs: const [
                        Tab(
                          text: "Popular",
                        ),
                        Tab(
                          text: "Cars",
                        ),
                        Tab(
                          text: "Girls",
                        ),
                        Tab(
                          text: "Holiday",
                        ),
                        Tab(
                          text: "Travel",
                        ),
                        Tab(
                          text: "Cars",
                        ),
                        Tab(
                          text: "Cars",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 22,
                  height: 22,
                  child: Image.asset(
                    'assets/icons/lightning.png',
                    color: const Color(0xffd3bc67),
                  ),
                ),
                const SizedBox(width: 7),
                GeneralWidgets.crtLabel('Fresh'),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      viewer = viewer ? false : true;
                    });
                  },
                  child: GeneralWidgets.viewerContainer(viewer),
                ),
              ],
            ),
            const SizedBox(height: 10),
            photoBuble(size, 'Cars', viewer),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Row viewAll() {
  return Row(
    children: [
      Text(
        "View all",
        style: TextStyle(color: Color(0xffb6b4b4), fontWeight: FontWeight.w500),
      ),
      const Icon(
        Icons.keyboard_arrow_right_rounded,
        color: Color(0xffb6b4b4),
      )
    ],
  );
}
