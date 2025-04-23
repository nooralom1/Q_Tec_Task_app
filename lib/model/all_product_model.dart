import 'package:hive/hive.dart';

part 'all_product_model.g.dart';

@HiveType(typeId: 0)
class AllProductModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  double? price;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? category;

  @HiveField(5)
  String? image;

  @HiveField(6)
  Rating? rating;

  AllProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory AllProductModel.fromJson(Map<String, dynamic> json) {
    return AllProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "image": image,
    "rating": rating?.toJson(),
  };
}

@HiveType(typeId: 1)
class Rating extends HiveObject {
  @HiveField(0)
  double? rate;

  @HiveField(1)
  int? count;

  Rating({this.rate, this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num?)?.toDouble(),
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "count": count,
  };
}
