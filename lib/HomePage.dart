import 'dart:async';
import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/services.dart';
import 'package:good_night_2026/utils/pass_data_between_screens.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'AdManager/ad_helper.dart';
import 'AdManager/ad_manager.dart';
import 'Enums/project_routes_enum.dart';
import 'Singleton/project_manager.dart';
import 'data/Images.dart';
import 'data/Status.dart';
import 'data/Strings.dart';
import 'widgets/AppStoreAppsItemWidget1.dart';
import 'widgets/CustomBannerWidget2.dart';
import 'widgets/CustomGradientImageTextWidget.dart';
import 'widgets/DesignerContainer.dart';
import 'widgets/ImageTextHorizontalWidget2.dart';
import 'widgets/QuotesDesign3.dart';
import 'package:flutter/material.dart';
import 'data/Gifs.dart';
import 'widgets/CustomFullCard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'utils/SizeConfig.dart';
import 'MyDrawer.dart';
import 'widgets/CustomTextOnlyWidget.dart';

// Height = 8.96
// Width = 4.14

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    implements ProjectListener, AdListener {
  String _authStatus = 'Unknown';

  BannerAd? _bannerAd;
  ProjectManager projectManager = ProjectManager.instance;
  AdManager adManager = AdManager.instance;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback(
      (_) => initPlugin(),
    );

    projectManager.listener = this;

    adManager.adListener = this;

    projectManager.startApp();

    adManager.loadAdsInAdManager();
  }

  BannerAd loadBannerAd() {
    return BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    debugPrint("Home Page: Dispose Called");
    projectManager.listener = null;
    adManager.adListener = null;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    final TrackingStatus status =
        await AppTrackingTransparency.trackingAuthorizationStatus;
    setState(() => _authStatus = '$status');
    // If the system can show an authorization request dialog
    if (status == TrackingStatus.notDetermined) {
      // Show a custom explainer dialog before the system dialog
      await showCustomTrackingDialog(context);
      // Wait for dialog popping animation
      await Future.delayed(const Duration(milliseconds: 200));
      // Request system's tracking authorization dialog
      final TrackingStatus status =
          await AppTrackingTransparency.requestTrackingAuthorization();
      setState(() => _authStatus = '$status');
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    debugPrint("UUID: $uuid");
  }

  Future<void> showCustomTrackingDialog(
    BuildContext context,
  ) async => await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const Text('Dear User'),
      content: Text(
        'We care about your privacy and data security. We keep this app free by showing ads. '
        'Can we continue to use your data to tailor ads for you?\n\nYou can change your choice anytime in the app settings. '
        'Our partners will collect data and use a unique identifier on your device to show you ads.',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Continue', style: Theme.of(context).textTheme.bodySmall),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: Theme.of(context).appBarTheme.toolbarTextStyle,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.width(8)),
                    child: Center(
                      child: Text(
                        "Choose Your Wishes Type",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),

                  Divider(),

                  // Status Start
                  DesignerContainer(
                    isLeft: true,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text(
                            "Best Good Night 'Status'",
                            style: Theme.of(context).textTheme.headlineSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              child: Row(
                                children: [
                                  CustomGradientImageTextWidget(
                                    size: size,
                                    title: "Status for WhatsApp",
                                    bodyText: Status.statusData[14],
                                    bottomText: "Read",
                                    color1: Colors.pinkAccent,
                                    color2: Colors.pink,
                                    isleft: false,
                                    imageUrl: Gifs.gifsPath[20],
                                  ),
                                  CustomGradientImageTextWidget(
                                    size: size,
                                    title: "Status for FB",
                                    bodyText: Status.statusData[9],
                                    bottomText: "Read",
                                    color1: Colors.indigoAccent,
                                    color2: Colors.indigo,
                                    isleft: false,
                                    imageUrl: Gifs.gifsPath[31],
                                  ),
                                  CustomGradientImageTextWidget(
                                    size: size,
                                    title: "Best Status",
                                    bodyText: Status.statusData[3],
                                    bottomText: "Read",
                                    color1: Colors.deepPurple,
                                    color2: Colors.deepPurpleAccent,
                                    isleft: false,
                                    imageUrl: Gifs.gifsPath[33],
                                  ),
                                ],
                              ),
                              onTap: () {
                                debugPrint("Status Clicked");
                                ProjectManager.instance.clickOnButton(
                                  ProjectRoutes.statusList.toString(),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Status End
                  Divider(),
                  // Messages Start
                  Column(
                    children: [
                      DesignerContainer(
                        isLeft: true,
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Center(
                            child: Text(
                              "Select Wishes & Messages Language:",
                              style: Theme.of(context).textTheme.headlineSmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8.0)),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: (() {
                                  debugPrint("English Message Clicked");
                                  ProjectManager.instance.clickOnButton(
                                    ProjectRoutes.messagesList.toString(),
                                    PassDataBetweenScreens("1", "1"),
                                  );
                                }),
                                child: CustomTextOnlyWidget(
                                  size: size,
                                  text:
                                      "No need to be upset or feel lonely tonight. Feel the calmness of this night with all your heart. Relax and have a tight sleep. Good night.",
                                  color: Colors.amberAccent,
                                  language: "English",
                                ),
                              ),
                              InkWell(
                                child: CustomTextOnlyWidget(
                                  size: size,

                                  text:
                                      "ऐसा लगता है कुछ होने जा रहा है\nकोई मीठे सपनो में खोने जा रहा है\nधीमी कर दे अपनी रोशनी ऐ चाँद\nमेरा कोई अपना सोने जा रहा है\nगुड नाईट\nशुभ रात्रि!",
                                  color: Colors.amberAccent,
                                  language: "हिन्दी",
                                ),
                                onTap: () {
                                  debugPrint("Hindi Clicked");
                                  ProjectManager.instance.clickOnButton(
                                    ProjectRoutes.messagesList.toString(),
                                    PassDataBetweenScreens("4", "1"),
                                  );
                                },
                              ),
                              InkWell(
                                child: CustomTextOnlyWidget(
                                  size: size,
                                  text:
                                      "Ich sende dir eine Wolke, die dich zudeckt, einen Stern,der Dir die Nacht erhellt, den Mond der Dich bewacht süsse Träume und Gute Nacht!",
                                  color: Colors.amberAccent,
                                  
                                  language: "Deutsche",
                                ),
                                onTap: () {
                                  debugPrint("German Clicked");
                                  ProjectManager.instance.clickOnButton(
                                    ProjectRoutes.messagesList.toString(),
                                    PassDataBetweenScreens("3", "1"),
                                  );
                                },
                              ),
                              InkWell(
                                child: CustomTextOnlyWidget(
                                  size: size,
                                  text:
                                      "Quand la nuit se pose, quand les choses se reposent, quand les paupières se closent, comme une rose qui se replie, j’aime ce moment où je te dis avec amour BONNE NUIT",
                                  color: Colors.amberAccent,
                                  language: "français",
                                ),
                                onTap: () {
                                  debugPrint("français Clicked");
                                  ProjectManager.instance.clickOnButton(
                                    ProjectRoutes.messagesList.toString(),
                                    PassDataBetweenScreens("2", "2"),
                                  );
                                },
                              ),
                              InkWell(
                                child: CustomTextOnlyWidget(
                                  size: size,

                                  text:
                                      "I miracoli sono dappertutto…. i miracoli sono altruismo, affetto, amore… i miracoli sono piccole gioie di ogni giorno, quelle chiuse nei gesti quotidiani… Chiudi gli occhi e pensa che anche tu sei un meraviglioso Miracolo! Buonanotte",
                                  color: Colors.amberAccent,
                                  language: "Italiano",
                                ),
                                onTap: () {
                                  debugPrint("Italian Clicked");
                                  ProjectManager.instance.clickOnButton(
                                    ProjectRoutes.messagesList.toString(),
                                    PassDataBetweenScreens("5", "5"),
                                  );
                                },
                              ),
                              InkWell(
                                child: CustomTextOnlyWidget(
                                  size: size,
                                  text:
                                      "Que Deus dê descanso para o teu corpo e alívio para a tua alma, para que você possa enfrentar o amanhã com um sorriso no rosto.\n Boa noite!",
                                  color: Colors.amberAccent,
                                  language: "Português",
                                ),
                                onTap: () {
                                  debugPrint("Portuguese Clicked");
                                  ProjectManager.instance.clickOnButton(
                                    ProjectRoutes.messagesList.toString(),
                                    PassDataBetweenScreens("6", "6"),
                                  );
                                },
                              ),
                              InkWell(
                                child: CustomTextOnlyWidget(
                                  size: size,

                                  text:
                                      "Recuerda que los sueños siempre se hacen realidad, si lo dudas, mírate eres mi sueño hecho realidad. Que descanses y buenas noches amor.",
                                  color: Colors.amberAccent,
                                  language: "Español",
                                ),
                                onTap: () {
                                  debugPrint("For All Clicked");
                                  ProjectManager.instance.clickOnButton(
                                    ProjectRoutes.messagesList.toString(),
                                    PassDataBetweenScreens("7", "7"),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Messages End
                  Divider(),

                  Divider(),
                  //Gifs Start
                  DesignerContainer(
                    isLeft: false,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text(
                            "Explore Gifs",
                            style: Theme.of(context).textTheme.headlineSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                ImageTextHorizontalWidget2(
                                  context: context,
                                  imageUrl: Gifs.gifsPath[14],
                                  title: "Good Night Wishes\nGifs Collection",
                                  subTitle: "50+ Images",
                                ),
                              ],
                            ),
                            onTap: () {
                              debugPrint("Gifs Clicked");
                              ProjectManager.instance.clickOnButton(
                                ProjectRoutes.gifsList.toString(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Gifs End
                  Divider(),

                  // Quotes start
                  Column(
                    children: [
                      DesignerContainer(
                        isLeft: true,
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Good Night Quotes",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              QuotesDesign3(
                                size: size,
                                color: Colors.cyan,
                                bodyText:
                                    "“Good night, good night! Parting is such sweet sorrow that, I shall say good night till it be morrow.”",
                                footerText: " ~ William Shakespeare",
                                curvedBorder: true,
                                ontap: () {
                                  debugPrint("Quotes Clicked");
                                  ProjectManager.instance.clickOnButton(
                                    ProjectRoutes.quotesList.toString(),
                                  );
                                },
                                borderColor: Colors.black,
                              ),
                              SizedBox(width: SizeConfig.width(8)),
                              QuotesDesign3(
                                size: size,
                                color: Colors.purpleAccent,
                                bodyText:
                                    "“May I kiss you then? On this miserable paper? I might as well open the window and kiss the night air.” – Franz Kafka",
                                footerText: " ~ Franz Kafka",
                                curvedBorder: true,
                                ontap: () {
                                  debugPrint("Quotes Clicked");
                                  ProjectManager.instance.clickOnButton(
                                    ProjectRoutes.quotesList.toString(),
                                  );
                                },
                                borderColor: Colors.black,
                              ),
                              SizedBox(width: SizeConfig.width(8)),
                              QuotesDesign3(
                                size: size,
                                color: Colors.amberAccent,
                                bodyText:
                                    "“Night is always darker before the dawn and life is the same, the hard times will pass, every thing will get better and sun will shine brighter then ever.”",
                                footerText: " ~ Ernest Hemingway",
                                curvedBorder: true,
                                ontap: () {
                                  debugPrint("Quotes Clicked");
                                  ProjectManager.instance.clickOnButton(
                                    ProjectRoutes.quotesList.toString(),
                                  );
                                },
                                borderColor: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Quotes end
                  Divider(),

                  //Image Start
                  Column(
                    children: [
                      DesignerContainer(
                        isLeft: true,
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Explore Images",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ImageTextHorizontalWidget2(
                                context: context,
                                imageUrl: Images.imagesPath[8],
                                title: "Good Night Wishes\nImages Collection",
                                subTitle: "50+ Images",
                              ),
                            ],
                          ),
                          onTap: () {
                            debugPrint("Images Clicked");
                            ProjectManager.instance.clickOnButton(
                              ProjectRoutes.imagesList.toString(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  // Image End
                  Divider(),

                  Divider(),
                  // Shayari Start
                  DesignerContainer(
                    isLeft: false,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text(
                            "Good Night Shayari",
                            style: Theme.of(context).textTheme.headlineSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: CustomBannerWidget2(
                            size: size,
                            imagePath: Images.imagesPath[1],
                            topText: "Best Latest Shayari",
                            middleText:
                                "हर रात आपकी चारों तरफ उजाला हो,\nऔर हर रात आपसे कोई गुड नाईट कहने वाला हो।",
                            bottomText: "in Hindi Font",
                            buttonText: "Explore Now",

                            ontap: () {
                              debugPrint("Shayari Clicked");
                              ProjectManager.instance.clickOnButton(
                                ProjectRoutes.shayariList.toString(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Shayari End
                  Divider(),

                  // Wish Creator Start
                  Column(
                    children: [
                      DesignerContainer(
                        isLeft: false,
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Create Good Night Meme & e-Card ",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: CustomBannerWidget2(
                          size: MediaQuery.of(context).size,
                          imagePath: Gifs.gifsPath[7],
                          buttonText: "Try It",
                          topText: "Send Good Night Card",
                          middleText: "Create It Now.",
                          bottomText: "Share It With Your Friends",
                          ontap: () {
                            debugPrint("meme Clicked");
                            ProjectManager.instance.clickOnButton(
                              ProjectRoutes.memeGenerator.toString(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  // Wish Creator End
                  Divider(),

                  DesignerContainer(
                    isLeft: false,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text(
                            "Play Game \"Sell Rakhi\"",
                            style: Theme.of(context).textTheme.headlineSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        InkWell(
                          child: CustomFullCard(
                            size: MediaQuery.of(context).size,
                            imageUrl: "assets/rakhi_game.jpeg",
                            onTap: () {
                              if (Platform.isAndroid) {
                                // Android-specific code
                                debugPrint("More Button Clicked");
                                launch(
                                  "https://play.google.com/store/apps/developer?id=Festival+Messages+SMS",
                                );
                              } else if (Platform.isIOS) {
                                // iOS-specific code
                                debugPrint("More Button Clicked");
                                launch(
                                  "https://apps.apple.com/us/app/-/id1434054710",
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(),

                  Padding(
                    padding: EdgeInsets.all(SizeConfig.width(8)),
                    child: Text(
                      "Apps From Developer",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: Row(
                        children: <Widget>[
                          //Column1
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is1-ssl.mzstatic.com/image/thumb/Purple117/v4/8f/e7/b5/8fe7b5bc-03eb-808c-2b9e-fc2c12112a45/mzl.jivuavtz.png/292x0w.jpg",
                                appTitle: "Good Morning Images & Messages",
                                appUrl:
                                    "https://apps.apple.com/us/app/good-morning-images-messages-to-wish-greet-gm/id1232993917",
                              ),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/44/e0/fd/44e0fdb5-667b-5468-7b2f-53638cba539e/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/292x0w.jpg",
                                appTitle: "Birthday Status Wishes Quotes",
                                appUrl:
                                    "https://apps.apple.com/us/app/birthday-status-wishes-quotes/id1522542709",
                              ),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/1a/58/a4/1a58a480-a0ae-1940-2cf3-38524430f66b/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg",
                                appTitle: "Astrology Horoscope Lal Kitab",
                                appUrl:
                                    "https://apps.apple.com/us/app/astrology-horoscope-lal-kitab/id1448343526",
                              ),
                            ],
                          ),
                          SizedBox(width: SizeConfig.width(3)),
                          //Column2
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is2-ssl.mzstatic.com/image/thumb/Purple124/v4/e9/96/64/e99664d3-1083-5fac-6a0c-61718ee209fd/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg",
                                appTitle: "Weight Loss My Diet Coach Tips",
                                appUrl:
                                    "https://apps.apple.com/us/app/weight-loss-my-diet-coach-tips/id1448343218",
                              ),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is2-ssl.mzstatic.com/image/thumb/Purple127/v4/5f/7c/45/5f7c45c7-fb75-ea39-feaa-a698b0e4b09e/pr_source.jpg/292x0w.jpg",
                                appTitle: "English Speaking Course Grammar",
                                appUrl:
                                    "https://apps.apple.com/us/app/english-speaking-course-learn-grammar-vocabulary/id1233093288",
                              ),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is4-ssl.mzstatic.com/image/thumb/Purple128/v4/50/ad/82/50ad82d9-0d82-5007-fcdd-cc47c439bfd0/AppIcon-0-1x_U007emarketing-0-85-220-10.png/292x0w.jpg",
                                appTitle: "English Hindi Language Diction",
                                appUrl:
                                    "https://apps.apple.com/us/app/english-hindi-language-diction/id1441243874",
                              ),
                            ],
                          ),
                          SizedBox(width: SizeConfig.width(3)),

                          //Column3
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is1-ssl.mzstatic.com/image/thumb/Purple118/v4/79/1e/61/791e61de-500c-6c97-3947-8abbc6b887e3/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg",
                                appTitle: "Bangladesh Passport Visa Biman",
                                appUrl:
                                    "https://apps.apple.com/us/app/bangladesh-passport-visa-biman/id1443074171",
                              ),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/dd/34/c3/dd34c3e8-5c9f-51aa-a3eb-3a203f5fd49b/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-10.png/292x0w.jpg",
                                appTitle: "Complete Spoken English Course",
                                appUrl:
                                    "https://apps.apple.com/us/app/complete-spoken-english-course/id1440118617",
                              ),
                            ],
                          ),
                          SizedBox(width: SizeConfig.width(3)),

                          //Column4
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is4-ssl.mzstatic.com/image/thumb/Purple128/v4/bd/00/ee/bd00ee3b-43af-6b07-62a6-28c68373a8b5/AppIcon-1x_U007emarketing-85-220-0-9.png/292x0w.jpg",
                                appTitle: "Happy Anniversary Greeting SMS",
                                appUrl:
                                    "https://apps.apple.com/us/app/happy-anniversary-greeting-sms/id1435157874",
                              ),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is1-ssl.mzstatic.com/image/thumb/Purple114/v4/0f/d6/f4/0fd6f410-9664-94a5-123f-38d787bf28c6/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/292x0w.jpg",
                                appTitle: "Rakshabandhan Images Greetings",
                                appUrl:
                                    "https://apps.apple.com/us/app/rakshabandhan-images-greetings/id1523619788",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }

  @override
  void moveToScreen(String s, [PassDataBetweenScreens? object]) {
    Navigator.of(context).pushNamed(s, arguments: object);
  }

  @override
  void moveToScreenAfterAd(String s, [PassDataBetweenScreens? object]) {
    Navigator.of(context).pushNamed(s, arguments: object);
  }

  @override
  void showAd(String s, [PassDataBetweenScreens? object]) {
    AdManager.instance.showInterstitialAd(s, object);
  }
}

class TopNBottomBackground extends StatelessWidget {
  const TopNBottomBackground({
    Key? key,
    required this.size,
    this.color,
    this.isTop,
  }) : super(key: key);

  final Size? size;
  final Color? color;
  final bool? isTop;
  @override
  Widget build(BuildContext context) {
    return isTop!
        ? Positioned(
            top: 0,
            left: 0,
            width: size!.width,
            height: size!.height * 0.15,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(
                  SizeConfig.height(size!.height / 2),
                ),
                bottomLeft: Radius.circular(
                  SizeConfig.height(size!.height / 2),
                ),
              ),
              child: ColoredBox(color: color!),
            ),
          )
        : Positioned(
            left: 0,
            bottom: 0,
            width: size!.width,
            height: size!.height * 0.15,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(SizeConfig.height(size!.height / 2)),
                topLeft: Radius.circular(SizeConfig.height(size!.height / 2)),
              ),
              child: ColoredBox(color: color!),
            ),
          );
  }
}
