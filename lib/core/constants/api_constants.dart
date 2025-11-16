class ApiConstants {
  //if the back-end on server
  //static const String baseUrl = "http://127.0.0.1:8000/api";
  static const String baseUrl = "http://10.0.2.2:8000/api";

  // Auth
  static const String loginUrl = "/login";
  static const String registerUrl = "/register";
  static const String verifyOtpUrl = "/verify-otp";

  // Complaints
  static const String addComplaintUrl = "/store/complaint";
  static const String getGovEntitiesUrl = "/government-entities";
  static const String getComplaintTypesUrl = "/complaint-types";
}
