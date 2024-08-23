

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jai_poc/features/sendbird_chat/component/widgets.dart';
import 'package:jai_poc/features/sendbird_chat/notifications/push_manager.dart';
import 'package:jai_poc/features/sendbird_chat/utils/user_prefs.dart';
import 'package:jai_poc/main.dart';

import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_widget/sendbird_chat_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final textEditingController = TextEditingController();

  bool? isLoginUserId;

  @override
  void initState() {
    PushManager.removeBadge();

    UserPrefs.getLoginUserId().then((loginUserId) {
      if (loginUserId != null) {
        setState(() => isLoginUserId = true);
        _login(loginUserId);
      } else {
        setState(() => isLoginUserId = false);
      }
    });
    super.initState();
  }

  Future<void> _login(String userId) async {
    final isGranted = await PushManager.requestPermission();
    if (isGranted) {
      await SendbirdChat.connect(userId);
      await UserPrefs.setLoginUserId();
      if (SendbirdChat.getPendingPushToken() != null) {
        await PushManager.registerPushToken();
      }
      await SendbirdChatWidget.cacheNotificationInfo();

      if ((await PushManager.checkPushNotification()) == false) {
        Get.offAndToNamed('/main');
      }
    } else {
      Fluttertoast.showToast(
        msg: 'The permission was not granted regarding push notifications.',
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Widgets.pageTitle('Sendbird Chat Sample for Flutter')),
            const Text('v$sampleVersion', style: TextStyle(fontSize: 12.0)),
          ],
        ),
        actions: const [],
      ),
      body: isLoginUserId != null
          ? isLoginUserId!
              ? Container()
              : _loginBox()
          : Container(),
    );
  }

  Widget _loginBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Widgets.textField(textEditingController, 'User ID'),
          ),
          const SizedBox(width: 8.0),
          ElevatedButton(
            onPressed: () async {
              if (textEditingController.value.text.isEmpty) return;
              _login(textEditingController.value.text);
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
