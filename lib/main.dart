import 'package:aifitness/data/network/api_service.dart';
import 'package:aifitness/repository/supplement_repository.dart';
import 'package:aifitness/utils/routes/routes.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/utils/shared_prefs_helper.dart';
import 'package:aifitness/view/Target_change_screen.dart';
import 'package:aifitness/view/body_image_progress.dart';
import 'package:aifitness/view/body_water_screen.dart';
import 'package:aifitness/view/extra_food_intake_screen.dart';
import 'package:aifitness/view/get_start_screen.dart';
import 'package:aifitness/view/i_am_ready.dart';
import 'package:aifitness/view/i_am_ready_final.dart';
import 'package:aifitness/view/nutrition_screen.dart';
import 'package:aifitness/view/signin_screen_twenty_five.dart';
import 'package:aifitness/view/signin_screen_twenty_one.dart';
import 'package:aifitness/view/subcutaneous_fat_screen.dart';
import 'package:aifitness/viewModel/AddExerciseTrackerViewModel.dart';
import 'package:aifitness/viewModel/Visceral_fat_view_model.dart';
import 'package:aifitness/viewModel/account_delete_ViewModel.dart';
import 'package:aifitness/viewModel/account_setting_viewModel.dart';
import 'package:aifitness/viewModel/activity_level_viewModel.dart';
import 'package:aifitness/viewModel/add_meal_viewmodel.dart';
import 'package:aifitness/viewModel/begin_your_viewModel.dart';
import 'package:aifitness/viewModel/body_fat_viewModel.dart';
import 'package:aifitness/viewModel/body_image_progress_viewModel.dart';
import 'package:aifitness/viewModel/body_water_view_model.dart';
import 'package:aifitness/viewModel/change_details_viewModel.dart';
import 'package:aifitness/viewModel/contact_us_viewModel.dart';
import 'package:aifitness/viewModel/current_bfp_ViewModel.dart';
import 'package:aifitness/viewModel/dashboardBody_viewModel.dart';
import 'package:aifitness/viewModel/diet_type_ViewModel.dart';
import 'package:aifitness/viewModel/exercise_list_details_viewModel.dart';
import 'package:aifitness/viewModel/exercise_list_viewModel.dart';
import 'package:aifitness/viewModel/exercise_tracker_viewmodel.dart';
import 'package:aifitness/viewModel/extra_food_intake_viewModel.dart';
import 'package:aifitness/viewModel/fit_network_viewModel.dart';
import 'package:aifitness/viewModel/fitness_goal_viewModel.dart';
import 'package:aifitness/viewModel/hight_viewModel.dart';
import 'package:aifitness/viewModel/i_am_ready_final_viewModel.dart';
import 'package:aifitness/viewModel/i_am_ready_viewModel.dart';
import 'package:aifitness/viewModel/login_viewModel.dart';
import 'package:aifitness/viewModel/nutration_screen_viewModel.dart';
import 'package:aifitness/viewModel/nutrition_plan_viewmodel.dart';
import 'package:aifitness/viewModel/privacy_policy_viewModel.dart';
import 'package:aifitness/viewModel/sigin_eighteen_viewModel.dart';
import 'package:aifitness/viewModel/sigin_fifteen_viewModel.dart';
import 'package:aifitness/viewModel/sigin_foutreen_viewModel.dart';
import 'package:aifitness/viewModel/sigin_seventeen_viewModel.dart';
import 'package:aifitness/viewModel/sigin_sixteen_viewModel.dart';
import 'package:aifitness/viewModel/signin_eight_viewModel.dart';
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
import 'package:aifitness/viewModel/signin_twentyfour_viewModel.dart';
import 'package:aifitness/viewModel/signin_twentyone_viewModel.dart';
import 'package:aifitness/viewModel/signin_twentythree_viewModel.dart';
import 'package:aifitness/viewModel/signin_viewmodel.dart';
import 'package:aifitness/viewModel/skeletal_muscle_viewmodel.dart';
import 'package:aifitness/viewModel/splash_screen_viewModel.dart';
import 'package:aifitness/viewModel/subcutaneous_fat_viewmodel.dart';
import 'package:aifitness/viewModel/supplement_provider.dart';
import 'package:aifitness/viewModel/targetChangeScreen_viewModel.dart';
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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future<void> main() async {
   if (kReleaseMode) {
    debugPrint("🚀 RELEASE MODE RUNNING");
  } else {
    debugPrint("🐞 DEBUG MODE RUNNING");
  }

  WidgetsFlutterBinding.ensureInitialized();

  // Register platform-specific WebView implementation
  WidgetsFlutterBinding.ensureInitialized();

  // Register WebView implementation
  if (defaultTargetPlatform == TargetPlatform.android) {
    WebViewPlatform.instance = AndroidWebViewPlatform();
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    WebViewPlatform.instance = WebKitWebViewPlatform();
  }
  await SharedPrefsHelper.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SigninViewModel()),
        ChangeNotifierProvider(create: (_) => SigninSecondViewModel()),
        ChangeNotifierProvider(create: (_) => SigninThirdViewModel()),
        ChangeNotifierProvider(create: (_) => SigninFourthViewModel()),
        ChangeNotifierProvider(create: (_) => SigninFifthViewModel()),
        ChangeNotifierProvider(create: (_) => SigninSixthViewModel()),
        ChangeNotifierProvider(create: (_) => SigninSeventhViewModel()),
        ChangeNotifierProvider(create: (_) => SigninEightViewModel()),
        ChangeNotifierProvider(create: (_) => SigninNinthViewModel()),
        ChangeNotifierProvider(create: (_) => SigninTenthViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SigninEightViewModel()),
        ChangeNotifierProvider(create: (_) => SigninTwelveViewModel()),
        ChangeNotifierProvider(create: (_) => SigninThirteenViewModel()),
        ChangeNotifierProvider(create: (_) => SigninFourteenViewModel()),
        ChangeNotifierProvider(create: (_) => SigninFifteenViewModel()),
        ChangeNotifierProvider(create: (_) => SigninSixteenViewModel()),
        ChangeNotifierProvider(create: (_) => SigninSeventeenViewModel()),
        ChangeNotifierProvider(create: (_) => SigninEighteenViewModel()),
        ChangeNotifierProvider(create: (_) => SigninNineteenViewModel()),
        ChangeNotifierProvider(create: (_) => SigninTwentyViewModel()),
        ChangeNotifierProvider(create: (_) => SigninTwentyOneViewModel()),
        ChangeNotifierProvider(create: (_) => SigninTwentyTwoViewModel()),
        ChangeNotifierProvider(create: (_) => SigninTwentyThreeViewModel()),
        ChangeNotifierProvider(create: (_) => SigninTwentyFourViewModel()),
        ChangeNotifierProvider(create: (_) => SigninTwentyFiveViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardBodyViewModel()),
        ChangeNotifierProvider(create: (_) => ExtraFoodIntakeViewModel()),
        ChangeNotifierProvider(create: (_) => WeightTodayViewModel()),
        ChangeNotifierProvider(create: (_) => TargetChangeScreenViewModel()),
        ChangeNotifierProvider(create: (_) => ChangeDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => BodyImageProgressViewModel()),
        ChangeNotifierProvider(create: (_) => AccountSettingViewModel()),
        ChangeNotifierProvider(create: (_) => NutritionScreenViewModel()),
        ChangeNotifierProvider(create: (_) => ViewPlanViewModel()),
        ChangeNotifierProvider(create: (_) => NutritionPlanViewModel()),
        ChangeNotifierProvider(create: (_) => ExerciseListViewModel()),
        ChangeNotifierProvider(create: (_) => WorkoutViewModel()),
        ChangeNotifierProvider(create: (_) => VideoViewModel()),
        ChangeNotifierProvider(create: (_) => IamReadyViewModel()),
        ChangeNotifierProvider(create: (_) => IamReadyFinalViewModel()),
        ChangeNotifierProvider(create: (_) => BodyFatViewModel()),
        ChangeNotifierProvider(create: (_) => SkeletalMuscleViewModel()),
        ChangeNotifierProvider(create: (_) => SubcutaneousFatViewModel()),
        ChangeNotifierProvider(create: (_) => VisceralFatViewModel()),
        ChangeNotifierProvider(create: (_) => BodyWaterViewModel()),
        ChangeNotifierProvider(create: (_) => ExerciseTrackerViewModel()),
        ChangeNotifierProvider(create: (_) => AddExerciseTrackerViewModel()),
        ChangeNotifierProvider(create: (_) => FitNetworkViewModel()),
        ChangeNotifierProvider(create: (_) => TargetChangeDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => ContactUsViewModel()),
        ChangeNotifierProvider(create: (_) => PrivacyPolicyViewModel()),
        ChangeNotifierProvider(create: (_) => TermsConditionViewModel()),
        ChangeNotifierProvider(create: (_) => TermsConditionViewModel()),
        ChangeNotifierProvider(create: (_) => AccountDeleteViewModel()),
        ChangeNotifierProvider(create: (_) => HightViewModel()),
        ChangeNotifierProvider(create: (_) => WeightViewModel()),
        ChangeNotifierProvider(create: (_) => FitnessGoalSelectionViewModel()),
        ChangeNotifierProvider(create: (_) => ActivityLevelViewModel()),
        ChangeNotifierProvider(create: (_) => CurrentBFPViewModel()),
        ChangeNotifierProvider(create: (_) => TargetBFPViewModel()),
        ChangeNotifierProvider(create: (_) => WorksOutDaysViewModel()),
        ChangeNotifierProvider(create: (_) => WorkoutModeViewModel()),
        ChangeNotifierProvider(create: (_) => DietTypeViewModel()),
        ChangeNotifierProvider(create: (_) => BodyFatViewModel()),
        ChangeNotifierProvider(create: (_) => BeginYourViewModel()),
        ChangeNotifierProvider(create: (_) => SplashScreenViewModel()),
        ChangeNotifierProvider(
          create: (_) => SupplementProvider(SupplementRepository(ApiService())),
        ),
        ChangeNotifierProvider(create: (_) => AddMealViewModel()),
        ChangeNotifierProvider(create: (_) => WalkingStepsViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: RouteNames.splashScreen,
      onGenerateRoute: Routes.generateRoutes,
      //  This ensures everything is RTL
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
    );
  }
}
