import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vibration/vibration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_scanner/DB/qr_code.dart';
import 'package:qr_scanner/Properties/second.dart';
import 'package:scan/scan.dart';
import 'package:toast/toast.dart';

class first extends StatefulWidget {
  const first({Key key}) : super(key: key);
  @override
  State<first> createState() => _first();
}

class _first extends State<first> {
  ScanController controller = ScanController();
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        appBar: AppBar(backgroundColor: HexColor('#1b1464'),
            title: Text('scan'.tr,style:TextStyle(fontSize: 40)),
            centerTitle: true,
            actions: [IconButton(onPressed:(){
              controller.toggleTorchMode();
              Toast.show('Flash camera closed',gravity:Toast.center,duration:Toast.lengthLong);
            }, icon:Icon(Icons.flash_on_rounded)),
              IconButton(onPressed:()async{
                try{
                  final f=await ImagePicker().pickImage(source: ImageSource.gallery);
                  String result = await Scan.parse(f.path);
                  if(ringing.val) play_audio();
                  if(vibration.val) await Vibration.vibrate();
                  else await Vibration.cancel();
                  Result(result);
                  currentindex.value=1;
                }
                on Exception catch(e)
                { Toast.show(e.toString(),gravity:Toast.center,duration:Toast.lengthLong);}
              },
                  icon:Icon(Icons.photo)),
              IconButton(onPressed:(){controller.resume();},
                  icon:Icon(Icons.refresh))
            ]),
        body:Center(child:Container(
          height:MediaQuery.of(context).size.height/2,
          width: MediaQuery.of(context).size.width,
          child: ScanView(
              controller: controller,
              scanAreaScale: 0.5,
              scanLineColor: Colors.green.shade400,
              onCapture: (data)  async{
              if(ringing.val)  play_audio();
            if(vibration.val) await Vibration.vibrate();
            else await Vibration.cancel();
              Result(data);
              currentindex.value=1;
              }
          ),
        ))
    );
  }
void Result(String da)
async{ String type;
  List<String> res=da.split(':');
  Map<String,dynamic> save;
try{
  if(res.length==1)
  {if(res[0].isNum)
    {type='Product'; save={'"Product"':'"${res[0]}"'};}
  else
   { type='Text';save={'"Simple"':'"${da.toString()}"'};}}
else {
  if (res[0] == 'tel') {
    type = 'Phone Number';
    save = {'"tel"':'"${res[1]}"'};
  }
  else if (res[0].contains('sms')  || res[1].isPhoneNumber) {
    type = 'Message';
    save = {'"body"':'"${ res.length<3?'':da.substring(da.indexOf('${res[1]}:')+'${res[1]}:'.length,da.length)}"',
      '"tel"':'"${ res[1]}"'};
  }
  else if(res[0]=='MATMSG')
  {
    type='Email';
    if(res.length<=3)
      save={'"email"':'"${res[2]}"'};
    else{int index=res.indexWhere((element) => element.endsWith(';BODY'));
    save={'"email"':'"${da.substring(da.indexOf('MATMSG:TO:')+'MATMSG:TO:'.length,da.indexOf(';SUB:'))}"'
    ,'"sub"':'"${da.substring(da.indexOf(';SUB:')+';SUB:'.length,da.indexOf(';BODY'))}"'
    ,'"body"':'"${da.substring(da.indexOf(';BODY')+';BODY'.length,da.length)}"'
    };}
  }
  else if(res[0]=='mailto')
    {type='Email';
      if(res.length==2)
        save={'"email"':'"${res[1]}"'};
      else{save={
        '"email"': '"${res[1].substring(0,res[1].lastIndexOf('?'))}"',
      '"sub"':'"${da.substring(da.indexOf('subject=')+'subject='.length,da.indexOf('&body='))}"'
      ,'"body"':'"${da.substring(da.indexOf('&body=')+'&body='.length,da.length)}"'
      };}
      }

  else if(res[0]=='WIFI')
    {type='Wifi';
      List<String> l=da.split(';');
      save={'"${l[0].substring(0,l[0].indexOf(':'))}"': '"${l[0].substring(l[0].indexOf(':')+3,l[0].length)}"',
      '"${l[1].substring(0,l[1].indexOf(':'))}"':'"${l[1].substring(l[1].indexOf(':')+1,l[1].length)}"',
    '"${l[2].substring(0,l[2].indexOf(':'))}"':'"${l[2].substring(l[2].indexOf(':')+1,l[2].length)}"'};
    }
  else if(res[0].toLowerCase()=='geo')
      {type='location';
        List<String>j=da.split(';');
        save={'"long"':'"${j[0].split(',').first.split(':').last}"'
        ,'"lat"':'"${j[0].split(',').last}"'};}

  else if(res[1].startsWith('VEVENT'))
  {
    type='EVENT';    save= event_card(da.split('\n'),'EVENT');
  }
  else if(res[0].startsWith('MECARD'))
  {
    type='ID';    save= event_card(da.split('\n'),'ID');
  }
  else if(res[1].startsWith('VCARD'))
    {
      type='Contact';    save=event_card(da.split('\n'),'Contact');
    }
  else if( Uri.parse(da).isAbsolute)
  {
    type='Url';
  save={'"link"':'"${da}"'};
  }
  }}
on Exception catch(e)
  {type='Text';save={'"Simple"':da.toString()};}
finally{
  if(type ==null || save==null)
     {type='Text';save={'"Simple"':da.toString()};}
setState((){});
QR cB=QR({'content':"${save}",'date':DateTime.now().toString(),'type':type,'favourite':false.toString(),'creator':'scanned'});
await db.insertDB(cB);}
}
Map<String,dynamic> event_card(List<String> m,String type){
  Map<String,dynamic> b={};
  List<String> n=['FN','N','EMAIL','TEL','ADR','ORG'];
  List<String> nn=['FN','MECARD','EMAIL','TEL','ADR','ORG'];
    if(type=='EVENT')
      {
       List<String> n=['SUMMARY','DTSTART','DTEND','LOCATION'];
       for(String d in n)
         { for(String i in m)
{if(i.contains(d))
b.addAll({'"${d}"': '"${i.split(':').last}"'});   }}
      }
    else if(type=='Contact')
    {
      for(String d in n)
      {
        for(String i in m)
        {b.addIf(i.contains(d),'"${d}"', '"${i.split(':').last.replaceAll(';',' ')}"');  }}
    }
    else
      {
        String id=m[0];
        List<String> re=id.split(';');
        for(String d in nn)
        {
          for(String i in re)
          { if(i.contains(d))
            b.addAll({'"${d}"': '"${i.split(':').last}"'});    }}
      }
  return b; }
}
