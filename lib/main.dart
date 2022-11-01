import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qr_scanner/Properties/local.dart';
import 'package:qr_scanner/Properties/second.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  MobileAds.instance.initialize();
  runApp(GetMaterialApp(
          theme:dark.val? ThemeData.dark():ThemeData.light(),
          debugShowCheckedModeBanner: false,
          locale:Locale(language.val),
          fallbackLocale:Locale("en") ,
          translations:Languages() ,home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return   SplashScreen(
        photoSize:MediaQuery.of(context).size.width/3,
        image: Image.asset('asset/logo.png'),
        backgroundColor:Colors.white,
        seconds: 5,
        useLoader: false,
        navigateAfterSeconds:MyHomePage() );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  BannerAd myBanner;
  @override
  void initState() {
    super.initState();
    myBanner= BannerAd(
        adUnitId:ad_link,
        size: AdSize.banner,
        request: AdRequest(),
        listener: BannerAdListener(
          onAdWillDismissScreen: (a){return Container(child:AdWidget(ad:a));},
          onAdImpression: (f){return Container(child:AdWidget(ad:f));},
          onPaidEvent: (d,n,g,m){return Container(child:AdWidget(ad:d));} ,
             onAdFailedToLoad: (a,d){  return Container(child:AdWidget(ad:a));},
            onAdLoaded:(ad){Container(child:Center(child:CircularProgressIndicator())) ;}
        )   );
    myBanner.load();
  }

  @override
  void dispose() {
    myBanner.dispose();
    super.dispose();
  }
@override
  Widget build(BuildContext context) {
  return Scaffold(body:
    Scaffold(
    body: Obx(() =>  list[currentindex.value]),
    floatingActionButton:  FloatingActionButton(
      backgroundColor: HexColor('#1b1464'),
      onPressed: () { currentindex.value=0; },
      child:Icon(Icons.qr_code_2) ,
    ),
    floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: AnimatedBottomNavigationBar(
      backgroundColor:HexColor('#1b1464') ,
      icons: icone,
      inactiveColor:Colors.white ,
      activeColor:Colors.yellow ,
      activeIndex:currentindex.value-1>=0 && currentindex.value-1<=3?currentindex.value-1:0,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      onTap: (index) { currentindex.value = index+1;setState((){});},
      //other params
    )
  ),bottomNavigationBar:    Container(color:HexColor('#1b1464'),
    alignment: Alignment.center,
    child:  AdWidget(ad: myBanner),
    width: myBanner.size.width.toDouble(),
    height: myBanner.size.height.toDouble(),
  )
  );
  }
static String get ad_link
{if(kDebugMode)
return BannerAd.testAdUnitId;
else{
  if (GetPlatform.isAndroid)
    return "ca-app-pub-6147850335148644/7196688223";
  else if(GetPlatform.isIOS)
    return "ca-app-pub-6147850335148644/9986503091";
  else
    throw Exception('unsupported Platform');}
}
}
