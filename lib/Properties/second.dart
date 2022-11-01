import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:group_button/group_button.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:launch_review/launch_review.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/Properties/local.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner/DB/sqflite.dart';
import 'package:qr_scanner/qr_scan_generate/create.dart';
import 'package:qr_scanner/qr_scan_generate/created.dart';
import 'package:qr_scanner/qr_scan_generate/favourite.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:qr_scanner/qr_scan_generate/first.dart';
import 'package:qr_scanner/qr_scan_generate/history.dart';
import 'package:qr_scanner/qr_scan_generate/setting.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

DB db=DB();
final box = GetStorage();
final currentindex=0.obs;
final ringing=false.val('ringing');
final vibration=false.val('vibration');
final yes=false.obs;
final dark=false.val('dark');
final type='All'.obs;
final language='en'.val('language');
final orders='date'.obs;
List<String> order=['type','name','date'];
List<String> order1=['favourite','delete'];
TextEditingController tc1=TextEditingController();
TextEditingController tc2=TextEditingController();
TextEditingController tc3=TextEditingController();
TextEditingController tc4=TextEditingController();
TextEditingController tc5=TextEditingController();
TextEditingController dtpc1=TextEditingController();
TextEditingController dtpc2=TextEditingController();
final controller = GroupButtonController();
List<Icon> icons=[Icon(Icons.star,color:Colors.yellowAccent),Icon(Icons.delete,color:Colors.red)];
List<String> types=['All','Url','Product','Text','Email','Phone Number','Message','Wifi','location','EVENT','Contact','ID'];
List<Widget> list=[first(), history(), create(), setting(),favourite(),created()];
List<IconData> icone=[Icons.history,Icons.create,Icons.settings,Icons.favorite];
List<Widget> custom_widget({BuildContext c,String type,Map<String,dynamic> mapes})
{FlatButton call= FlatButton(onPressed: (){
  launchUrl(type:type=='Phone Number'?type:'Phone Number/${type}',mapes: mapes  );}, child: Row( mainAxisSize:MainAxisSize.min ,
    children:[Icon(Icons.call,color:Colors.white),Text('\b'+'Call'.tr,style:TextStyle(color: Colors.white,fontSize: 25))]),
    color:  HexColor('#1b1464'),shape:OutlineInputBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(50),
        bottomRight: Radius.circular(50)) ),minWidth:MediaQuery.of(c).size.width/4 );
FlatButton message= FlatButton(onPressed: (){launchUrl(type:type,mapes: mapes  );}, child: Row( mainAxisSize:MainAxisSize.min ,
    children:[Icon(Icons.message,color:Colors.white),Text('\b'+'Messages'.tr,style:TextStyle(color: Colors.white,fontSize: 25))]),
    color:  HexColor('#1b1464'),shape:OutlineInputBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(50),
        bottomRight: Radius.circular(50)) ),minWidth:MediaQuery.of(c).size.width/4 );
FlatButton email= FlatButton(onPressed: (){launchUrl(type:type=='Text'?'Email/Text':type,mapes: mapes  );},
    child: Row( mainAxisSize:MainAxisSize.min ,
    children:[Icon(Icons.email,color:Colors.white),Text('\b'+'Emails'.tr,style:TextStyle(color: Colors.white,fontSize: 25))]),
    color:  HexColor('#1b1464'),shape:OutlineInputBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(50),
        bottomRight: Radius.circular(50)) ),minWidth:MediaQuery.of(c).size.width/4 );
FlatButton contact= FlatButton(onPressed: (){ contactor(type: type,map: mapes);  }, child: Row( mainAxisSize:MainAxisSize.min ,
    children:[Icon(FontAwesomeIcons.contactCard,color:Colors.white),Text('\b'+'Add to contacts'.tr,style:TextStyle(color: Colors.white,fontSize: 25))]),
    color:  HexColor('#1b1464'),shape:OutlineInputBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(50),
        bottomRight: Radius.circular(50)) ),minWidth:MediaQuery.of(c).size.width/4 );
FlatButton open= FlatButton(onPressed: (){launchUrl(type:type,mapes: mapes  );}, child: Row( mainAxisSize:MainAxisSize.min ,
    children:[Icon(FontAwesomeIcons.earth,color:Colors.white),Text('\b'+'Web search'.tr,style:TextStyle(color: Colors.white,fontSize: 25))]),
    color:  HexColor('#1b1464'),shape:OutlineInputBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(50),
        bottomRight: Radius.circular(50)) ),minWidth:MediaQuery.of(c).size.width/4 );
FlatButton event= FlatButton(onPressed: (){
 try{
  final Event event = Event(
    title: mapes['SUMMARY'],
    description: 'Event description',
    startDate:DateTime.parse(mapes['DTSTART']),
    endDate: DateTime.parse(mapes['DTEND']),
  );
  Add2Calendar.addEvent2Cal(event);}
     catch(e)
  {Toast.show('10'.tr, gravity: Toast.bottom, duration: Toast.lengthLong);}
}, child: Row( mainAxisSize:MainAxisSize.min ,
    children:[Icon(Icons.event,color:Colors.white),Text('\b'+'Add to calendar'.tr,style:TextStyle(color: Colors.white,fontSize: 25))]),
    color:  HexColor('#1b1464'),shape:OutlineInputBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(50),
        bottomRight: Radius.circular(50)) ),minWidth:MediaQuery.of(c).size.width/4 );
FlatButton password= FlatButton(onPressed: (){Clipboard.setData(ClipboardData(text:mapes['P'].toString() ));
Toast.show('11'.tr, gravity: Toast.bottom, duration: Toast.lengthLong);}, child: Row( mainAxisSize:MainAxisSize.min ,
    children:[Icon(Icons.file_copy_rounded,color:Colors.white),Text('\b'+'Copy password'.tr,style:TextStyle(color: Colors.white,fontSize: 25))]),
    color:  HexColor('#1b1464'),shape:OutlineInputBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(50),
        bottomRight: Radius.circular(50)) ),minWidth:MediaQuery.of(c).size.width/4 );
FlatButton map= FlatButton(onPressed: ()async{
try {
  String googleUrl='';
  if(type=='location')
     googleUrl = 'https://www.google.com/maps/search/?api=1&query=${ mapes['long']},${mapes['lat']}';
     else {
    List<Location> locations = await locationFromAddress(
        mapes['ADR'].toString());
     googleUrl = 'https://www.google.com/maps/search/?api=1&query=${locations
        .first.latitude},${locations.first.longitude}';
  }launchUrl(mapes: {'location':googleUrl},type: 'location' );}
catch(e)
  {    Toast.show('12'.tr, gravity: Toast.bottom, duration: Toast.lengthLong);}
}, child: Row( mainAxisSize:MainAxisSize.min ,
    children:[Icon(Icons.add_location,color:Colors.white),Text('\b'+'Open map'.tr,style:TextStyle(color: Colors.white,fontSize: 25))]),
    color:  HexColor('#1b1464'),shape:OutlineInputBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(50),
        bottomRight: Radius.circular(50)) ),minWidth:MediaQuery.of(c).size.width/4 );
FlatButton navigation= FlatButton(onPressed: () async {
  try {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    String url = 'https://www.google.com/maps/dir/?api=1&origin=' +
        position.latitude.toString() +
        ',' +
        position.longitude.toString() +
        ' &destination=' +
        mapes['lat'].toString() +
        ',' +
        mapes['long'].toString() +
        '&travelmode=driving&dir_action=navigate';
    launchUrl(mapes: {'location':url},type: 'location' );}
  catch(e)
  {    Toast.show('Enter Correct Address', gravity: Toast.bottom, duration: Toast.lengthLong);}
}, child: Row( mainAxisSize:MainAxisSize.min ,
    children:[Icon(Icons.navigation,color:Colors.white),Text('\bNavigate',style:TextStyle(color: Colors.white,fontSize: 25))]),
    color:  HexColor('#1b1464'),shape:OutlineInputBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(50),
        bottomRight: Radius.circular(50)) ),minWidth:MediaQuery.of(c).size.width/4 );
switch(type) {
  case 'Url':
  case 'Product':
    return [open];
    break;
  case 'Text':
    return [message, email];
    break;
  case 'Phone Number':
    return [call,contact];
    break;
  case 'Message':
    return [message];
    break;
  case 'Email':
    return [email,contact];
    break;
  case 'Wifi':
    return [password];
    break;
  case 'location':
    return [map,navigation];
    break;
  case 'EVENT':
    return [event, email];
    break;
  case 'Contact':
  case 'ID':
    return [call, email, map,contact];
    break;
  default:
    return [];
}  }
List<String> Group_button(String type) {
  switch(type) {
    case 'Wifi':
      return ["WPA/WPA2","WPA","None"];
      break;
    case 'Facebook':
      return ["FACEBOOK ID","URL"];
      break;
    case 'Paypal':
      return ["Me Link","Me Username"];
      break;
    case 'Twitter':
    case 'Instagram':
      return ["Username","Url"];
      break;
    case 'All':
      return  ['Scanning not working'.tr,'Too many ads'.tr,'Need more info from scanning'.tr,'Others'.tr];
      break;
    default:
      return [];
  }

}
List<Widget>  creators(String type) {
  DateTimePicker dtp1=  DateTimePicker(
    controller: dtpc1,
    style: TextStyle(fontSize: 40),
    type: DateTimePickerType.dateTime,
    dateMask: 'yyyy/MM/d HH-mm',
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    icon: Icon(Icons.event,size: 40),
    dateLabelText: 'Start Date'.tr,
    selectableDayPredicate: (date) {
      if (date.weekday == 6 || date.weekday == 7) {
        return false;
      }
      return true;
    },
    validator: (f) {
      if(f==null || f.isEmpty)
        return '1'.tr;
      else if(DateTime.parse(f).compareTo( DateTime.now())<0)
        return '13'.tr;
      return null;
    });
  DateTimePicker dtp2=  DateTimePicker(
    controller: dtpc2,
    style: TextStyle(fontSize: 40),
    type: DateTimePickerType.dateTime,
      dateMask: 'yyyy/MM/d HH-mm',
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    icon: Icon(Icons.event,size: 40),
    dateLabelText: 'End Date'.tr,
    selectableDayPredicate: (date) {
      if (date.weekday == 6 || date.weekday == 7) {
        return false;
      }
      return true;
    },
    validator: (f) {
      if(f==null || f.isEmpty)
        return '1'.tr;
      else if(DateTime.parse(f).compareTo( DateTime.parse(dtpc1.text))<0)
        return '14'.tr;
      return null;
    });
  GroupButton gb=  GroupButton(
    controller: controller,
    isRadio: false,
    options:GroupButtonOptions(
      selectedTextStyle:TextStyle(fontSize: 20) ,
      unselectedTextStyle:TextStyle(fontSize: 20,color: Colors.black) ,
      borderRadius: BorderRadius.circular(50),
      buttonHeight: 100,
      buttonWidth: 200,
      spacing: 5,
      selectedColor: Colors.green,
      unselectedColor: Colors.white ) ,
    onSelected:(i,h,n){controller.unselectAll();
      controller.selectIndex(h);},
    buttons: Group_button(type) );
  TextFormField text=TextFormField(
    controller: tc1,
      maxLines: 5,
      keyboardType: TextInputType.text,
      maxLength: 500,
      minLines: 5,
      validator:(f){
       if(f==null || f.isEmpty)
              return '1'.tr;
            else if(f.length>500)
              return '3'.tr;
            return null;
      } , autovalidateMode:AutovalidateMode.onUserInteraction  ,
      style:TextStyle(fontSize: 25,color: Colors.white) ,
      decoration:InputDecoration(hintText :type=='ID'?'16'.tr: '17'.tr,
          hintStyle:TextStyle(fontSize: 25,color: Colors.white) ,
          counterStyle: TextStyle(fontSize: 25,color: Colors.white),
          enabledBorder:OutlineInputBorder(borderSide:BorderSide(width: 2,color: Colors.white) )
          ,errorBorder:OutlineInputBorder(borderSide:BorderSide(width: 2) )
          ,focusedBorder:OutlineInputBorder(borderSide:BorderSide(width: 2,color: Colors.white) ))
  );
  TextFormField text1=TextFormField(
      controller: tc2,
      maxLength: 100,
      keyboardType: input_type(type),
      validator:(f){
        switch(type) {
          case 'Paypal':
            { if(f==null || f.isEmpty)
              return '1'.tr;
            else if(!'https://www.paypal.me/${f}'.isURL)
              return '18'.tr;
            return null;}
            break;
          case 'Url':
            { if(f==null || f.isEmpty)
              return '1'.tr;
            else if(!f.isURL)
              return 'Enter Correct Url';
            return null;}
            break;
          case 'Viber':
          case 'Whatsapp':
          case 'Contact':
          case 'Phone Number':
          case 'Message':
            { if(f==null || f.isEmpty)
              return '1'.tr;
            else if(!f.isPhoneNumber)
              return '19'.tr;
            return null;}
            break;
          case 'Email':
            { if(f==null || f.isEmpty)
              return '1'.tr;
            else if(!f.isEmail)
              return '20'.tr;
            return null;}
            break;
          case 'Twitter':
          case 'Instagram':
          case 'Facebook':
          case 'EVENT':
          case 'Wifi':
          case 'Spotify':
            { if(f==null || f.isEmpty)
              return '1'.tr;
            else if(f.length>500)
              return '3'.tr;
            return null;}
            break;
          default:
            return null;}
      } , autovalidateMode:AutovalidateMode.onUserInteraction  ,
      style:TextStyle(fontSize: 25,color: Colors.white) ,
      decoration:InputDecoration(hintText : label_text(type),
          hintStyle:TextStyle(fontSize: 25,color: Colors.white) ,
          counterStyle: TextStyle(fontSize: 25,color: Colors.white),
          enabledBorder:OutlineInputBorder(borderSide:BorderSide(width: 1,color: Colors.white) )
          ,errorBorder:OutlineInputBorder(borderSide:BorderSide(width: 1) )
          ,focusedBorder:OutlineInputBorder(borderSide:BorderSide(width: 1,color: Colors.white) ))
  );
  TextFormField text2=TextFormField(
      controller: tc3,
      maxLength: 100,
      keyboardType: input_type1(type),
      validator:(f){
        switch(type) {
          case 'EVENT':
          case 'Wifi':
          case 'Email':
          case 'Spotify':
            { if(f==null || f.isEmpty)
              return '1'.tr;
            else if(f.length>500)
              return '3'.tr;
            return null;}
            break;
          case 'Contact':
            { if(f==null || f.isEmpty)
              return '1'.tr;
            else if(!f.isEmail)
              return '20'.tr;
            return null;}
            break;
          default:
            return null;}
      } , autovalidateMode:AutovalidateMode.onUserInteraction  ,
      style:TextStyle(fontSize: 25,color: Colors.white) ,
      decoration:InputDecoration(hintText : label_text1(type),
          hintStyle:TextStyle(fontSize: 25,color: Colors.white) ,
          counterStyle: TextStyle(fontSize: 25,color: Colors.white),
          enabledBorder:OutlineInputBorder(borderSide:BorderSide(width: 1,color: Colors.white) )
          ,errorBorder:OutlineInputBorder(borderSide:BorderSide(width: 1) )
          ,focusedBorder:OutlineInputBorder(borderSide:BorderSide(width: 1,color: Colors.white) ))
  );
  TextFormField text3=TextFormField(
      controller: tc4,
      maxLength: 100,
      keyboardType: TextInputType.text,
      validator:(f){
        switch(type) {
          case 'Contact':
            { if(f==null || f.isEmpty)
              return '1'.tr;
            else if(f.length>500)
              return '3'.tr;
            return null;}
            break;
          default:
            return null;}
      } , autovalidateMode:AutovalidateMode.onUserInteraction  ,
      style:TextStyle(fontSize: 25,color: Colors.white) ,
      decoration:InputDecoration(hintText : '21'.tr,
          hintStyle:TextStyle(fontSize: 25,color: Colors.white) ,
          counterStyle: TextStyle(fontSize: 25,color: Colors.white),
          enabledBorder:OutlineInputBorder(borderSide:BorderSide(width: 1,color: Colors.white) )
          ,errorBorder:OutlineInputBorder(borderSide:BorderSide(width: 1) )
          ,focusedBorder:OutlineInputBorder(borderSide:BorderSide(width: 1,color: Colors.white) ))
  );
  TextFormField text4=TextFormField(
      controller: tc5,
      maxLength: 100,
      keyboardType: TextInputType.text,
      validator:(f){
      if(f==null || f.isEmpty)
              return '1'.tr;
            else if(f.length>500)
              return '3'.tr;
            return null;}
      , autovalidateMode:AutovalidateMode.onUserInteraction  ,
      style:TextStyle(fontSize: 25,color: Colors.white) ,
      decoration:InputDecoration(hintText : '22'.tr,
          hintStyle:TextStyle(fontSize: 25,color: Colors.white) ,
          counterStyle: TextStyle(fontSize: 25,color: Colors.white),
          enabledBorder:OutlineInputBorder(borderSide:BorderSide(width: 1,color: Colors.white) )
          ,errorBorder:OutlineInputBorder(borderSide:BorderSide(width: 1) )
          ,focusedBorder:OutlineInputBorder(borderSide:BorderSide(width: 1,color: Colors.white) ))
  );
  switch(type) {
    case 'Text':
      return [text];
      break;
    case 'Message':
      return [text1,text];
      break;
    case 'Email':
      return [text1,text2,text];
      break;
    case 'Twitter':
    case 'Instagram':
    case 'Paypal':
    case 'Facebook':
    return [text1,gb];
    break;
    case 'Viber':
    case 'Whatsapp':
    case 'Url':
    case 'Phone Number':
      return [text1];
      break;
    case 'Wifi':
      return [text1,text2,gb];
      break;
    case 'Contact':
      return [text3,text1,text2];
      break;
    case 'ID':
      return [text3,text1,text2,text4,text];
      break;
    case 'Spotify':
    case 'location':
      return [text1,text2];
      break;
    case 'EVENT':
      return [text1 ,text2,Container(child:dtp1 ,color: Colors.white),Divider(height: 20),Container(child:dtp2 ,color: Colors.white)];
      break;
    default:
      return [];}
}
String label_text(String type) {
  switch(type) {
    case 'EVENT':
      return '25'.tr;
      break;
    case 'Wifi':
      return '26'.tr;
      break;
    case 'Twitter':
      return '27'.tr;
      break;
    case 'Facebook':
      return '28'.tr;
      break;
    case 'Url':
      return '29'.tr;
      break;
    case 'Email':
      return '30'.tr;
      break;
    case 'location':
      return '31'.tr;
      break;
    case 'Paypal':
      return '32'.tr;
      break;
    case 'Spotify':
      return '33'.tr;
      break;
    case 'Instagram':
      return '24'.tr;
      break;
    case 'Viber':
    case 'Whatsapp':
    case 'ID':
    case 'Contact':
    case 'Phone Number':
    case 'Message':
      return'23'.tr;
      break;
  default:
    return '';
}
  }
String label_text1(String type) {
  switch(type) {
    case 'EVENT':
      return '35'.tr;
      break;
    case 'Wifi':
      return '36'.tr;
      break;
    case 'Email':
      return '37'.tr;
      break;
    case 'location':
      return '38'.tr;
      break;
    case 'ID':
    case 'Contact':
      return '39'.tr;
      break;
    case 'Spotify':
      return '40'.tr;
      break;
    default:
      return '';
  }
}
 TextInputType input_type(String type) {
   switch(type) {
     case 'Spotify':
     case 'Twitter':
     case 'Instagram':
     case 'Paypal':
     case 'Facebook':
     case 'EVENT':
     case 'Wifi':
     case 'Text':
       return TextInputType.text;
       break;
     case 'Url':
       return TextInputType.url;
       break;
     case 'Email':
       return TextInputType.emailAddress;
       break;
     case 'Viber':
     case 'ID':
     case 'Message':
     case 'Whatsapp':
     case 'Contact':
     case 'Phone Number':
       return TextInputType.phone;
       break;
     case 'location':
       return TextInputType.numberWithOptions(decimal: true);
       break;
     default:
       return null;
   }
 }
TextInputType input_type1(String type) {
  switch(type) {
    case 'Spotify':
    case 'EVENT':
    case 'Wifi':
    case 'Email':
      return TextInputType.text;
      break;
    case 'location':
      return TextInputType.numberWithOptions(decimal: true);
      break;
    case 'ID':
    case 'Contact':
      return TextInputType.emailAddress;
      break;
    default:
      return null;
  }
}
Future<Uint8List> imager(String data) async {
    final img=await  QrPainter(data: data,
      version: QrVersions.auto,
      emptyColor: Colors.white,
      gapless: false
    ).toImage(300);
    final a = await img.toByteData(format: ImageByteFormat.png);
    return a.buffer.asUint8List();
}
String final_result(String type) {
  switch(type) {
    case 'Text':
      return tc1.text;
      break;
    case 'Url':
      return tc2.text;
      break;
    case 'Phone Number':
      return 'tel:${tc2.text}';
      break;
    case 'Message':
      return 'smsto:${tc2.text}:${tc1.text}';
      break;
    case 'Email':
      return 'mailto:${tc2.text}?subject=${tc3.text}&body=${tc1.text}';
      break;
    case 'Wifi':
      return 'WIFI:S:${tc2.text};T:${Group_button(type)[controller.selectedIndex]};P:${tc3.text}';
      break;
    case 'Contact':
      return 'Version:VCARD\nFN:${tc4.text}\nTEL:${tc2.text}\nEMAIL:${tc3.text}';
      break;
    case 'ID':
      return 'Version:VCARD\nFN:${tc4.text}\nTEL:${tc2.text}\nEMAIL:${tc3.text}\nORG:${tc5.text}\nADR:${tc1.text}';
      break;
    case 'location':
      return 'Geo:${tc2.text},${tc3.text};';
      break;
    case 'EVENT':
        return 'Version:VEVENT\nSUMMARY:${tc2.text}\nDTSTART:${DateFormat('yyyyMMdTHHmm37').format(DateTime.parse(dtpc1.text))}\nDTEND:${DateFormat('yyyyMMdTHHmm37').format(DateTime.parse(dtpc2.text))}\nLOCATION:${tc3.text}';
      break;
    case 'Facebook':
      return 'fb://profile/${tc2.text}';
      break;
    case 'Whatsapp':
      return 'whatsapp://send?phone=${tc2.text}';
      break;
    case 'Paypal':
      return 'https://www.paypal.me/${tc2.text}';
      break;
    case 'Instagram':
      return  'instagram://user?username=${tc2.text}';
      break;
    case 'Viber':
      return  'viber://add?number=${tc2.text}';
      break;
    case 'Twitter':
      return  'twitter://user?screen_name=${tc2.text}';
      break;
    case 'Spotify':
      return 'spotify:search:${tc2.text};${tc3.text}';
      break;
    default:
     return ' ';
  }
}
save(String data,String type) async {
  Random random = new Random();
  Uint8List u8l=await imager(data);
final w=  await ImageGallerySaver.saveImage(
      u8l.buffer.asUint8List(),
      quality: 60,
      name: "${type} ${random.nextInt(100)}");
}
Future<void> launchUrl({String type,Map<String,dynamic> mapes}) async {
  String url;
  switch(type) {
    case 'Url':
      url= mapes['link'];
      break;
    case 'Product':
      url='https://www.google.com/search?q=${mapes['Product']}';
      break;
    case 'Phone Number':
      url='tel:${mapes["tel"]}';
      break;
    case 'Phone Number/ID':
    case 'Phone Number/Contact':
      url='tel:${mapes["TEL"]}';
      break;
    case 'Text':
      url='sms:${''}?body=${mapes["Simple"]}';
      break;
    case 'Message':
      url='sms:${mapes['tel']}?body=${mapes["body"]}';
      break;
    case 'ID':
    case 'Contact':
      url='mailto:${mapes["EMAIL"]}';
      break;
    case 'Email/Text':
      url='mailto:${' '}?sub=${' '}&body=${mapes['Simple']}';
      break;
    case 'EVENT':
      url='mailto:${' '}?sub=${' '}&body=${mapes}';
      break;
    case 'Email/Text':
      url='mailto:${' '}?sub=${' '}&body=${mapes["Simple"]}';
      break;
    case 'Email':
      url='mailto:${mapes["email"]}?sub=${mapes["sub"]}&body=${mapes["body"]}';
      break;
    case 'location':
      url=mapes['location'];
      break;
    default:
      url='';
  }
  if (await canLaunch(url)) {
    await launch(url);
  }
  else
    Toast.show('45'.tr, gravity: Toast.bottom, duration: Toast.lengthLong);
}
void play_audio()async{
  AudioPlayer player = AudioPlayer();
  final ByteData data = await rootBundle.load('asset/A3TMECN-beep.mp3');
  Directory tempDir = await getTemporaryDirectory();
  File tempFile = File('${tempDir.path}/demo.mp3');
  await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
  var mp3Uri = tempFile.uri.toString();
  if(mp3Uri != null)
    player.play(mp3Uri, isLocal: true);
}
void after_result(String type) {
  switch(type) {
    case 'Text':
      tc1.clear();
      break;
    case 'Message':
      {tc1.clear();tc2.clear();}
      break;
    case 'Email':
      {tc1.clear();tc2.clear();tc3.clear();}
      break;
    case 'Twitter':
    case 'Viber':
    case 'Instagram':
    case 'Paypal':
    case 'Whatsapp':
    case 'Facebook':
    case 'Url':
    case 'Phone Number':
      tc2.clear();
      break;
    case 'Wifi':
      {tc3.clear();tc2.clear();controller.unselectAll();}
      break;
    case 'Contact':
      {tc3.clear();tc2.clear();tc4.clear();}
      break;
    case 'ID':
      {tc3.clear();tc2.clear();tc4.clear();tc1.clear();tc5.clear();}
      break;
    case 'Spotify':
    case 'location':
      {tc3.clear();tc2.clear();}
      break;
    case 'EVENT':
      {tc3.clear();tc2.clear();dtpc1.clear();dtpc2.clear();}
      break;
    default:
      break;}
}
Map<String, dynamic> Contact_event(String content,String type){
  List<String> cont=content.replaceAll(RegExp('{|}|"'), '').split(',');
  try{
  switch(type) {
    case 'Text':
      return {'Simple':content.replaceAll('"Simple":', '')};
      break;
    case 'Url':
      return {'link':cont.first.substring('link:'.length,cont.first.length)};
      break;
      case 'Phone Number':
    return {'tel':cont.first.substring('tel:'.length,cont.first.length)};
    break;
    case 'Message':
      return {'body':cont.first.substring('body:'.length,cont.first.length)
        ,'tel':cont.last.substring('tel:'.length,cont.last.length)};
      break;
    case 'Email':
      {if(cont.length>1)
      return {'email':cont.first.substring('email:'.length,cont.first.length),
        'sub':cont.elementAt(1).substring('sub:'.length,cont.elementAt(1).length),
        'body':cont.last.substring('body:'.length,cont.last.length)};
      else        return {'email':cont.first.substring('email:'.length,cont.first.length)}; }
      break;
    case 'Wifi':
      return {'WIFI': cont[0].replaceAll('WIFI:', ''),
        'S':cont[1].substring(3,cont[1].length),
        'P':cont.toString().substring(cont[0].length+cont[1].length+8,cont.toString().length-1)};
      break;
    case 'EVENT':
      return {'SUMMARY':content.substring(content.indexOf('SUMMARY')+'SUMMARY": "'.length,content.indexOf('"DTSTART":')-3),
        'DTSTART':content.contains("DTSTART")&& content.contains("DTEND")?   content.substring(content.indexOf('"DTSTART":')+'"DTSTART":  '.length,content.indexOf('"DTEND":')-3):" ",
        'DTEND':content.contains("LOCATION")&& content.contains("DTEND")?content.substring(content.indexOf('"DTEND":')+'"DTEND":  '.length,content.indexOf('"LOCATION":')-3):" ",
        'LOCATION':content.substring(content.indexOf('"LOCATION":')+'"LOCATION":'.length,content.length-1)
      };
      break;
    case 'ID':
      return  {'FN':content.contains("FN")&& content.contains("MECARD")? content.substring(content.indexOf('FN')+'FN": "'.length,content.indexOf('"MECARD":')-3):" ",
        'MECARD':content.contains("EMAIL")&& content.contains("MECARD")?content.substring(content.indexOf('"MECARD":')+'"MECARD":  '.length,content.indexOf('"EMAIL":')-3):" ",
        'EMAIL':content.contains("EMAIL")&& content.contains("TEL")?content.substring(content.indexOf('"EMAIL":')+'"EMAIL":  '.length,content.indexOf('"TEL":')-3):" ",
        'TEL':content.contains("TEL")&& content.contains("ADR")?content.substring(content.indexOf('"TEL":')+'"TEL":  '.length,content.indexOf('"ADR":')-3):" ",
        'ADR':content.contains("ADR")&& content.contains("ORG")?content.substring(content.indexOf('"ADR":')+'"ADR":  '.length,content.indexOf('"ORG":')-3):" ",
        'ORG': content.contains("ORG")?content.substring(content.indexOf('"ORG":')+'"ORG": '.length,content.length-1):" "
      };
      break;
    case 'Contact':
   return {'FN':content.contains("FN")&& content.contains("N")? content.substring(content.indexOf('FN')+'FN": "'.length,content.indexOf('"N":')-3):" ",
     'N':content.contains("EMAIL")&& content.contains("N")?content.substring(content.indexOf('"N":')+'"N":  '.length,content.indexOf('"EMAIL":')-3):" ",
     'EMAIL':content.contains("EMAIL")&& content.contains("TEL")?content.substring(content.indexOf('"EMAIL":')+'"EMAIL":  '.length,content.indexOf('"TEL":')-3):" ",
     'TEL':content.contains("TEL")&& content.contains("ADR")?content.substring(content.indexOf('"TEL":')+'"TEL":  '.length,content.indexOf('"ADR":')-3):" ",
     'ADR':content.contains("ADR")&& content.contains("ORG")?content.substring(content.indexOf('"ADR":')+'"ADR":  '.length,content.indexOf('"ORG":')-3):" ",
     'ORG': content.contains("ORG")?content.substring(content.indexOf('"ORG":')+'"ORG": '.length,content.length-1):" "
   };
      break;
    default:
      return {'Contact':content.toString()};
  }}
      catch(e){
    return {"":content}  ;
      }
}
Widget icon(String type) {
  switch (type) {
    case 'Url':
      return Icon(FontAwesomeIcons.earth, color: Colors.green.shade500,size:45);
      break;
    case 'Product':
      return Icon(FontAwesomeIcons.barcode, color: Colors.black,size:45);
      break;
    case 'Text':
      return Icon(FontAwesomeIcons.textHeight, color: Colors.orange.shade900,size:45);
      break;
    case 'Phone Number':
      return Icon(Icons.phone, color: Colors.lightBlue,size:45);
      break;
    case 'Message':
      return Icon(Icons.message, color: Colors.pink,size:45);
      break;
    case 'Email':
      return Icon(Icons.email, color: Colors.greenAccent,size:45);
      break;
    case 'Wifi':
      return Icon(Icons.wifi, color: Colors.deepOrangeAccent.withGreen(5),size:45);
      break;
    case 'location':
      return Icon(
          Icons.add_location_rounded, color: Colors.yellowAccent.withGreen(5),size:45);
      break;
    case 'EVENT':
      return Icon(Icons.event, color: Colors.blueAccent.shade700,size:45);
      break;
    case 'Contact':
      return Icon(Icons.perm_contact_calendar_sharp,
          color: Colors.lightBlueAccent.shade100,size:45);
      break;
    case 'ID':
      return Icon(Icons.perm_identity_outlined,
          color: Colors.cyan.shade100,size:45);
      break;
    case  'Facebook':
      return Icon(FontAwesomeIcons.facebook,
          color: Colors.blue.shade200,size:45);
      break;
    case  'Whatsapp':
      return Icon(FontAwesomeIcons.whatsapp,
          color: Colors.green.shade200,size:45);
      break;
    case  'Instagram':
      return Icon(FontAwesomeIcons.instagram,
          color: Colors.pinkAccent.shade200,size:45);
      break;
    case  'Viber':
      return Icon(FontAwesomeIcons.viber,
          color: Colors.deepPurple.shade200,size:45);
      break;
    case  'Twitter':
      return Icon(FontAwesomeIcons.twitter,
          color: Colors.blue.shade100,size:45);
      break;
    case  'Paypal':
      return Icon(FontAwesomeIcons.paypal,
          color: Colors.blue.shade900,size:45);
      break;
    case  'Spotify':
      return Icon(FontAwesomeIcons.spotify,
          color: Colors.green.shade900,size:45);
      break;
    default:
      return Icon(Icons.no_backpack_outlined,color: Colors.grey);
  }
}
void rate(BuildContext context) { RateMyApp rateMyApp = RateMyApp(
  preferencesPrefix: 'rateMyApp_',
  minDays: 7,
  minLaunches: 10,
  remindDays: 7,
  remindLaunches: 10,
  googlePlayIdentifier: 'com.example.qr_scanner',
  appStoreIdentifier: 'com.example.qrScanner',
);
rateMyApp.init().then((_) {
  rateMyApp.showStarRateDialog(
  context,
  title: '41'.tr, // The dialog title.
  message: '42'.tr,
  actionsBuilder: (context, stars) {
    return [
      FlatButton(
        child: Text('OK'),
        onPressed: () async {
          print('Thanks for the ' + (stars == null ? '0' : stars.round().toString()) + ' star(s) !');
          await rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
          Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.rate);
          if(stars==null || stars.round()<=3)
            {help();}
            else {
              Future.delayed(Duration(seconds: 3),(){
                LaunchReview.launch(androidAppId: 'com.example.qr_scanner',iOSAppId:' com.example.qrScanner' );
              });  }
        })
    ];
  },
  dialogStyle: const DialogStyle( // Custom dialog styles.
    titleAlign: TextAlign.center,
    messageAlign: TextAlign.center,
    messagePadding: EdgeInsets.only(bottom: 20),
  ),
  starRatingOptions: const StarRatingOptions(),
  onDismissed: () => rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
);  }); }
void help()
{Get.bottomSheet(BottomSheet(onClosing: (){}, builder:(context){
  return SingleChildScrollView(child: Column(
      children: [
       Align(alignment:Alignment.topLeft,child: IconButton(onPressed:(){Get.back();}, icon: Icon(Icons.close)) ),
        Center(child: Icon(Icons.attach_email,color:Colors.green,size: 80)),
        Divider(thickness: 5,color: Colors.transparent),
        Center(child: Text('43'.tr,style: TextStyle(fontSize: 40))),
        Divider(thickness: 5,color: Colors.transparent),
        Align(alignment: Alignment.centerLeft,child:Text('\b\b'+'type'.tr,style: TextStyle(fontSize: 40))),
        Divider(thickness: 5,color: Colors.transparent),
        GroupButton(
            controller: controller,
            isRadio: false,
            options:GroupButtonOptions(
                selectedTextStyle:TextStyle(fontSize: 30) ,
                unselectedTextStyle:TextStyle(fontSize: 30,color: Colors.black) ,
                borderRadius: BorderRadius.circular(40),
                textAlign: TextAlign.center,
                buttonHeight: 100,
                buttonWidth: 350,
                spacing: 5,
                selectedColor: Colors.green,
                unselectedColor: Colors.white ) ,
            onSelected:(i,h,n){
              if(n==true)
                controller.selectIndex(h);
              else
                controller.unselectIndex(h); },
            buttons: Group_button('All')),
        Divider(thickness: 5,color: Colors.transparent),
        TextFormField(
            controller: tc1,
            maxLines: 5,
            keyboardType: TextInputType.text,
            maxLength: 500,
            onChanged:(i){if(i==null || i.length<6)
              yes.value=false;
            else   yes.value=true;} ,
            minLines: 5,
            style:TextStyle(fontSize: 25,color: Colors.black) ,
            decoration:InputDecoration(hintText : '44'.tr,
                hintStyle:TextStyle(fontSize: 25,color: Colors.black) ,
                counterStyle: TextStyle(fontSize: 25,color: Colors.black),
                enabledBorder:OutlineInputBorder(borderSide:BorderSide(width: 1,color: Colors.black) )
                ,focusedBorder:OutlineInputBorder(borderSide:BorderSide(width: 1,color: Colors.black) ))
        ), Divider(thickness: 5,color: Colors.transparent),
        Obx(()=> FlatButton(onPressed:yes.isFalse?null:()async{
          List<String> g=[];
          controller.selectedIndexes.forEach((element) {g.add(Group_button('All')[element]); });
          final       url='mailto:eslam1995saleh@gmail.com?subject=Qr_Scanner&body=${g}\n${tc1.text}';
          if (await canLaunch(url)) {
            await launch(url);
          }
          else
            Toast.show('45'.tr, gravity: Toast.bottom, duration: Toast.lengthLong);
        }, child: Text('Submit'.tr,style: TextStyle(fontSize: 40,color: Colors.white)),height: 100,minWidth: 200,shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50) ),
            color:yes.isFalse?Colors.transparent:Colors.green )
        ),        Divider(thickness: 5,color: Colors.transparent) ]   ));
}));}