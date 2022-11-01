class QR
{
  int id;
  String  content,date,favourite,type,creator;

  QR(dynamic obj)
  {id=obj['id'];
  content=obj['content'];
  date=obj['date'];
  type=obj['type'];
  favourite=obj['favourite'];
  creator=obj['creator'];

  }
  QR.fromMap(Map<String,dynamic> data)
  {id=data['id'];
  content=data['content'];
  date=data['date'];
  type=data['type'];
  favourite=data['favourite'];
  creator=data['creator'];
  }
  Map<String,dynamic> toMap()=>{'id':id,'content':content,'date':date,'type':type,'favourite':favourite,'creator':creator };
}