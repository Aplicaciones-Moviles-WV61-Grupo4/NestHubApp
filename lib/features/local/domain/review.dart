class Review {
  final int id;
  final int userId;
  final int localId;
  final int rating;
  final String comment;

  Review({
    required this.id,
    required this.userId,
    required this.localId,
    required this.rating,
    required this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      localId: json['localId'] ?? 0,
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
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
