import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_deliveryman/app/ui/pages/activity.dart';
import 'package:food_deliveryman/app/ui/pages/history.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';
import '../../../utility/colors.dart';
import '../../../utility/text_styles.dart';
import '../account.dart';
import 'home.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // RestaurantServices.getNearbyRestaurants(context);
    });
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const Home(),
      const History(),
      const Account(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: FaIcon(FontAwesomeIcons.house, size: 2.h),
          title: "Home",
          textStyle: AppTextStyles.small8,
          contentPadding: 0,
          activeColorPrimary: black,
          inactiveColorPrimary: grey),
      PersistentBottomNavBarItem(
          icon: FaIcon(FontAwesomeIcons.list, size: 2.h),
          title: "History",
          textStyle: AppTextStyles.small8,
          contentPadding: 0,
          activeColorPrimary: black,
          inactiveColorPrimary: grey),
      PersistentBottomNavBarItem(
          icon: FaIcon(FontAwesomeIcons.person, size: 2.h),
          title: "Account",
          textStyle: AppTextStyles.small8,
          contentPadding: 0,
          activeColorPrimary: black,
          inactiveColorPrimary: grey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }
}
