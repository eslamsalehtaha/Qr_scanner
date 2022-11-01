import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qr_scanner/Properties/second.dart';
import 'package:qr_scanner/qr_scan_generate/creator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class create extends StatefulWidget {
  const create({Key key}) : super(key: key);
  @override
  State<create> createState() => _create();
}

class _create extends State<create> {
  @override
  Widget build(BuildContext context) {
    List<String> widgets=['Url','Text','Message','Email','Phone Number','Wifi','location',
    'EVENT','Contact','ID','Facebook','Whatsapp','Instagram','Viber','Twitter','Paypal','Spotify'];
    return Scaffold(
      appBar:AppBar(title:Text('create'.tr,style:TextStyle(fontSize: 40)) ,centerTitle: true,backgroundColor: HexColor('#1b1464')
      ,actions: [IconButton(onPressed: (){  currentindex.value=5;}, icon:Icon(FontAwesomeIcons.clock,size: 30))    ]) ,
      backgroundColor: HexColor('#1b1464'),
      body:GridView.count(crossAxisCount: 3,
      crossAxisSpacing: 50,
        mainAxisSpacing: 50,
        children:widgets.map((e){
          return GestureDetector(
            onTap: (){Get.to(()=>creator(type: e));},
            child: Container(
              constraints:BoxConstraints(minHeight:MediaQuery.of(context).size.height/2,
              maxWidth:MediaQuery.of(context).size.width/2 ) ,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(30),
                color:Colors.white,
              ), child:Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [icon(e),Text(e.tr, style: TextStyle( fontSize: 25),textAlign: TextAlign.center)]
              )  )
          );
        }).toList(),
      )
    );
  }

}