import "package:objectbox/objectbox.dart";

@Entity()
class Category {
  @Id()
  int id = 0;
  String title;

  Category({
    required this.title,
  });

//TODO? use CategoriesRepository._noCategoryId instead straight out assign id
  @override
  bool operator ==(Object other) {
    return other is Category && id == other.id;
  }

  @override
  int get hashCode {
    return Object.hash(id, title);
  }
}
