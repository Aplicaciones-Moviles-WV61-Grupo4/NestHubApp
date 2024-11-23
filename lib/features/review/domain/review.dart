import 'package:nesthub/features/review/data/remote/review_dto.dart';

class Review {
  final int id;
  final int rating;
  final String comment;

  Review({
    this.id = 0,
    required this.rating,
    required this.comment,
  });

  factory Review.fromDto(ReviewDto dto) {
    return Review(
      id: dto.id,
      rating: dto.rating,
      comment: dto.comment,
    );
  }
}
