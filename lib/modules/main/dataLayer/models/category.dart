import "package:objectbox/objectbox.dart";

@Entity()
class Category {
  @Id()
  int id = 0;
  String title;

  Category({
    required this.title,
  });
}
