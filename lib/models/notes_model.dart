import 'package:hive/hive.dart';
part 'notes_model.g.dart';
@HiveType(typeId: 0)
class NotesModel extends HiveObject{
  @HiveField(0)
   String title;
  @HiveField(1)
   String description;
  @HiveField(2)
   int color;
  @HiveField(3)
   DateTime  date;
  @HiveField(4)
   String userId;  
  NotesModel({
    required this.title,
    required this.description,
    required this.color,
    required this.date,
    required this.userId,
  });
}
