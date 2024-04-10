package co.itfusion.data;

public class EndPoint {

    public static class Responses {
        public static String SUCCESS = "success";
        public static String TRUE = "true";
    }

    public static class Request {
        public static  String POST = "POST";
    }

    public static class Login {

        public static String URL_LOGIN = "https://protegeme.com.co:8098/auth/login";

        public static String getLogin(String user, String password) {
            return String.format("user=%s&password=%s", user, password);
        }

    }

    public static class Location2 {
        public static String URL_LOCATION = "https://protegeme.com.co:8098/device/locations2";
    }

    public static class Type {

        public static String CONTENT_TYPE = "Content-Type";
        public static String X_WWW_FORM_URLENCODED = "application/x-www-form-urlencoded";
        public static String TEXT_PLAIN = "text/plain";
        public static String JSON = "application/json";

    }
}
