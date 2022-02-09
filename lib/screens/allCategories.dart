import 'package:fake_story/utils/app_constans.dart';
import 'package:fake_story/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
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
              GeneralWidgets.crtLabel('All Categories'),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 1,
                shrinkWrap: true,
                primary: false,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
                children: <Widget>[
                  categoryBig('Cars'),
                  categoryBig('Shopping'),
                  categoryBig('Travel'),
                  categoryBig('Money'),
                  categoryBig('Rich'),
                  categoryBig('News'),
                  categoryBig('News'),
                  categoryBig('News'),
                  categoryBig('News'),
                  categoryBig('News'),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  categoryBig(String category) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wallet_travel,
            size: 32,
          ),
          const SizedBox(height: 3),
          Text(
            category,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          )
        ],
      ),
    );
  }
}
