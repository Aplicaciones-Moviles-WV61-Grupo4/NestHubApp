import 'package:nesthub/features/review/data/remote/review_dto.dart';

class Review {
  final int id;
  final int rating;
  final String comment;

  Review({
    required this.id,
    required this.rating,
    required this.comment,
  });

  // Crear una instancia de Review desde un ReviewDto
  factory Review.fromDto(ReviewDto dto) {
    return Review(
      id: dto.id,
      rating: dto.rating,
      comment: dto.comment,
    );
  }
}
