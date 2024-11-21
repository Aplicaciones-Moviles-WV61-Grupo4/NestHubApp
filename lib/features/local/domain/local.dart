import 'package:nesthub/features/local/domain/review.dart';

class Local {
  final String district;
  final String street;
  final String title;
  final String city;
  final int price;
  final String photoUrl;
  final String descriptionMessage;
  final int localCategoryId;
  final int userId;
  final List<Review> reviews;

  Local(
      {required this.district,
      required this.street,
      required this.title,
      required this.city,
      required this.price,
      required this.photoUrl,
      required this.descriptionMessage,
      required this.localCategoryId,
      required this.userId,
      this.reviews = const []});

  Map<String, dynamic> toJson() {
    return {
      'district': district,
      'street': street,
      'title': title,
      'city': city,
      'price': price,
      'photoUrl': photoUrl,
      'descriptionMessage': descriptionMessage,
      'localCategoryId': localCategoryId,
      'userId': userId,
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }
}
