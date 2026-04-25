import 'package:aifitness/data/network/api_service.dart';
import 'package:aifitness/repository/RegisterRepository.dart';
import 'package:aifitness/repository/supplement_repository.dart';
import 'package:aifitness/res/widgets/dashboard.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/view/AboutsUs.dart';
import 'package:aifitness/view/AllMeasurementResult.dart';
import 'package:aifitness/view/ContactUs.dart';
import 'package:aifitness/view/DeviceDashboard.dart';
import 'package:aifitness/view/FitNetwork.dart';
import 'package:aifitness/view/MeasurementResult.dart';
import 'package:aifitness/view/PrivacyPolicy.dart';
import 'package:aifitness/view/Target_change_screen.dart';
import 'package:aifitness/view/Visceral_fat_screen.dart';
import 'package:aifitness/view/account_setting_screen.dart';
import 'package:aifitness/view/activity_level_screen.dart';
import 'package:aifitness/view/add_meal_screen.dart';
import 'package:aifitness/view/begin_your_screen.dart';
import 'package:aifitness/view/body_fat_screen.dart';
import 'package:aifitness/view/body_image_progress.dart';
import 'package:aifitness/view/body_water_screen.dart';
import 'package:aifitness/view/change_details.dart';
import 'package:aifitness/view/current_bfp_screen.dart';
import 'package:aifitness/view/diet_type_screen.dart';
import 'package:aifitness/view/exercise_list_details.dart';
import 'package:aifitness/view/exercise_list_screen.dart';
import 'package:aifitness/view/extra_food_intake_screen.dart';
import 'package:aifitness/view/fitness_goal_screen.dart';
import 'package:aifitness/view/get_start_screen.dart';
import 'package:aifitness/view/get_start_screen_view.dart';
import 'package:aifitness/view/height_screen.dart';
import 'package:aifitness/view/i_am_ready.dart';
import 'package:aifitness/view/i_am_ready_final.dart';
import 'package:aifitness/view/login_screen.dart';
import 'package:aifitness/view/muscle_gain.dart';
import 'package:aifitness/view/nutrition_screen.dart';
import 'package:aifitness/view/signin_screen.dart';
import 'package:aifitness/view/signin_screen_eight.dart';
import 'package:aifitness/view/signin_screen_eighteen.dart';
import 'package:aifitness/view/signin_screen_eleventh.dart';
import 'package:aifitness/view/signin_screen_fifteen.dart';
import 'package:aifitness/view/signin_screen_fifth.dart';
import 'package:aifitness/view/signin_screen_fourteen.dart';
import 'package:aifitness/view/signin_screen_fourth.dart';
import 'package:aifitness/view/signin_screen_nineteen.dart';
import 'package:aifitness/view/signin_screen_ninth.dart';
import 'package:aifitness/view/signin_screen_second.dart';
import 'package:aifitness/view/signin_screen_seventeen.dart';
import 'package:aifitness/view/signin_screen_seventh.dart';
import 'package:aifitness/view/signin_screen_sixteen.dart';
import 'package:aifitness/view/signin_screen_sixth.dart';
import 'package:aifitness/view/signin_screen_tenth.dart';
import 'package:aifitness/view/signin_screen_third.dart';
import 'package:aifitness/view/signin_screen_thirteen.dart';
import 'package:aifitness/view/signin_screen_twelve.dart';
import 'package:aifitness/view/signin_screen_twenty.dart';
import 'package:aifitness/view/signin_screen_twenty_five.dart';
import 'package:aifitness/view/signin_screen_twenty_four.dart';
import 'package:aifitness/view/signin_screen_twenty_one.dart';
import 'package:aifitness/view/signin_screen_twenty_six.dart';
import 'package:aifitness/view/signin_screen_twenty_three.dart';
import 'package:aifitness/view/signin_screen_twenty_two.dart';
import 'package:aifitness/view/skeletal_muscle_screen.dart';
import 'package:aifitness/view/splash_screen.dart';
import 'package:aifitness/view/subcutaneous_fat_screen.dart';
import 'package:aifitness/view/target_bfp_screen.dart';
import 'package:aifitness/view/target_change_details.dart';
import 'package:aifitness/view/terms_condition.dart';
import 'package:aifitness/view/video_screen.dart';
import 'package:aifitness/view/view_plan_screen.dart';
import 'package:aifitness/view/walking_steps_todays.dart';
import 'package:aifitness/view/weight_screen.dart';
import 'package:aifitness/view/weight_today_screen.dart';
import 'package:aifitness/view/workout_mode_screen.dart';
import 'package:aifitness/view/works_out_days_screen.dart';
import 'package:aifitness/viewModel/RegisterViewModel.dart';
import 'package:aifitness/viewModel/Visceral_fat_view_model.dart';
import 'package:aifitness/viewModel/account_setting_viewModel.dart';
import 'package:aifitness/viewModel/activity_level_viewModel.dart';
import 'package:aifitness/viewModel/add_meal_viewmodel.dart';
import 'package:aifitness/viewModel/body_image_progress_viewModel.dart';
import 'package:aifitness/viewModel/body_water_view_model.dart';
import 'package:aifitness/viewModel/bodyfat_ViewModel.dart';
import 'package:aifitness/viewModel/change_details_viewModel.dart';
import 'package:aifitness/viewModel/contact_us_viewModel.dart';
import 'package:aifitness/viewModel/current_bfp_ViewModel.dart';
import 'package:aifitness/viewModel/diet_type_ViewModel.dart';
import 'package:aifitness/viewModel/exercise_list_viewModel.dart';
import 'package:aifitness/viewModel/extra_food_intake_viewModel.dart';
import 'package:aifitness/viewModel/fit_network_viewModel.dart';
import 'package:aifitness/viewModel/fitness_goal_viewModel.dart';
import 'package:aifitness/viewModel/hight_viewModel.dart';
import 'package:aifitness/viewModel/i_am_ready_final_viewModel.dart';
import 'package:aifitness/viewModel/i_am_ready_viewModel.dart';
import 'package:aifitness/viewModel/login_viewModel.dart';
import 'package:aifitness/viewModel/nutration_screen_viewModel.dart';
import 'package:aifitness/viewModel/privacy_policy_viewModel.dart';
import 'package:aifitness/viewModel/sigin_eighteen_viewModel.dart';
import 'package:aifitness/viewModel/sigin_fifteen_viewModel.dart';
import 'package:aifitness/viewModel/sigin_foutreen_viewModel.dart';
import 'package:aifitness/viewModel/sigin_seventeen_viewModel.dart';
import 'package:aifitness/viewModel/sigin_sixteen_viewModel.dart';
import 'package:aifitness/viewModel/signin_eight_viewModel.dart';
import 'package:aifitness/viewModel/signin_eleventh_viewModel.dart';
import 'package:aifitness/viewModel/signin_fifth_viewModel.dart';
import 'package:aifitness/viewModel/signin_fourth_viewModel.dart';
import 'package:aifitness/viewModel/signin_nineteen_viewModel.dart';
import 'package:aifitness/viewModel/signin_ninth_viewModel.dart';
import 'package:aifitness/viewModel/signin_second_viewModel.dart';
import 'package:aifitness/viewModel/signin_seventh_viewModel.dart';
import 'package:aifitness/viewModel/signin_sixth_viewModel.dart';
import 'package:aifitness/viewModel/signin_tenth_viewModel.dart';
import 'package:aifitness/viewModel/signin_third_viewModel.dart';
import 'package:aifitness/viewModel/signin_thirteen_viewModel.dart';
import 'package:aifitness/viewModel/signin_twelve_viewModel.dart';
import 'package:aifitness/viewModel/signin_twentyTwo_viewModel.dart';
import 'package:aifitness/viewModel/signin_twenty_viewModel.dart';
import 'package:aifitness/viewModel/signin_twentyfive_viewModel.dart';
import 'package:aifitness/viewModel/signin_twentyone_viewModel.dart';
import 'package:aifitness/viewModel/signin_twentythree_viewModel.dart';
import 'package:aifitness/viewModel/signin_viewmodel.dart';
import 'package:aifitness/viewModel/skeletal_muscle_viewmodel.dart';
import 'package:aifitness/viewModel/splash_screen_viewModel.dart';
import 'package:aifitness/viewModel/subcutaneous_fat_viewmodel.dart';
import 'package:aifitness/viewModel/supplement_provider.dart';
import 'package:aifitness/viewModel/target_bfp_ViewModel.dart';
import 'package:aifitness/viewModel/target_change_details_viewModel.dart';
import 'package:aifitness/viewModel/terms_condition_viewModel.dart';
import 'package:aifitness/viewModel/video_viewModel.dart';
import 'package:aifitness/viewModel/view_plan_viewModel.dart';
import 'package:aifitness/viewModel/walking_steps_view_model.dart';
import 'package:aifitness/viewModel/weight_ViewModel.dart';
import 'package:aifitness/viewModel/weight_today_viewModel.dart';
import 'package:aifitness/viewModel/workout_mode_ViewModel.dart';
import 'package:aifitness/viewModel/workout_view_model.dart';
import 'package:aifitness/viewModel/works_out_days_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case (RouteNames.getStartScreen):
        return MaterialPageRoute(
          builder: (BuildContext context) => const GetStartScreen(),
        );
      // case (RouteNames.signinScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreen(),
      //   );
      case RouteNames.signinScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninViewModel(),
            child: SigninScreen(), // তোমার screen
          ),
        );
      // case (RouteNames.signinScreenSecond):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenSecond(),
      //   );
      case RouteNames.signinScreenSecond:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninSecondViewModel(),
            child: SigninScreenSecond(),
          ),
        );
      // case (RouteNames.signinScreenThird):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenThird(),
      //   );

      case RouteNames.signinScreenThird:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninThirdViewModel(),
            child: SigninScreenThird(),
          ),
        );
      // case (RouteNames.signinScreenFourth):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenFourth(),
      //   );

      case RouteNames.signinScreenFourth:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninFourthViewModel(),
            child: SigninScreenFourth(),
          ),
        );
      // case (RouteNames.signinScreenFifth):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenFifth(),
      //   );

      case RouteNames.signinScreenFifth:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninFifthViewModel(),
            child: SigninScreenFifth(),
          ),
        );
      // case (RouteNames.signinScreenSixth):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenSixth(),
      //   );

      case RouteNames.signinScreenSixth:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninSixthViewModel(),
            child: SigninScreenSixth(),
          ),
        );
      // case (RouteNames.signinScreenSeventh):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenSeventh(),
      //   );
      case RouteNames.signinScreenSeventh:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninSeventhViewModel(),
            child: SigninScreenSeventh(),
          ),
        );
      // case (RouteNames.signinScreenEight):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenEight(),
      //   );
      case RouteNames.signinScreenEight:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninEightViewModel(),
            child: SigninScreenEight(),
          ),
        );
      // case (RouteNames.signinScreenNinth):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenNinth(),
      //   );
      case RouteNames.signinScreenNinth:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninNinthViewModel(),
            child: SigninScreenNinth(),
          ),
        );
      // case (RouteNames.signinScreenTenth):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenTenth(),
      //   );
      case RouteNames.signinScreenTenth:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninTenthViewModel(),
            child: SigninScreenTenth(),
          ),
        );

      // case (RouteNames.loginScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const LoginScreen(),
      //   );
      case RouteNames.loginScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => LoginViewModel(),
            child: LoginScreen(),
          ),
        );
      // case (RouteNames.signinScreenEleventh):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenEleventh(),
      //   );
      case RouteNames.signinScreenEleventh:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninEleventhViewModel(),
            child: SigninScreenEleventh(),
          ),
        );
      // case (RouteNames.signinScreenTwelve):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenTwelve(),
      //   );
      case RouteNames.signinScreenTwelve:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninTwelveViewModel(),
            child: SigninScreenTwelve(),
          ),
        );
      // case (RouteNames.signinScreenThirteen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenThirteen(),
      //   );

      case RouteNames.signinScreenThirteen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninThirteenViewModel(),
            child: SigninScreenThirteen(),
          ),
        );
      // case (RouteNames.signinScreenFourteen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenFourteen(),
      //   );
      case RouteNames.signinScreenFourteen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninFourteenViewModel(),
            child: SigninScreenFourteen(),
          ),
        );
      // case (RouteNames.signinScreenFifteen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenFifteen(),
      //   );
      case RouteNames.signinScreenFifteen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninFifteenViewModel(),
            child: SigninScreenFifteen(),
          ),
        );
      // case (RouteNames.signinScreenSixteen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenSixteen(),
      //   );
      case RouteNames.signinScreenSixteen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninSixteenViewModel(),
            child: SigninScreenSixteen(),
          ),
        );
      // case (RouteNames.signinScreenSeventeen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenSeventeen(),
      //   );
      case RouteNames.signinScreenSeventeen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninSeventeenViewModel(),
            child: SigninScreenSeventeen(),
          ),
        );
      // case (RouteNames.signinScreenEighteen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenEighteen(),
      //   );
      case RouteNames.signinScreenEighteen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninEighteenViewModel(),
            child: SigninScreenEighteen(),
          ),
        );
      // case (RouteNames.signinScreenNineteen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenNineteen(),
      //   );
      case RouteNames.signinScreenNineteen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninNineteenViewModel(),
            child: SigninScreenNineteen(),
          ),
        );
      // case (RouteNames.signinScreenTwenty):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenTwenty(),
      //   );
      case RouteNames.signinScreenTwenty:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninTwentyViewModel(),
            child: SigninScreenTwenty(),
          ),
        );
      // case (RouteNames.signinScreenTwentyOne):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenTwentyOne(),
      //   );
      case RouteNames.signinScreenTwentyOne:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninTwentyOneViewModel(),
            child: SigninScreenTwentyOne(),
          ),
        );
      // case (RouteNames.signinScreenTwentyTwo):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenTwentyTwo(),
      //   );
      case RouteNames.signinScreenTwentyTwo:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninTwentyTwoViewModel(),
            child: SigninScreenTwentyTwo(),
          ),
        );
      // case (RouteNames.signinScreenTwentyThree):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenTwentyThree(),
      //   );
      case RouteNames.signinScreenTwentyThree:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninTwentyThreeViewModel(),
            child: SigninScreenTwentyThree(),
          ),
        );
      // case (RouteNames.signinScreenTwentyFour):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenTwentyFour(),
      //   );
      case RouteNames.signinScreenTwentyFour:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => RegisterViewModel(RegisterRepository1()),
            child: SigninScreenTwentyFour(),
          ),
        );
      // case (RouteNames.signinScreenTwentyFive):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenTwentyFive(),
      //   );
      case RouteNames.signinScreenTwentyFive:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninTwentyFiveViewModel(),
            child: SigninScreenTwentyFive(),
          ),
        );
      case (RouteNames.dashboard):
        return MaterialPageRoute(
          builder: (BuildContext context) => const Dashboard(),
        );
      //  case RouteNames.dashboard:
      //   return MaterialPageRoute(
      //     builder: (_) => ChangeNotifierProvider(
      //       create: (_) => SigninTwentyFiveViewModel(),
      //       child: Dashboard(),
      //     ),
      //   );

      // case (RouteNames.extraFoodIntakeScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const ExtraFoodIntakeScreen(),
      //   );
      case RouteNames.extraFoodIntakeScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => ExtraFoodIntakeViewModel(),
            child: ExtraFoodIntakeScreen(),
          ),
        );
      // case (RouteNames.weightTodayScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const WeightTodayScreen(),
      //   );
      case RouteNames.weightTodayScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => WeightTodayViewModel(),
            child: WeightTodayScreen(),
          ),
        );
      // case (RouteNames.targetChangeDetails):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const TargetChangeDetails(),
      //   );
      case RouteNames.targetChangeDetails:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => TargetChangeDetailsViewModel(),
            child: TargetChangeDetails(),
          ),
        );
      // case (RouteNames.changeDetails):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const ChangeDetails(),
      //   );
      case RouteNames.changeDetails:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => ChangeDetailsViewModel(),
            child: ChangeDetails(),
          ),
        );
      // case (RouteNames.bodyImageProgress):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const BodyImageProgress(),
      //   );
      case RouteNames.bodyImageProgress:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => BodyImageProgressViewModel(),
            child: BodyImageProgress(),
          ),
        );
      // case (RouteNames.accountSettingScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const AccountSettingScreen(),
      //   );
      case RouteNames.accountSettingScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => AccountSettingViewModel(),
            child: AccountSettingScreen(),
          ),
        );
      // case (RouteNames.nutritionScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const NutritionScreen(),
      //   );
      case RouteNames.nutritionScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => NutritionScreenViewModel(),
            child: NutritionScreen(),
          ),
        );
      // case (RouteNames.viewPlanScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const ViewPlanScreen(),
      //   );
      case RouteNames.viewPlanScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => ViewPlanViewModel(),
            child: ViewPlanScreen(),
          ),
        );
      // case (RouteNames.exerciseListScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const ExerciseListScreen(),
      //   );
      case RouteNames.exerciseListScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => ExerciseListViewModel(),
            child: ExerciseListScreen(),
          ),
        );
      // case (RouteNames.exerciseListDetails):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const ExerciseListDetails(),
      //   );
      case RouteNames.exerciseListDetails:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => WorkoutViewModel(),
            child: ExerciseListDetails(),
          ),
        );
      // case (RouteNames.videoScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const VideoScreen(),
      //   );
      case RouteNames.videoScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => VideoViewModel(),
            child: VideoScreen(),
          ),
        );
      // case (RouteNames.iamReady):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const IamReady(),
      //   );
      case RouteNames.iamReady:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => IamReadyViewModel(),
            child: IamReady(),
          ),
        );
      // case (RouteNames.iamReadyFinal):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const IamReadyFinal(),
      //   );
      case RouteNames.iamReadyFinal:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => IamReadyFinalViewModel(),
            child: const IamReadyFinal(), // তোমার screen
          ),
        );
      // case (RouteNames.muscleGain):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const MuscleGainScreen(),
      //   );
      case RouteNames.muscleGain:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SigninThirteenViewModel(),
            child: MuscleGainScreen(),
          ),
        );
      // case (RouteNames.bodyFatScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const BodyFatScreen(),
      //   );
      case RouteNames.bodyFatScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => BodyFatViewModel(),
            child: BodyFatScreen(),
          ),
        );
      // case (RouteNames.skeletalMuscleScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SkeletalMuscleScreen(),
      //   );
      case RouteNames.skeletalMuscleScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SkeletalMuscleViewModel(),
            child: SkeletalMuscleScreen(),
          ),
        );
      // case (RouteNames.subcutaneousFatScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SubcutaneousFatScreen(),
      //   );
      case RouteNames.subcutaneousFatScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SubcutaneousFatViewModel(),
            child: SubcutaneousFatScreen(),
          ),
        );
      // case (RouteNames.visceralFatScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const VisceralFatScreen(),
      //   );
      case RouteNames.visceralFatScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => VisceralFatViewModel(),
            child: VisceralFatScreen(),
          ),
        );
      // case (RouteNames.bodyWaterScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const BodyWaterScreen(),
      //   );
      case RouteNames.bodyWaterScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => BodyWaterViewModel(),
            child: BodyWaterScreen(),
          ),
        );
      // case (RouteNames.fitNetwork):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const FitNetwork(),
      //   );
      case RouteNames.fitNetwork:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => FitNetworkViewModel(),
            child: FitNetwork(),
          ),
        );
      // case (RouteNames.contactUs):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const ContactUs(),
      //   );
      case RouteNames.contactUs:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => ContactUsViewModel(),
            child: ContactUs(),
          ),
        );
      // case (RouteNames.privacyPolicy):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const PrivacyPolicy(),
      //   );
      case RouteNames.privacyPolicy:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => PrivacyPolicyViewModel(),
            child: PrivacyPolicy(),
          ),
        );
      // case (RouteNames.termsCondition):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const TermsCondition(),
      //   );
      case RouteNames.termsCondition:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => TermsConditionViewModel(),
            child: TermsCondition(),
          ),
        );
      // case (RouteNames.splashScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SplashScreen(),
      //   );
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SplashScreenViewModel(),
            child: SplashScreen(),
          ),
        );
      case (RouteNames.beginYourScreen):
        return MaterialPageRoute(
          builder: (BuildContext context) => const BeginYourScreen(),
        );
      // case RouteNames.beginYourScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => ChangeNotifierProvider(
      //       create: (_) => SplashScreenViewModel(),
      //       child: BeginYourScreen(),
      //     ),
      //   );
      case (RouteNames.aboutsUs):
        return MaterialPageRoute(
          builder: (BuildContext context) => const AboutUs(),
        );

      // case (RouteNames.heightScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const HeightScreen(),
      //   );
      case RouteNames.heightScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => HightViewModel(),
            child: HeightScreen(),
          ),
        );
      // case (RouteNames.weightScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const WeightScreen(),
      //   );
      case RouteNames.weightScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => WeightViewModel(),
            child: WeightScreen(),
          ),
        );
      // case (RouteNames.fitnessGoalScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const FitnessGoalScreen(),
      //   );
      case RouteNames.fitnessGoalScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => FitnessGoalSelectionViewModel(),
            child: FitnessGoalScreen(),
          ),
        );
      // case (RouteNames.activityLevelScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const ActivityLevelScreen(),
      //   );
      case RouteNames.activityLevelScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => ActivityLevelViewModel(),
            child: ActivityLevelScreen(),
          ),
        );
      // case (RouteNames.currentBfpScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const CurrentBfpScreen(),
      //   );
      case RouteNames.currentBfpScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => CurrentBFPViewModel(),
            child: CurrentBfpScreen(),
          ),
        );
      // case (RouteNames.targetBfpScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const TargetBfpScreen(),
      //   );
      case RouteNames.targetBfpScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => TargetBFPViewModel(),
            child: TargetBfpScreen(),
          ),
        );
      // case (RouteNames.worksOutDaysScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const WorksOutDaysScreen(),
      //   );
      case RouteNames.worksOutDaysScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => WorksOutDaysViewModel(),
            child: WorksOutDaysScreen(),
          ),
        );
      // case (RouteNames.workoutModeScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const WorkoutModeScreen(),
      //   );
      case RouteNames.workoutModeScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => WorkoutModeViewModel(),
            child: WorkoutModeScreen(),
          ),
        );
      // case (RouteNames.dietTypeScreen):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const DietTypeScreen(),
      //   );
      case RouteNames.dietTypeScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => DietTypeViewModel(),
            child: DietTypeScreen(),
          ),
        );
      // case (RouteNames.signinScreenTwentySix):
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SigninScreenTwentySix(),
      //   );
      case RouteNames.signinScreenTwentySix:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) =>
                SupplementProvider(SupplementRepository(ApiService())),
            child: SigninScreenTwentySix(),
          ),
        );
      case (RouteNames.addMealScreen):
        return MaterialPageRoute(
          builder: (BuildContext context) => const AddMealScreen(),
        );
      // case RouteNames.addMealScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => ChangeNotifierProvider(
      //       create: (_) => AddMealViewModel(),
      //       child: AddMealScreen(),
      //     ),
      //   );
      case (RouteNames.walkingStepsTodays):
        return MaterialPageRoute(
          builder: (BuildContext context) => const WalkingStepsTodays(),
        );
      // case RouteNames.walkingStepsTodays:
      //   return MaterialPageRoute(
      //     builder: (_) => ChangeNotifierProvider(
      //       create: (_) => WalkingStepsViewModel(),
      //       child: WalkingStepsTodays(),
      //     ),
      //   );
      case (RouteNames.deviceDashboard):
        return MaterialPageRoute(
          builder: (BuildContext context) => const DeviceDashboard(),
        );
      // case RouteNames.deviceDashboard:
      //   return MaterialPageRoute(
      //     builder: (_) => ChangeNotifierProvider(
      //       create: (_) => WalkingStepsViewModel(),
      //       child: DeviceDashboard(),
      //     ),
      // );
      case (RouteNames.allMeasurementResult):
        return MaterialPageRoute(
          builder: (BuildContext context) => const AllMeasurementResult(),
        );
      case (RouteNames.measurementResult):
        return MaterialPageRoute(
          builder: (BuildContext context) => const MeasurementResult(),
        );
      case (RouteNames.getStartScreenView):
        return MaterialPageRoute(
          builder: (BuildContext context) => const GetStartScreenView(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("No route is configured")),
          ),
        );
    }
  }
}
