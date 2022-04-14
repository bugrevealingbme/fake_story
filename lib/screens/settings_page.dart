// ignore_for_file: deprecated_member_use

import 'package:fake_story/api/api_calls/profil_page_calls.dart';
import 'package:fake_story/bloc/getx/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

import '../data/model/usermodel.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

UserModel? userModel;
var isToggle = false;

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    var response = await ProfilCalss.userInformations();

    setState(() {
      userModel = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.put(Controller());
    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text(''),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: InkWell(
                    child: const Text('App Language'),
                    onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context, true))),
                value: Obx(() => Text(controller.language.value))),
            SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: InkWell(
                    child: const Text('Post Language'),
                    onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context, false))),
                value: Obx(() => Text(controller.postLanguage.value))),
            SettingsTile.switchTile(
              onToggle: (value) {},
              initialValue: isToggle,
              enabled: false,
              leading: const Icon(Icons.format_paint),
              title: const Text('Enable dark theme'),
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.contact_page),
              title: InkWell(
                  child: const Text('Contact'),
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context, true))),
              value: const Text('Contact@gmail.com'),
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.contact_page),
              title: InkWell(
                  child: const Text('Other Apps'),
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context, true))),
              value: const Text('Show our apps'),
            ),
            SettingsTile.navigation(
              // ignore: prefer_const_constructors
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              title: InkWell(
                  child: const Text('Exit'),
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context, true))),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _buildPopupDialog(BuildContext context, bool isAppLanguage) {
  final List<String> _languages = [
    'English',
    'Turkish',
  ];
  final Controller controller = Get.put(Controller());
  return AlertDialog(
    title: const Text('Choose Your Language'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 200,
          height: 200,
          child: ListView.builder(
              itemCount: _languages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: TextButton(
                    onPressed: () {
                      switch (_languages[index].toString()) {
                        case "English":
                          isAppLanguage
                              ? controller.changeLanguage("English")
                              : controller.changePostLanguage("en_EN");
                          Navigator.of(context).pop();
                          break;
                        case "Turkish":
                          isAppLanguage
                              ? controller.changeLanguage("Turkish")
                              : controller.changePostLanguage("tr_TR");
                          Navigator.of(context).pop();
                          break;

                        default:
                      }
                    },
                    child: Text(
                      _languages[index],
                    ),
                  ),
                );
              }),
        )
      ],
    ),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}
