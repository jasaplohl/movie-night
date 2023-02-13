import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsPermission = false;

  @override
  void initState() {
    setPermissions();
    super.initState();
  }

  Future<void>setPermissions() async {
    final PermissionStatus notifications = await Permission.notification.status;
    if(notifications.isGranted) {
      setState(() {
        notificationsPermission = true;
      });
    } else {
      setState(() {
        notificationsPermission = false;
      });
    }
  }

  Future<void> onNotificationsValueChanged(bool status) async {
    if(status) {
      final PermissionStatus res = await Permission.notification.request();
      if(res == PermissionStatus.granted) {
        setState(() {
          notificationsPermission = true;
        });
        return;
      }
    }
    openAppSettings().then((value) {
      setPermissions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"),),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Enable notifications", style: Theme.of(context).textTheme.labelLarge),
                Switch(
                  value: notificationsPermission,
                  onChanged: onNotificationsValueChanged,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}