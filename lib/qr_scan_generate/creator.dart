import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/DB/qr_code.dart';
import 'package:qr_scanner/Properties/second.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toast/toast.dart';

class creator extends StatefulWidget {
  final String type;
  const creator({@required this.type,Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
  return _creator();
  }
}

class _creator extends State<creator> {
  final GlobalKey<FormState> k=GlobalKey<FormState>();
  @override
  void dispose() {
    after_result(widget.type);
    super.dispose();}
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        appBar:AppBar(title:Text('creator'.tr) ,centerTitle: true,backgroundColor: HexColor('#1b1464'),
        actions: [TextButton(onPressed:(){
          if(k.currentState.validate())
     Get.to(()=>result(page:'creator',type:widget.type));
        }, child: Text('Create',style: TextStyle(color: Colors.white)))]) ,
    backgroundColor: HexColor('#1b1464'),
      body:Form(key: k,child:SingleChildScrollView(child: Column(
        children: [Center(
            child: Container(margin: EdgeInsets.all(5), height:100 ,width: 100,
                decoration: BoxDecoration( color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(50))
                , child:icon(widget.type ))  ),
          Text(widget.type.tr,style: TextStyle(color: Colors.white,fontSize: 30)),
          Divider(height: 35),
          Column(
              mainAxisAlignment:MainAxisAlignment.spaceAround ,
              children:creators(widget.type).toList())]
      )
    )));  }}

class result extends StatefulWidget {
 final String page, type;
   result({@required String this.page,@required String this.type,Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _result();
  }
}
class _result extends State<result> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(body:Container(
       height:MediaQuery.of(context).size.height,
       width:MediaQuery.of(context).size.width ,
       child:ListView(
           children: [ Align(alignment: Alignment.topLeft,child:
             Padding(padding: EdgeInsets.all(10),child:IconButton(icon:Icon(Icons.close,size: 50),onPressed:(){Get.back();}   ))  ),
             Center(child: Container(margin: EdgeInsets.all(5), height:100 ,width: 100,
                 decoration: BoxDecoration( color: Colors.grey.shade100,
                     borderRadius: BorderRadius.circular(50))
                 , child:icon(widget.type ))  ),
             Center(child: Text(widget.type,style: TextStyle(fontSize: 25))),
          Container(constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/2,
          maxWidth: MediaQuery.of(context).size.width),
            alignment:  Alignment.topCenter,
                 child:  QrImage(
                     data:final_result(widget.type),
                     version: QrVersions.auto,
                     size:MediaQuery.of(context).size.height/2 ,
                     gapless: true,
                     errorStateBuilder: (cxt, err) {
                       return Container(
                           child: Center(  child: Text(
                               '10'.tr,
                               textAlign: TextAlign.center) ));
                     }   )),
             Divider(color: Colors.transparent,height: 10),
             Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   FlatButton(onPressed: () async {
                     Share.share(final_result(widget.type));},
                       child: Text('Share'.tr,style: TextStyle(color: Colors.white)),color:HexColor('#1b1464'),
                       height:100,minWidth:( MediaQuery.of(context).size.width/3)+20,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(40) )),
                   FlatButton(onPressed: () async {
                     if(widget.page=='creator'){
                       QR cB=QR({'content':"${final_result(widget.type)}",'date':DateTime.now().toString(),'type':type,'favourite':false.toString(),'creator':'created'});
                       await db.insertDB(cB);}
                     save(final_result(widget.type),widget.type);
                     Toast.show('34'.tr, gravity: Toast.bottom, duration: Toast.lengthLong);
                   }, child: Text('save'.tr,style: TextStyle(color: Colors.white)),color:HexColor('#1b1464'),
                       height:100,minWidth: (MediaQuery.of(context).size.width/3)+20,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(40) ))
                 ])
           ]   )  ));
  }
}