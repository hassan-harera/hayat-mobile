import 'package:flutter/material.dart';
import 'package:hayat_eg/shared/component/constants.dart';

class OnBoardingScreen2 extends StatelessWidget {
  const OnBoardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                vertical: sizeConfig.defaultSize! * 8, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    './assets/clothesDonation.jpg',
                    height: sizeConfig.defaultSize! * 30,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Clothes Donation',
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
                    Text('Donating clothes is an excellent ',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.amber,
                            fontSize: 20)),
                    Text('way to give back to your community',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.amber,
                          fontSize: 20,
                        )),
                    Text('community and help those who',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.amber,
                          fontSize: 20,
                        )),
                    Text('may not have the means to',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.amber,
                          fontSize: 20,
                        )),
                    Text('purchase new clothing.With your',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.amber,
                          fontSize: 20,
                        )),
                    Text('help,',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.amber,
                          fontSize: 20,
                        )),
                    Text('we can provide warmth, comfort,',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.amber,
                          fontSize: 20,
                        )),
                    Text('and dignity to individuals and',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.amber,
                          fontSize: 20,
                        )),
                    Text('families in need.',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.amber,
                          fontSize: 20,
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
