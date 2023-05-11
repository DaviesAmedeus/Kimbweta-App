import 'package:flutter/material.dart';

import '../constants/constants.dart';
class JoinScreen extends StatelessWidget {
  const JoinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Expanded(
            child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blueGrey,
                        Colors.black,

                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    )
                ),
                // child: Row(
                //   children: [
                //     Expanded(
                //       child: Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 70),
                //         child: ElevatedButton(
                //           onPressed: (){},
                //           child: Text('Create'),
                //           style: ElevatedButton.styleFrom(
                //             backgroundColor: Colors.blueGrey,
                //             padding: EdgeInsets.symmetric(horizontal: 16),
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.all(Radius.circular(25)),
                //             ),
                //           ),
                //         ),
                //       ),
                //     )
                //   ],
                // )
            ),
          ),
        ],
      ),
    );

  }
}