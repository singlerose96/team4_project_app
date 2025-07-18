class Poster {
  String name;
  int price;
  String description;
  String category;
  String imagePath;
  DateTime date;
  bool isFavorite = false;

  Poster({
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.imagePath,
    required this.date,
  });
}
