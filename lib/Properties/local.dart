import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:toast/toast.dart';

class Languages implements Translations{
  @override
  Map<String, Map<String, String>> get keys =>{
    "ar":{"load":"تحميل","scan":"المسح الضوئى","history":" الذاكرة","create":"إنشاء",
      "favourite":"المفضلات","Url":"رابط","Text":"نص","Message":"رسالة","Email":"بريد ألكترونى",
      "setting":"الاعدادات","mode":"تغيير الوضع" ,"Phone Number":"رقم هاتف","Wifi":"واي فاي",
      "location":"موقع","EVENT":"حدث","Contact":"جهة أتصال","ID":"بطاقة تعريف",
      'FN':'الاسم الكامل','N':'اسم','TEL':'هاتف','ADR':'عنوان','tel':'الرقم',
      "Created history":"ذاكرة الانشاء","delete":"حذف,","Beep":"نغمة التنبية",
      "6":"صفير عندما يكون الفحص ناجحًا","Vibration":"اهتزاز","Dark mode":"الوضع المظلم",
      "Change language":"تغيير اللغة","Choose Language":"اختر اللغة","Rate App":"قيم التطبيق",
      "Facebook":"فيسبوك","Whatsapp":"واتساب","Instagram":"انستغرام","Viber":"فايبر",
      "Share App":"شارك التطبيق","Privacy policy":"سياسة الخصوصية","creator":"المنشئ",
      "Add to contacts":"أضف إلى جهات الاتصال","Web search":"البحث في الويب",
      "Open map":"افتح الخريطة","Start Date":"تاريخ البدء","Copy":"نسخ",
      '36':'أدخل كلمة المرور','37':'أدخل الموضوع','38':'أدخل خط العرض',
      '39':'أدخل البريد الإلكتروني','40':' إسم الأغنية','41':'قيم هذا التطبيق',
      '42':'هل تحب هذا التطبيق؟ خذ القليل من وقتك لتترك تقييمًا:',
      '43':'أخبرنا بالمشكلة التي واجهتها','link':'الرابط','Simple':'النص',
      '25':"أدخل وصف الحدث",'26':'أدخل اسم الشبكة','27':'أدخل حساب تويتر',
      '28':'أدخل حساب فيسبوك','29':'أدخل عنوان الويب الخاص بك','30':'أدخل بريدك الإلكتروني',
      '31':'أدخل خط الطول','32':'أدخل حساب باى بال','33':' اسم فنان','34':'تم الحفظ في المعرض',
      "10":"حدث خطأ ما","Add to calendar":"إضافة إلى التقويم","12":"أدخل العنوان الصحيح",
      "11":"تم نسخ كلمة المرور إلى الحافظة","Copy password":"انسخ كلمة المرور",
      '44':'أدخل تعليقك','Submit':'نفذ','45':'تعذر تشغيل هذا الرابط','46':'المساعدة والتعليقات',
      "8":"هل تريد حذف هذه النتيجة؟","Call":"مكالمة","Messages":"أرسال","Emails":"أرسال البريد",
      "Twitter":"تويتر","Paypal":"باي بال","Spotify":"سبوتيفي","All":"الكل","Cancel":"ألغاء",
           "5":"هل تريد حذف جميع النتائج ؟","Product":"منتج","type":"نوع","Confirm":"تأكيد",
            "15":"نسخ إلى الحافظة","End Date":"تاريخ الانتهاء","Scanning not working":"المسح لا يعمل",
            "Too many ads":"عدد كبير جدًا من الإعلانات",'Need more info from scanning':'بحاجة إلى مزيد من المعلومات من المسح',
         "13":"أدخل الوقت الآن أو أكثر منه",'14':"أدخل الوقت أكثر من وقت البدء","Others":"آخرون",
       "16":"أدخل عنوان","17":"أدخل نص",'18':'أدخل حساب باى بال الصحيح','35':'أدخل موقع الحدث',
      '21':'أدخل أسم','22':'أدخل المنظمة','23':'أدخل رقم الهاتف','24':'أدخل حساب انستغرام',
      'email':'البريد الالكترونى','WIFI':'الشبكة','S':'الاسم','T':'النوع','P':'رمز الحماية',
      'EMAIL':'البريد الالكترونى','ORG':'مكان العمل','MECARD':'الاسم',
      'SUMMARY':'الحدث','DTSTART':'تاريخ البدء','DTEND':'تاريخ النهاية','LOCATION':'الموقع',
      '19':'أدخل رقم الهاتف الصحيح','20':'أدخل بريدًا إلكترونيًا صحيحًا','body':'المحتوى','sub':'الموضوع',
      "1":"هذا الحقل مطلوب","2":"يجب أن يحتوى على 100 حرف عالاقل","3":"يجب أن يكون أقل من 500 حرف",
      "4":"يجب أن يحتوى على 8 حروف عالاقل","name":"الأسم","date":"تاريخ",
      "title":"العنوان","save":"حفظ","share":"مشاركة","Saved":"تم الحفظ" },
    "en":{"favourite":"favourite","Url":"Url","Text":"Text","load":"loading","scan":"scan","history":"history","create":"create","setting":"setting",
      "save":"save", "1":"This Field is needed","2":"Must be at least 100 characters","3":"Must not be more than 500 characters",
      "language":"Change language","mode":"Change mode","share":"share","Message":"Message","Email":"Email",
      "Phone Number":"Phone Number","Wifi":"Wifi","location":"location","EVENT":"Event","Contact":"Contact",
      "ID":"ID","Facebook":"Facebook","Whatsapp":"Whatsapp","Instagram":"Instagram","Viber":"Viber",'46':'Help and feedback',
       "Confirm":"Confirm","Created history":"Created history","delete":"delete","Beep":"Beep",
      "Share App":"Share App","Privacy policy":"Privacy policy","creator":"creator",
      'FN':'completed name','N':'name','TEL':'telephone','link':'link','tel':'phone number',
      "Emails":"Email","Add to contacts":"Add to contacts","Web search":"Web search",
      'ORG':'work place','MECARD':'name',
        "8":"Do You Want To Delete This Result ?","Call":"Call","Messages":"Message",
      'email':'email','WIFI':'wifi','S':'name','T':'type','P':'password','EMAIL':'EMAIL',
      'SUMMARY':'summary','DTSTART':'date of start','DTEND':'date of end','LOCATION':'location',
      "16":'Enter your address',"17":"Enter text",'18':'Enter Correct paypal Account',
      "25":'Enter Event Description','26':'Enter Network Name','27':' Enter Twitter Account',
      '19':'Enter Correct Phone Number','20':'Enter Correct Email','24':' Enter Instagram Account',
      '21':'Enter Your name','22':'Enter Organization','23':'Enter Phone Number','body':'body',
      '28':'Enter your Facebook Account','29':'Enter your Url Address','sub':'subject',
      '36':'Enter Password','37':'Enter Subject','38':'Enter latitude',
      '39':'Enter Email','40':' Song name','41':'Rate this app','Simple':'Simple',
      'Submit':'Submit','45':'Could not launch This link','ADR':'address',
      '42':'You like this app ? Then take a little bit of your time to leave a rating :',
      '43':'Tell us the problem you encountered','44':'Enter your Comment',
      '30':'Enter your Email','31':'Enter longitude','32':' Enter paypal Account',
      '33':' Artist name','34':'Saved to Gallery','35':'Enter Event Location',
      "10":"Something went error","Add to calendar":"Add to calendar","Others":"Others",
      "Too many ads":"Too many ads",'Need more info from scanning':'Need more info from scanning',
     "12":'Enter Correct Address',"Open map":"Open map","Start Date":"Start Date",
      "13":"Enter time of now or more than","14":"Enter time more than Start time",
      "11":"Password copied to clipboard","Copy password":"Copy password","Copy":"Copy",
      "15":"Copied to Clipboard","End Date":"End Date","Scanning not working":"Scanning not working",
      "Change language":"Change language","Choose Language":"Choose Language","Rate App":"Rate App",
      "6":"Beep when the scan is successful","Vibration":"Vibration","Dark mode":"Dark mode",
      "All":"All","Product":"Product","type":"type","name":"name","date":"date","Cancel":"Cancel",
      "Twitter":"Twitter","Paypal":"Paypal","Spotify":"Spotify","5":"Do You Want To Delete All Results ?",
      "title":"title","4":"Must be at least 8 characters", "Saved":"Saved" }
  };
}
Future<void> contactor({@required String type,Map<String,dynamic> map})
async {
  switch(type) {
    case 'Contact':
      { final newContact = Contact()
        ..name.first = map['FN']==null?" ": map['FN']
        ..emails=[Email(map['EMAIL'])==null?" ":Email(map['EMAIL'])]
        ..phones = [Phone(map['TEL'])==null?" ":Phone(map['TEL'])]
        ..addresses=[Address(map['ADR'])==null?" ":Address(map['ADR'])]
         ..organizations=[Organization(company: map['ORG']==null?" ":map['ORG'])];
      await newContact.insert();
      Toast.show("${newContact.name.first} saved to Contacts]", gravity: Toast.bottom, duration: Toast.lengthLong);}
      break;
    case 'ID':
      { final newContact = Contact()
        ..name.first = map['MECARD']==null?" ": map['MECARD']
        ..emails=[Email(map['EMAIL'])==null?" ":Email(map['EMAIL'])]
        ..phones = [Phone(map['TEL'])==null?" ":Phone(map['TEL'])]
        ..addresses=[Address(map['ADR'])==null?" ":Address(map['ADR'])]
        ..organizations=[Organization(company: map['ORG']==null?" ":map['ORG'])];
      await newContact.insert();
      Toast.show("${newContact.name.first} saved to Contacts", gravity: Toast.bottom, duration: Toast.lengthLong);}
      break;
    case 'Phone Number':
      { final newContact = Contact()
        ..phones = [Phone(map['tel'])==null?" ":Phone(map['tel'])];
      await newContact.insert();
      Toast.show("Contact saved to Contacts", gravity: Toast.bottom, duration: Toast.lengthLong);}
      break;
    case 'Email':
      { final newContact = Contact()
        ..emails = [Email(map['email'])==null?" ":Email(map['email'])];
      await newContact.insert();
      Toast.show("Contact saved to Contacts", gravity: Toast.bottom, duration: Toast.lengthLong);}
      break;
    default:
      break;
  }}