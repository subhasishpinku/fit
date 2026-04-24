import 'package:aifitness/viewModel/terms_condition_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TermsConditionViewModel>(context);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white, // <-- white background
        appBar: AppBar(
          backgroundColor: Colors.white, // <-- white AppBar
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black, // <-- back arrow black
          ),
          title: const Text(
            "Terms & Condition",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black, // <-- title black
            ),
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            vm.termsText,
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
