class noteModel {
  final int? id;
  final String title;
  final String description;
 // final String dates;

  noteModel(
      {this.id,
        required this.title,
         required this.description,
       //  required this.dates,
      });



  noteModel.from_map(Map<String, dynamic>res):
      id=res['id'],
       title=res['title'],
       // dates=res['dates'],
  description=res['description'];



  Map<String ,Object?>to_map(){
    return{
      'id':id,
      'title':title,
      'description':description,
      // 'dates':dates,

    };

  }

}
