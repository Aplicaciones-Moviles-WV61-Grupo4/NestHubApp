import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nesthub/core/app_constants.dart';
import 'package:nesthub/features/review/data/remote/review_dto.dart';
import 'package:nesthub/features/review/domain/review.dart';

class ReviewService {
  Future<List<Review>> getReviewsByLocal(int localId) async {
    final String url =
        AppConstants.baseUrl + AppConstants.reviewFromLocalEndpoint(localId);

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        return data.map((json) {
          ReviewDto dto = ReviewDto.fromJson(json);
          return Review.fromDto(dto);
        }).toList();
      } else {
        throw Exception('Failed to load reviews');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error al obtener reseñas');
    }
  }

  Future<void> addReview(ReviewDto reviewDto) async {
    final String url = AppConstants.baseUrl + AppConstants.addReviewEndpoint;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(reviewDto.toJson()),
      );

      if (response.statusCode == 201) {
        print('Review added successfully');
      } else {
        print('Failed to add review: ${response.body}');
        throw Exception('Failed to add review');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error al agregar reseña');
    }
  }
}
