// import 'package:flutter/material.dart';

// class AboutUs extends StatelessWidget {
//   const AboutUs({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.ltr,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: const Text(
//             "About Us",
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//           iconTheme: const IconThemeData(color: Colors.black),
//         ),
//         body: Stack(
//           children: [
//             // 🔹 BACKGROUND IMAGE
//             Positioned.fill(
//               child: Image.asset(
//                 "assets/images/cg55.jpg", // your background image path
//                 fit: BoxFit.cover,
//               ),
//             ),

//             // 🔹 MAIN CONTENT (SCROLLABLE)
//             SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _sectionHeader("💪 About Us"),
//                   const SizedBox(height: 10),
//                   const Text(
//                     "Hi, I'm Chandradip Ghosh, a Certified Personal Fitness Trainer and Certified Nutritionist with a deep passion for helping people build healthier, stronger, and more confident lives.",
//                     style: TextStyle(fontSize: 15, height: 1.4),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     "Over the years, I’ve worked with individuals of all fitness levels — from beginners to athletes — designing personalized workout and nutrition plans that truly work. My focus is on creating routines that are sustainable, balanced, and results-driven, helping you feel your best both physically and mentally.",
//                     style: TextStyle(fontSize: 15, height: 1.4),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     "I believe fitness is not just about lifting weights or losing fat — it’s about building a lifestyle that empowers you to move better, eat smarter, and live happier.",
//                     style: TextStyle(fontSize: 15, height: 1.4),
//                   ),

//                   const SizedBox(height: 25),

//                   _sectionHeader("🥗 My Approach"),
//                   const SizedBox(height: 10),
//                   _bullet("Personalized workout plans based on your goals"),
//                   _bullet(
//                     "Balanced nutrition guidance to support your training",
//                   ),
//                   _bullet("Mindset and motivation to help you stay consistent"),
//                   _bullet(
//                     "Real results through simple, effective, and practical methods",
//                   ),

//                   const SizedBox(height: 25),

//                   _sectionHeader("🎓 My Certifications"),
//                   const SizedBox(height: 10),

//                   const Text(
//                     "• Certified Personal Fitness Trainer",
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 8),
//                   _certificateImage("assets/images/cerP.png"),
//                   const SizedBox(height: 20),

//                   const Text(
//                     "• Certified Nutritionist",
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 8),
//                   _certificateImage("assets/images/cerN.png"),

//                   const SizedBox(height: 30),

//                   _sectionHeader("❤️ My Mission"),
//                   const SizedBox(height: 10),
//                   const Text(
//                     "To inspire and guide you toward achieving your fitness goals while creating a healthy, confident, and sustainable lifestyle. My aim is to make fitness accessible and enjoyable for everyone.",
//                     style: TextStyle(fontSize: 15, height: 1.4),
//                   ),

//                   const SizedBox(height: 50),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   //---------------------------------------------------------
//   // SECTION HEADER WIDGET
//   //---------------------------------------------------------
//   Widget _sectionHeader(String title) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.blue.shade100,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   //---------------------------------------------------------
//   // BULLET LIST WIDGET
//   //---------------------------------------------------------
//   Widget _bullet(String text) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("•  ", style: TextStyle(fontSize: 18)),
//         Expanded(
//           child: Text(text, style: const TextStyle(fontSize: 15, height: 1.4)),
//         ),
//       ],
//     );
//   }

//   //---------------------------------------------------------
//   // CERTIFICATE IMAGE WIDGET
//   //---------------------------------------------------------
//   Widget _certificateImage(String path) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12),
//       child: Image.asset(path, fit: BoxFit.cover),
//     );
//   }
// }
import 'dart:ui';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("About Us"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Stack(
          children: [
            /// Background
            Positioned.fill(
              child: Image.asset(
                "assets/images/cg55.jpg",
                fit: BoxFit.cover,
              ),
            ),

            /// Blur overlay
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(color: Colors.white.withOpacity(0.7)),
              ),
            ),

            /// Content
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle("💪 About Us – Fit Amplify"),
                  _text(
                      "Welcome to Fit Amplify — your all-in-one fitness and wellness companion designed to help you build a stronger, healthier, and more confident version of yourself."),
                  _text(
                      "At Fit Amplify, we believe fitness is not just about workouts or diets — it’s about creating a sustainable lifestyle that fits seamlessly into your daily routine. Our goal is to simplify fitness and make it accessible, effective, and enjoyable for everyone, no matter your starting point."),
                  _text(
                      "We combine expert-backed training methods with smart, personalized guidance to support your unique fitness journey. Whether you're a beginner taking your first step or someone looking to level up your performance, Fit Amplify is here to guide you every step of the way."),

                  const SizedBox(height: 20),

                  /// NEW SECTION (from image)
                  // _sectionTitle("🎯 Your Goals"),
                  // _bullet("Balanced nutrition guidance to support your training"),
                  // _bullet("Mindset and motivation to help you stay consistent"),
                  // _bullet("Real results through simple, effective, and practical methods"),

                  const SizedBox(height: 20),

                  _sectionTitle("✨ Who We Are"),
                  _text(
                      "Fit Amplify is a fitness-focused platform built with guidance from certified trainers and nutrition experts. We combine professional knowledge with practical experience to create programs that are easy to follow, effective, and sustainable."),
                  _text(
                      "We understand that every individual is different — that’s why we focus on personalization, ensuring your fitness journey is tailored to your unique goals, body type, and lifestyle."),

                  const SizedBox(height: 20),

                  _sectionTitle("🏆 Our Expertise"),
                  _text(
                      "At Fit Amplify, our strength lies in combining professional knowledge, practical experience, and smart technology to deliver results that truly matter. Every feature and plan is built with a deep understanding of how the human body works, how habits are formed, and what it takes to achieve long-term fitness success."),

                  const SizedBox(height: 20),

                  _sectionTitle("🎓 Certified Fitness Training"),
                  _text(
                      "Our workout plans are designed by certified professionals, focusing on proper form, progressive overload, and injury prevention to help you train safely and effectively."),

                  const SizedBox(height: 20),

                  _sectionTitle("🥗 Science-Based Nutrition"),
                  _text(
                      "We provide balanced and practical nutrition strategies based on real science — not trends or crash diets. Our approach focuses on sustainable eating habits that support your workouts, improve energy levels, and help you maintain long-term results."),

                  const SizedBox(height: 20),

                  _sectionTitle("📊 Personalized Approach"),
                  _text(
                      "Your journey is unique. We tailor workouts, nutrition tips, and progress tracking based on your goals, fitness level, and daily routine."),

                  const SizedBox(height: 20),

                  _sectionTitle("🔥 Habit & Consistency Focus"),
                  _text(
                      "We help you stay on track with simple routines, motivation strategies, and consistency-building techniques that turn fitness into a lifestyle."),

                  const SizedBox(height: 20),

                  _sectionTitle("🧠 Mind & Body Balance"),
                  _text(
                      "We believe true fitness includes mental well-being. Our approach promotes confidence, discipline, and a positive mindset along with physical strength."),

                  const SizedBox(height: 20),

                  _sectionTitle("📌 Our Approach"),
                  _bullet("Personalized workout plans based on your goals"),
                  _bullet("Balanced nutrition guidance to support your training"),
                  _bullet("Mindset and motivation to help you stay consistent"),
                  _bullet("Real results through simple, effective, and practical methods"),

                  const SizedBox(height: 20),

                  _sectionTitle("🚀 What Makes Us Different"),
                  _text(
                      "Unlike complicated fitness programs, Fit Amplify focuses on simplicity and results. We remove confusion and provide clear, actionable guidance that fits into your everyday life."),
                  _text(
                      "Our goal is not just to help you achieve short-term results, but to build habits that keep you healthy and fit for the long run."),

                  const SizedBox(height: 20),

                  /// Updated titles
                  _sectionTitle("❤️ Our Mission"),
                  _text(
                      "To empower individuals to take control of their health and transform their lives through simple, effective fitness solutions."),

                  const SizedBox(height: 20),

                  _sectionTitle("🌍 Our Vision"),
                  _text(
                      "To become a trusted global fitness platform that inspires millions to live healthier, stronger, and more confident lives."),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Title
  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Normal Text
  Widget _text(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, height: 1.5),
      ),
    );
  }

  /// Bullet
  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• "),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}