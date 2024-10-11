class ApiConstants {
  // static const String BASE_URL = "http://192.168.29.100:8000/";
  static const String BASE_URL = "https://app.jenatree.com/";
  static const String LOGIN_ENDPOINT = "api/v1/auth/login";
  static const String FIREBASE_LOGIN_ENDPOINT = "api/v1/auth/firebase-login";
  static const String LOGOUT = "api/v1/auth/logout";
  static const String GET_ME = "api/v1/auth/me";
  static const String JOIN_PROJECT = "api/v1/projects/{slug}/join";
  static const String JOIN_PROJECT_ACTIVITY =
      "api/v1/projects/activities/{pk}/join";
  static const String LEAVE_PROJECT = "api/v1/projects/{slug}/leave";
  static const String GET_PROJECTS = "api/v1/projects";
  static const String GET_PROJECTS_ACTIVITUES =
      "api/v1/projects/{slug}/activities";
  static const String GET_USER_ACTIVITIES = "api/v1/projects/activities/me";

  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;
}
