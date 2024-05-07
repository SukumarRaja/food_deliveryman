// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_deliveryman/app/config/constants.dart';
import 'package:food_deliveryman/app/data/models/driver.dart';
import 'package:food_deliveryman/app/services/profile.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../providers/profile.dart';
import '../../../services/image.dart';
import '../../../utility/colors.dart';
import '../../../utility/text_styles.dart';
import '../../widgets/common_button.dart';
import '../../widgets/textfield.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController vehicleRegistrationNumberController =
      TextEditingController();
  final TextEditingController drivingLicenseNumberController =
      TextEditingController();

  ///variable
  bool buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        children: [
          SizedBox(height: 2.h),
          Consumer<ProfileProvider>(builder: (context, provider, child) {
            return InkWell(
              onTap: () {
                provider.pickUserImageFromGallery(context);
              },
              child: CircleAvatar(
                radius: 5.h,
                backgroundColor: black,
                child: CircleAvatar(
                  backgroundColor: white,
                  radius: 5.h - 2,
                  backgroundImage: provider.profileImage == null
                      ? null
                      : FileImage(provider.profileImage!),
                  child: Builder(builder: (context) {
                    if (provider.profileImage == null) {
                      return FaIcon(FontAwesomeIcons.user,
                          color: black, size: 4.h);
                    } else {
                      return const SizedBox();
                    }
                  }),
                ),
              ),
            );
          }),
          SizedBox(height: 3.h),
          CommonTextFomField(
              controller: nameController,
              title: "Name",
              hintText: "Enter your name",
              keyboardType: TextInputType.text),
          SizedBox(height: 1.h),
          CommonTextFomField(
              controller: vehicleRegistrationNumberController,
              title: "Vehicle Registration Number",
              hintText: "Registration Number",
              keyboardType: TextInputType.text),
          SizedBox(height: 1.h),
          CommonTextFomField(
              controller: drivingLicenseNumberController,
              title: "License Number",
              hintText: "Driving License Number",
              keyboardType: TextInputType.text),
          SizedBox(height: 3.h),
          CommonButton(
              child: buttonPressed
                  ? CircularProgressIndicator(color: white)
                  : Text(
                      "Register",
                      style: AppTextStyles.body16Bold.copyWith(color: white),
                    ),
              onPressed: () async {
                setState(() {
                  buttonPressed = true;
                });

                await context
                    .read<ProfileProvider>()
                    .uploadImageAndGetImageUrl(context);

                ///user data
                DriverModel driverData = DriverModel(
                  name: nameController.text.trim(),
                  profilePicUrl:
                      context.read<ProfileProvider>().profileImageUrl,
                  mobileNumber: auth.currentUser!.phoneNumber,
                  driverId: auth.currentUser!.uid,
                  vehicleRegistrationNumber:
                      vehicleRegistrationNumberController.text.trim(),
                  drivingLicenseNumber:
                      drivingLicenseNumberController.text.trim(),
                  registeredDateTime: DateTime.now().millisecondsSinceEpoch,
                  activeDeliveryRequestId: "1",
                  driverStatus: "1",
                  cloudMessagingToken: "1",
                );

                // /// current location
                // Position location =
                // await LocationServices.getCurrentLocation();
                //
                // /// user address data
                // var addressId = const Uuid().v1().toString();
                //
                // UserAddressModel addressData = UserAddressModel(
                //     addressId: addressId,
                //     userId: auth.currentUser!.uid,
                //     latitude: location.latitude,
                //     longitude: location.longitude,
                //     roomNo: houseController.text.trim(),
                //     apartment: apartmentController.text.trim(),
                //     addressTitle: saveAddressController.text.trim(),
                //     uploadTime: DateTime.now(),
                //     isActive: true);
                //
                // /// save user address
                // await UserDataCrudServices.addAddress(context, addressData);
                //
                /// register driver
                ProfileServices.registerDriver(driverData, context);
              })
        ],
      ),
    ));
  }
}
