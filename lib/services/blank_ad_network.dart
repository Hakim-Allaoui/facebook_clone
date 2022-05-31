import 'package:fake_it/utils/tools.dart';
import 'package:flutter/material.dart';

class BlankAdNetwork {
  static init() {}

  loadInter() {}

  showInter() {}

  loadAndShowInter(BuildContext context) async {
    Tools.waitingDialog(
      context: context,
      process: () async {
        //OnDismissed || onFailed
        Navigator.pop(context);
      },
    );
  }

  loadReward() {}

  showReward() {}

  loadBanner() {}

  Widget getBanner() {
    return Container(
      height: 60.0,
      alignment: Alignment.center,
      child: const SizedBox(),
    );
  }

  static showAdmobConsent() async {}
}
