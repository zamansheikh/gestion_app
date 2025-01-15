class ApiConstants {
  static const String baseUrl = "http://192.168.10.99:5002/api/v1";
  // static const String imageBaseUrl = "http://10.0.80.45:5002/api/v1";

  static const String signInEndPoint = "/auth/login";
  static  String getPropertyById(String id) => "/property/owner/$id";
  static  String reservationProperty(String id,String startDate, String endDate) => "/property/reservation/room/$id?startDate=$startDate&endDate=$endDate";
}