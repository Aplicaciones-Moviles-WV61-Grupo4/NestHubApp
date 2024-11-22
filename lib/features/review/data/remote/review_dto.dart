class ReviewDto {
  final int id;
  final int userId;
  final int localId;
  final int rating;
  final String comment;

  ReviewDto({
    required this.id,
    required this.userId,
    required this.localId,
    required this.rating,
    required this.comment,
  });

  factory ReviewDto.fromJson(Map<String, dynamic> json) {
    return ReviewDto(
      id: json['id'],
      userId: json['userId'],
      localId: json['localId'],
      rating: json['rating'],
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'localId': localId,
      'rating': rating,
      'comment': comment,
    };
  }
}
