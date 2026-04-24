import 'package:aifitness/viewModel/privacy_policy_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PrivacyPolicyViewModel>(context);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white, // <-- SET BACKGROUND COLOR WHITE
        appBar: AppBar(
          backgroundColor: Colors.white, // <-- White AppBar
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black, // <-- Back button color
          ),
          title: const Text(
            "Privacy Policy",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black, // <-- Title text color
            ),
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            vm.privacyText,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
