import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:qr_scanner/Properties/second.dart';
import 'package:share_plus/share_plus.dart';

class setting extends StatefulWidget {
  const setting({Key key}) : super(key: key);
  @override
  State<setting> createState() => _setting();
}

class _setting extends State<setting> {
  List<String> instruct=['Allow access to gallery of photos and videos','Allow media access','Allow access to contacts','Allow access to calendar'
 'Allow access to access to other apps' ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text('setting'.tr,style:TextStyle(fontSize: 40)) ,centerTitle: true,backgroundColor: HexColor('#1b1464')) ,
      body:  Center(child: Container(
    height:MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(top: 100,left: 40,right: 40),
    padding: EdgeInsets.only(top: 43),
    decoration:BoxDecoration(borderRadius: BorderRadius.only(topLeft:Radius.circular(50),
    topRight: Radius.circular(50)),
    color: HexColor('#1b1464')),
      child: ListView(
        children: [ListTile(title: Text('Beep'.tr,style: TextStyle(fontSize: 30)),
        subtitle: Text('6'.tr,style: TextStyle(fontSize: 30)),
        leading: Icon(FontAwesomeIcons.music,color: Colors.white,size: 40), textColor: Colors.white,
        trailing: CustomSwitch(value: ringing.val,activeColor: Colors.green,onChanged: (val){
           if(ringing.val==true)   box.write('ringing', false);
           else box.write('ringing', true);
        },)),
        Divider(color: Colors.white),
          ListTile(title: Text('Vibration'.tr,style: TextStyle(fontSize: 30)),
              leading: Icon(Icons.vibration,color: Colors.white,size: 40), textColor: Colors.white,
              trailing: CustomSwitch(value: vibration.val,activeColor: Colors.green,onChanged: (val){
                if(vibration.val==true)   box.write('vibration', false);
                else box.write('vibration', true);
              },)),
          Divider(color: Colors.white),
          ListTile(title: Text('Dark mode'.tr,style: TextStyle(fontSize: 30)),
              leading: Icon(Icons.dark_mode,color: Colors.white,size: 40), textColor: Colors.white,
              trailing: CustomSwitch(value: dark.val,activeColor: Colors.green,onChanged: (val){
                if(dark.val==true)   {box.write('dark', false);Get.changeTheme(ThemeData.light());}
                else{ box.write('dark', true); Get.changeTheme(ThemeData.dark());}  }  )),
          Divider(color: Colors.white),
          ListTile(title: Text('Change language'.tr,style: TextStyle(fontSize: 30)),
              leading: Icon(Icons.language,color: Colors.white,size: 40), textColor: Colors.white,
           onTap:(){Get.defaultDialog(
             title: 'Choose Language'.tr,
             middleText: '',
             actions: [TextButton(onPressed:(){box.write('language', 'en'); Get.updateLocale(Locale('en'));Get.back();} , child:Text('English')),
               TextButton(onPressed:(){box.write('language', 'ar'); Get.updateLocale(Locale('ar'));Get.back();} , child:Text('العربية'))  ]
           );
          }),
          Divider(color: Colors.white),
          ListTile(title: Text('Rate App'.tr,style: TextStyle(fontSize: 30)),
              leading: Icon(Icons.rate_review,color: Colors.white,size: 40), textColor: Colors.white,
              onTap:(){rate(context);}),
          Divider(color: Colors.white),
          ListTile(title: Text('46'.tr,style: TextStyle(fontSize: 30)),
              leading: Icon(Icons.help,color: Colors.white,size: 40), textColor: Colors.white,
              onTap:(){help();}),
          Divider(color: Colors.white),
          ListTile(title: Text('Share App'.tr,style: TextStyle(fontSize: 30)),
              leading: Icon(Icons.share,color: Colors.white,size: 40), textColor: Colors.white,
              onTap:(){Share.share(Platform.isAndroid?"https://play.google.com/store/apps/details?id=${'com.example.qr_scanner'}":"https://apps.apple.com/app/id${' com.example.qrScanner'}");}),
          Divider(color: Colors.white),
          ListTile(title: Text('Privacy policy',style: TextStyle(fontSize: 30)),
              leading: Icon(Icons.privacy_tip_outlined,color: Colors.white,size: 40), textColor: Colors.white,
              onTap:(){
            Get.defaultDialog(
                title: '',
                middleText: '',
                content: Dialog(
                child:  SingleChildScrollView(child:  Column(children:instruct.map((e) {
              return Text('- ${e.toString()}',style:TextStyle(fontSize: 25),textAlign: TextAlign.center);
            }).toList())   )),actions: [FlatButton(onPressed: (){Get.back(); }, child: Text('Ok',style: TextStyle(color: Colors.white)) ,color: HexColor('#1b1464') )] );
              })
        ]
      )  ))
       );
  }

}