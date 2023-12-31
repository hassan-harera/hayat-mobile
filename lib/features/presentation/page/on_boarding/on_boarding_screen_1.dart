import 'package:flutter/material.dart';
import 'package:hayat_eg/shared/component/constants.dart';

class OnBoardingScreen1 extends StatelessWidget {
  const OnBoardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    sizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                vertical: sizeConfig.defaultSize! * 8, horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/OnboardingDonation.jpg',
                    width: double.infinity,
                    height: sizeConfig.defaultSize! * 30,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Donations',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Color(0xff2E2B6D),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Column(
                  children: [
                    Text('Welcome to our donations platform!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.amber,
                        )),
                    Text(' Our vision is a world',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.amber,
                        )),
                    Text('  where donation is further, faster',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.amber,
                        )),
                    Text('and directed to',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.amber,
                        )),
                    Text(' the people most in need',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.amber,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
