import 'package:fake_story/screens/allCategories.dart';
import 'package:fake_story/screens/category.dart';
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
            const SizedBox(width: 10),
            Theme(
              data: ThemeData(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
              child: IconButton(
                iconSize: 42,
                onPressed: () {},
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network('https://picsum.photos/850',
                      fit: BoxFit.cover),
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: Theme(
                //delete hover effect
                data: ThemeData(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),

                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    controller: _tabController,
                    indicatorWeight: 0,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                          width: 3.0,
                          color: Theme.of(context).colorScheme.secondary),
                      insets: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                    ),
                    labelColor: Colors.black,
                    labelStyle: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w500),
                    unselectedLabelColor: Color(0xff4e4e4e),
                    unselectedLabelStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w300),
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
            aspectRatio: 1,
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
                  return GeneralWidgets.storyVideo(size, true,
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
          child: Row(
            children: [
              Text(
                "See all",
                style: TextStyle(color: Constants.themeColor),
              ),
              const Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Constants.themeColor,
              )
            ],
          ),
        )
      ],
    );
  }

  categoryVideo(String category, {bool all = false}) {
    return GestureDetector(
      onTap: () {
        all
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AllCategories(),
                ))
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryPage(category: category),
                ));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const SizedBox(
                width: 62,
                height: 62,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              category,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GeneralWidgets.crtLabel('Categories'),
                const SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      categoryVideo("All", all: true),
                      categoryVideo("Cars"),
                      categoryVideo("Girls"),
                      categoryVideo("Travel"),
                      categoryVideo("Holiday"),
                      categoryVideo("Sports"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                SizedBox(
                  width: 22,
                  height: 22,
                  child: Image.asset(
                    'asset/icons/lightning.png',
                    color: const Color(0xffd3bc67),
                  ),
                ),
                const SizedBox(width: 7),
                GeneralWidgets.crtLabel('Fresh'),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            categoryWithVideos(size, 'Cars'),
            categoryWithVideos(size, 'Girls'),
            categoryWithVideos(size, 'Travel'),
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
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
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
          child: Row(
            children: [
              Text(
                "See all",
                style: TextStyle(color: Constants.themeColor),
              ),
              const Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Constants.themeColor,
              )
            ],
          ),
        )
      ],
    );
  }

  categoryPhoto(String category, {bool all = false}) {
    return GestureDetector(
      onTap: () {
        all
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AllCategories(),
                ))
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryPage(category: category),
                ));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const SizedBox(
                width: 62,
                height: 62,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              category,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  bool viewer = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GeneralWidgets.crtLabel('Categories'),
                const SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      categoryPhoto("All", all: true),
                      categoryPhoto("Cars"),
                      categoryPhoto("Girls"),
                      categoryPhoto("Travel"),
                      categoryPhoto("Holiday"),
                      categoryPhoto("Sports"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                SizedBox(
                  width: 22,
                  height: 22,
                  child: Image.asset(
                    'asset/icons/lightning.png',
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
                  child: viewer
                      ? const Icon(Icons.calendar_view_day_rounded)
                      : const Icon(Icons.calendar_view_day),
                ),
              ],
            ),
            const Divider(),
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
