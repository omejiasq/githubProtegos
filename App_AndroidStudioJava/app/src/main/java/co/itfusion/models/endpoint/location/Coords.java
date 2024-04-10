package co.itfusion.models.endpoint.location;

public class Coords {
    protected double latitude = 0.0;
    protected double longitude = 0.0;
    protected double accuracy = 14.4;
    protected float speed = -1;
    protected int speed_accuracy = -1;
    protected int heading = -1;
    protected int heading_accuracy = -1;
    protected double altitude = 2575.9;
    protected double ellipsoidal_altitude = 2575.9;
    protected int altitude_accuracy = 1;
    protected int age = 85;

    public Coords() {
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public double getAccuracy() {
        return accuracy;
    }

    public void setAccuracy(double accuracy) {
        this.accuracy = accuracy;
    }

    public float getSpeed() {
        return speed;
    }

    public void setSpeed(float speed) {
        this.speed = speed;
    }

    public int getSpeed_accuracy() {
        return speed_accuracy;
    }

    public void setSpeed_accuracy(int speed_accuracy) {
        this.speed_accuracy = speed_accuracy;
    }

    public int getHeading() {
        return heading;
    }

    public void setHeading(int heading) {
        this.heading = heading;
    }

    public int getHeading_accuracy() {
        return heading_accuracy;
    }

    public void setHeading_accuracy(int heading_accuracy) {
        this.heading_accuracy = heading_accuracy;
    }

    public double getAltitude() {
        return altitude;
    }

    public void setAltitude(double altitude) {
        this.altitude = altitude;
    }

    public double getEllipsoidal_altitude() {
        return ellipsoidal_altitude;
    }

    public void setEllipsoidal_altitude(double ellipsoidal_altitude) {
        this.ellipsoidal_altitude = ellipsoidal_altitude;
    }

    public int getAltitude_accuracy() {
        return altitude_accuracy;
    }

    public void setAltitude_accuracy(int altitude_accuracy) {
        this.altitude_accuracy = altitude_accuracy;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }
}
