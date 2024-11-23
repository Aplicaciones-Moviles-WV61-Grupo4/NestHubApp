class AppConstants {
  static const String baseUrl =
      'https://nesthubplatform-0a5eeee622eb.herokuapp.com/api/v1';
  static const String localsEndpoint = '/locals';
  static const String profilesEndpoint = '/profiles';
  static const String usersEndpoint = '/users';
  static const String loginEndpoint = '/authentication';
  static String reviewFromLocalEndpoint(int localId) =>
      '/review/local/$localId';
}
