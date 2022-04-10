import 'package:fake_story/utils/app_constans.dart';
import 'package:fake_story/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final String category;

  const CategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectedTag = 0;

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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
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
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GeneralWidgets.categoryC(widget.category, true),
                    GeneralWidgets.categoryC("Girls"),
                    GeneralWidgets.categoryC("Travel"),
                    GeneralWidgets.categoryC("Holiday"),
                    GeneralWidgets.categoryC("Sports"),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              GeneralWidgets.crtLabel('Popular Tags'),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ListView.builder(
                  itemCount: 8,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    return cTags('Audi', index);
                  },
                ),
              ),
              const SizedBox(height: 30),
              GeneralWidgets.crtLabel('Stories'),
              const SizedBox(height: 15),
              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.571,
                shrinkWrap: true,
                primary: false,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: <Widget>[
                  GeneralWidgets.storyVideo(
                      context, size, null, null, null, true,
                      showCategory: false),
                  GeneralWidgets.storyVideo(
                      context, size, null, null, null, true,
                      showCategory: false),
                  GeneralWidgets.storyVideo(
                      context, size, null, null, null, true,
                      showCategory: false),
                  GeneralWidgets.storyVideo(
                      context, size, null, null, null, true,
                      showCategory: false),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  cTags(String tag, index) {
    return Container(
      margin: const EdgeInsets.only(right: 7),
      child: ChoiceChip(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        label: Text('#' + tag + index.toString()),
        selected: _selectedTag == index,
        selectedColor: Constants.themeColor,
        labelPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        labelStyle: TextStyle(
          color: _selectedTag == index ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
        ),
        pressElevation: 0,
        backgroundColor: Constants.lightTheme.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onSelected: (bool selected) {
          setState(() {
            _selectedTag = selected ? index : 0;
          });
        },
      ),
    );
  }
}
