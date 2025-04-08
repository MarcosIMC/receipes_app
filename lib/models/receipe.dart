class Receipe {
  final String id;
  final String title;
  final String description;
  final List<String> ingredients;
  final String imageUrl;
  bool isFavorite;

  Receipe({required this.id, required this.title, required this.description, required this.ingredients,
    required this.imageUrl, required this.isFavorite});


}