import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'login.dart';
import 'register.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),

          /// OVERLAY
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.4),
          ),

          /// LOGO — FadeInUp
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: FadeInUp(
              duration: const Duration(milliseconds: 3000),
              child: Center(
                child: Image.asset(
                  'assets/images/logo_geopresence.png',
                  width: 350,
                ),
              ),
            ),
          ),

          /// BUTTON AREA
          Positioned(
            bottom: 250,
            left: 0,
            right: 0,
            child: Column(
              children: [
                /// LOGIN — SlideInLeft
                SlideInLeft(
                  duration: const Duration(milliseconds: 3000),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF039A53),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: Colors.white,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// REGISTER — SlideInRight
                SlideInRight(
                  duration: const Duration(milliseconds: 3000),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFFF2C94C),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: Color(0xFFF2C94C),
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
