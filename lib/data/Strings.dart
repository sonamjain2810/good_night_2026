import 'dart:io';

import 'package:launch_review/launch_review.dart';

class Strings {
  static var iosFBBannerId;

  static var iosFBInterstitialId;

  Strings._();

  static const accountName = "GJOneStudio";

  static const accountEmail = "gj1studio@gmail.com";

  static const appName = "Good Night Gif Image Quote Sms";

  static const mailAppName ="Good%20Night%20Gifs%20Image%20Quote%20Sms%20";

  static const iosAppId = "1527002426";

  static const iosAdmobAppId = "ca-app-pub-8179797674906935~3356616536";

  static const iosAdmobBannerId = "ca-app-pub-8179797674906935/4478126512";
  
  static const iosAdmobInterstitialId = "ca-app-pub-8179797674906935/9931980783";

  static const iosAdmobNativeId = "ca-app-pub-8179797674906935/2053490767";

  static const iosAdmobRewardedId = "ca-app-pub-8179797674906935/6397712840";


  static const androidAdmobAppId = "ca-app-pub-8179797674906935~3897889625";

  static const androidAdmobBannerId = "ca-app-pub-8179797674906935/6332481270";
  
  static const androidAdmobInterstitialId = "ca-app-pub-8179797674906935/3706317930";

  static const androidAdmobNativeId = "ca-app-pub-8179797674906935/1080154590";

  static const androidAdmobRewardedId = "ca-app-pub-8179797674906935/2393236260";


  static const testDevice = 'a835aea0489176f272e2d174b8d921ca';


  static String appUrl = Platform.isAndroid
      ? "https://play.google.com/store/apps/details?id=com.rrj_psj.good_morning_sms"
      : "https://apps.apple.com/us/app/-/id${Strings.iosAppId}";

      

  static String accountUrl = Platform.isAndroid
      ? "https://play.google.com/store/apps/developer?id=Festival+Messages+SMS"
      : "https://apps.apple.com/us/developer/sonam-jain/id1440118616";

  static const String mailContent ='mailto:sonamjain2810@yahoo.com?subject=feedback%20from%20${Strings.mailAppName}&body=Your%20Apps%20Rocks!!';

  static String shareAppText =
      "Hey I have found this amazing app for you.\nHave a look on\n${Strings.appName}\n${Strings.appUrl}";

static void RateNReview() {
  LaunchReview.launch(iOSAppId: Strings.iosAppId);
}

}




