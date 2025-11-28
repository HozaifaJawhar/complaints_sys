class ApiConstants {
  // if you use real device + run the server using this command: php artisan serve --host 0.0.0.0 --port 8000
  static const String baseUrl = "http://192.168.1.28:8000/api";
  // if you use emulator to run the app
  //static const String baseUrl = "http://10.0.2.2:8000/api";

// Auth
  static const String loginUrl = "/login";
  static const String registerUrl = "/register";
  static const String verifyOtpUrl = "/verify-otp";

// Complaints
 //create complaint
  static const String addComplaintUrl = "/store/complaint";
  static const String getGovEntitiesUrl = "/government-entities";
  static const String getComplaintTypesUrl = "/complaint-types";
 //get coplaints
static const String getComplaintsUrl="/show_all_my_complaints";

}
