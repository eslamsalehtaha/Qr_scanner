import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qr_scanner/DB/qr_code.dart';
import 'package:qr_scanner/qr_scan_generate/show.dart';
import '../Properties/second.dart';

class history extends StatefulWidget {

  const history({Key key}) : super(key: key);
  @override
  State<history> createState() => _history();
}

class _history extends State<history>  with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    centerTitle: true,
    backgroundColor: HexColor('#1b1464'),
    title: Text('history'.tr,style:TextStyle(fontSize: 40)),
  actions: [
    IconButton(onPressed: (){
      Get.defaultDialog(
        title:'' ,
        content:Text('5'.tr),
        actions:[TextButton(onPressed:(){Get.back();}, child:Text('Cancel'.tr,
        style:TextStyle(color:Colors.red ))),
          TextButton(onPressed:(){Get.back();
            if(type!='All')
            db.delete_all(type:type.value,creator: 'scanned');
            else
              db.delete_all(creator: 'scanned');
            setState((){});}, child:Text('Confirm'.tr))]
         ); }, icon:Icon(Icons.delete)) ,
    PopupMenuButton(itemBuilder: (context){
      return order.map((e){
        return PopupMenuItem(child: Text(e.tr),onTap:(){
          if(e=='name')
            orders.value='content';
          else
          orders.value=e;
          setState((){});});
      }).toList();
    })]),
  body: Column(children:[
    Container(
      width:MediaQuery.of(context).size.width ,
        height:MediaQuery.of(context).size.height/18,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children:types.map((e) {
        return Padding(padding: EdgeInsets.all(5),child:
          FlatButton(onPressed:(){
          type.value=e;
          setState(() {});
        }, child:Text(e.tr,style: TextStyle(color:Colors.white ),),color:HexColor('#1b1464') ,shape:OutlineInputBorder(borderRadius:BorderRadius.circular(25) ) ));
      }).toList())),
        Expanded(child: FutureBuilder(
    future: db.query(d: orders.value,type: type.value),
    builder: (context,snapshot)
    {if(!snapshot.hasData )
      return Center(child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[Icon(Icons.hourglass_empty,color:Colors.grey),Text('no Data Found')]));
    else if(snapshot.connectionState==ConnectionState.waiting)
      return Center(child:CircularProgressIndicator(color:Colors.green));
   else if(snapshot.hasError)
      return Center(child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[Icon(Icons.error_outline,color:Colors.red),Text('Something went Error',style: TextStyle(color:Colors.red ))]));
  List<dynamic> h=snapshot.data as  List<dynamic>;

  return SingleChildScrollView(child:
    Column(
        children:h.map((e){
      QR a = QR.fromMap(e);
      DateTime date=DateTime.parse(a.date);
      Map<String, dynamic> map={};
    try {
      map=json.decode(a.content);
    }catch(e)  {
     map= Contact_event(a.content,a.type) ;
    }
      finally{
    return ListTile(
      onTap:(){ Get.to(()=>show(code:a,maps:map));} ,
      minVerticalPadding:10 ,
        leading:icon(a.type),
        onLongPress:(){ Get.defaultDialog(
            title:'8'.tr,
            content:Text(''),
            actions:[TextButton(onPressed:(){Get.back();}, child:Text('Cancel',
                style:TextStyle(color:Colors.red ))),
              TextButton(onPressed:(){Get.back();db.delete(a.id);setState((){});}, child:Text('Confirm'))]
        );} , shape: RoundedRectangleBorder(
      side: BorderSide.none
        // (color: Colors.black, width:1)
    ),trailing:  PopupMenuButton(itemBuilder: (context){
      return order1.map((e){
        return PopupMenuItem(
            child: ListTile(title:Text (e.tr),trailing:icons.elementAt(order1.indexOf(e))),onTap:(){
          if(e=='delete')
            db.delete(a.id);
          else
            db.updates(QR({'id':a.id,'content':a.content,'date':a.date,'type':a.type,'favourite':true.toString(),'creator':a.creator}));
          setState((){});});
      }).toList();
    }),
        title:Text(a.type.tr,style: TextStyle(fontWeight:FontWeight.bold,fontStyle: FontStyle.normal ,  fontSize: 25)) ,
        subtitle: Column(
            crossAxisAlignment:CrossAxisAlignment.start ,
            children: [
              Padding(padding:EdgeInsets.only(bottom:5) , child: Text(map.values.first,style: TextStyle(fontSize: 21,fontWeight:FontWeight.bold,fontStyle: FontStyle.normal  ),maxLines: 1,overflow:TextOverflow.clip
                  // ,maxLines:1,overflow: TextOverflow.clip
              ) ),
              Text(date.year.toString()+'/'+date.month.toString()+'/'+date.day.toString(),style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,fontStyle: FontStyle.normal  ),),
            ])
    );}
  } ).toList()));
    } ))])
);}

}
