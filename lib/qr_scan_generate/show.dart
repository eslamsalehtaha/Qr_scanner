import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qr_scanner/DB/qr_code.dart';
import 'package:qr_scanner/Properties/second.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toast/toast.dart';

class show extends StatefulWidget {
  final QR code;
  final Map<String,dynamic> maps;
  const show({@required this.code,this.maps,Key key}) : super(key: key);
  @override
  State<show> createState() => _show();
}

class _show extends State<show> {
  @override
  Widget build(BuildContext context) {
    DateTime date=DateTime.parse(widget.code.date);
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: HexColor('#1b1464')),
      backgroundColor: HexColor('#1b1464'),
      body: Stack(
          children:[
        Center(child: Container(
          height: (3*MediaQuery.of(context).size.height)/4,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.only(top: 43),
          decoration:BoxDecoration(borderRadius: BorderRadius.only(topLeft:Radius.circular(50),
          bottomRight: Radius.circular(50)),
            color: Colors.white) ,
          child:
           Column(
             verticalDirection: VerticalDirection.down,
               children: [
                Text(widget.code.type,style:TextStyle(color: Colors.black,fontSize: 30)),
                Divider(color:Colors.transparent,height: 60),
          Container(
            alignment: Alignment.center,
            margin:EdgeInsets.all(5) ,
              height: 200,
              child: ListView(
                    children: widget.maps.keys.map((e) {
                      return Text('${e.tr}: ${widget.maps[e]}',style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center);
                }).toList())),
                Divider(color:Colors.transparent,height: 60),
                FlatButton(onPressed: (){Clipboard.setData(ClipboardData(text:widget.maps.toString() ));
                Toast.show('15'.tr, gravity: Toast.bottom, duration: Toast.lengthLong);},height: 50, child: Row( mainAxisSize:MainAxisSize.min ,
                    children:[Icon(Icons.copy,color:Colors.white),Text('\b'+'Copy'.tr,style:TextStyle(color: Colors.white,fontSize: 25))]),
                    color:  HexColor('#1b1464'),shape:OutlineInputBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(50),
                        bottomRight: Radius.circular(50)) ),minWidth:MediaQuery.of(context).size.width/2 ),
                Divider(color:Colors.transparent,height: 30),
                FlatButton(onPressed: (){
                  Share.share(widget.maps.toString().replaceAll(RegExp('{|}'),''));},height: 50, child: Row( mainAxisSize:MainAxisSize.min ,
                    children:[Icon(Icons.share,color:Colors.white),Text('\b'+'share'.tr,style:TextStyle(color: Colors.white,fontSize: 25))]),
                    color:  HexColor('#1b1464'),shape:OutlineInputBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(50),
                        bottomRight: Radius.circular(50)) ),minWidth:MediaQuery.of(context).size.width/2 ),
                Divider(color:Colors.transparent,height: 30),
            Wrap(verticalDirection: VerticalDirection.down,
                    direction: Axis.horizontal,
                    children: custom_widget(c: context, type:widget.code.type,mapes:widget.maps)),
                Spacer(),
                Align(alignment: Alignment.bottomCenter,child: Text(date.year.toString()+'/'+date.month.toString()+'/'+date.day.toString(),style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold,fontStyle: FontStyle.normal  ),),
                )
              ])   ) ) ,  Positioned(
                top: 60,
                left:( MediaQuery.of(context).size.width/2)-54,
                child: Container(margin: EdgeInsets.all(5), height:100 ,width: 100,
                    decoration: BoxDecoration( color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(50))
                    , child:icon(widget.code.type ))  ) ])
    );
  }
}