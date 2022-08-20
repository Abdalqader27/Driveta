// Created By Abd Alqader Alnajjar
// 2022 / 1 /7

import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:network/network.dart';
import 'package:design/design.dart';

void showPermissionToast(String text) {
  BotToast.showText(
    contentColor: kWhite,
    textStyle: const TextStyle(color: kBlack, fontWeight: FontWeight.w600),
    text: 'Please make sure you allow'.tr() + '$text' 'on your app'.tr(),
  );
}

void showErrorToast(String text, [Color? color]) {
  BotToast.showText(
    contentColor: color ?? kRed1,
    duration: const Duration(seconds: 15),
    textStyle: const TextStyle(color: kWhite, fontWeight: FontWeight.w600),
    text: text,
  );
}

void showToast(String text) {
  BotToast.closeAllLoading();
  BotToast.showText(
    duration: const Duration(seconds: 3),
    text: text,
  );
}
