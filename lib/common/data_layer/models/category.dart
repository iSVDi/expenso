import "package:objectbox/objectbox.dart";

@Entity()
class Category {
  @Id()
  int id = 0;
  String title;

  Category({
    required this.title,
  });

  @override
  bool operator ==(Object other) {
    return other is Category && id == other.id && title == other.title;
  }

  @override
  int get hashCode {
    return Object.hash(id, title);
  }
}
