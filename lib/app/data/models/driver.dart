class DriverModel {
  dynamic name;
  dynamic profilePicUrl;
  dynamic mobileNumber;
  dynamic driverId;
  dynamic vehicleRegistrationNumber;
  dynamic drivingLicenseNumber;
  dynamic registeredDateTime;
  dynamic activeDeliveryRequestId;
  dynamic driverStatus;
  dynamic cloudMessagingToken;

  DriverModel({
    this.name,
    this.profilePicUrl,
    this.mobileNumber,
    this.driverId,
    this.vehicleRegistrationNumber,
    this.drivingLicenseNumber,
    this.registeredDateTime,
    this.activeDeliveryRequestId,
    this.driverStatus,
    this.cloudMessagingToken,
  });

  factory DriverModel.fromMap(Map<String, dynamic> json) => DriverModel(
        name: json["name"],
        profilePicUrl: json["profilePicUrl"],
        mobileNumber: json["mobileNumber"],
        driverId: json["driverId"],
        vehicleRegistrationNumber: json["vehicleRegistrationNumber"],
        drivingLicenseNumber: json["drivingLicenseNumber"],
        registeredDateTime: json["registeredDateTime"],
        activeDeliveryRequestId: json["activeDeliveryRequestId"],
        driverStatus: json["driverStatus"],
        cloudMessagingToken: json["cloudMessagingToken"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "profilePicUrl": profilePicUrl,
        "mobileNumber": mobileNumber,
        "driverId": driverId,
        "vehicleRegistrationNumber": vehicleRegistrationNumber,
        "drivingLicenseNumber": drivingLicenseNumber,
        "registeredDateTime": registeredDateTime,
        "activeDeliveryRequestId": activeDeliveryRequestId,
        "driverStatus": driverStatus,
        "cloudMessagingToken": cloudMessagingToken,
      };
}
