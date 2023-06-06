import 'package:flutter/material.dart';

import '../constants/constants.dart';
class LoadingComponent extends StatelessWidget {
  const LoadingComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/group_logo.png', scale: 3,),
          const Text('Loading...', style: TextStyle(
            color: kMainThemeAppColor,
            fontSize: 25,
          ),),
        ],
      ),
    );
  }
}