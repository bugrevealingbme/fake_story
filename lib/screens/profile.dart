import 'package:fake_story/utils/app_constans.dart';
import 'package:fake_story/widgets/navbar.dart';
import 'package:fake_story/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  int _selectedTag = 0;
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
        toolbarHeight: 100,
        backgroundColor: const Color(0xffF2F4F5),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff222222)),
        actions: [
          Center(
            child: Wrap(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: 22,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 64,
                        width: 64,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network('https://picsum.photos/850',
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "@bmerdogan",
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Info info  info infoinfo info info info",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "41",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Stories",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "129",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Followers",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "31",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Following",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Follow",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      style: ButtonStyle(
                        //backgroundColor: MaterialStateProperty.all<Color>(color),
                        elevation: MaterialStateProperty.all(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: PopupMenuButton(
                        icon: const Icon(Icons.more_horiz_rounded),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        elevation: 0.721,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: [
                                Text("Report"),
                                const SizedBox(width: 10),
                                const Spacer(),
                                const Icon(Icons.flag_outlined),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Row(
                              children: [
                                Text("Block"),
                                const SizedBox(width: 10),
                                const Spacer(),
                                const Icon(Icons.block_rounded),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200, width: 3),
                    )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Theme(
                        data: ThemeData(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                        ),
                        child: TabBar(
                          labelPadding: const EdgeInsets.only(right: 10),
                          controller: _tabController,
                          indicatorWeight: 0,
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                              width: 3.0,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            insets: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                          ),
                          labelColor: Colors.black,
                          labelStyle: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                          unselectedLabelColor:
                              const Color.fromARGB(255, 139, 139, 139),
                          unselectedLabelStyle: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                          isScrollable: true,
                          tabs: <Widget>[
                            Tab(
                              text: "Liked",
                            ),
                            Tab(
                              text: "Saved",
                            ),
                            Tab(
                              text: "Uploads",
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
