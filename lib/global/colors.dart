import 'package:flutter/material.dart';

//white_varient
Color neo_theme_white0 = Colors.white; //PureWhite
Color neo_theme_white1 = Color.fromRGBO(246, 247, 249, 1); //BG-White-Fade
Color neo_theme_white2 = Color.fromRGBO(255, 255, 255, 0.2); //Grd-White-Fade

//grey_varient
Color neo_theme_grey0 = Color.fromRGBO(233, 234, 238, 1);
Color neo_theme_grey1 = Color.fromRGBO(204, 204, 204, 1);
Color neo_theme_grey2 = Color.fromRGBO(127, 127, 127, 1);
//blue_varient
Color neo_theme_blue0 = Color.fromRGBO(25, 103, 210, 1); //main-lite-blue
Color neo_theme_blue1 = Color.fromRGBO(104, 168, 255, 1);
Color neo_theme_blue2 = Color.fromRGBO(76, 129, 201, 1);
Color neo_theme_blue3 = Color.fromRGBO(56, 67, 113, 1); //main-dark-blue
Color neo_theme_blue4 = Color.fromRGBO(219, 232, 250, 1);
//green_varient
Color neo_theme_green0 = Color.fromRGBO(76, 191, 80, 1);

//neo_gradient
LinearGradient neo_theme_gradient = LinearGradient(
    colors: [Color.fromRGBO(0, 64, 152, 1), Color.fromRGBO(89, 159, 255, 1)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter);





// class Demo extends StatefulWidget {
//   const Demo({super.key});

//   @override
//   State<Demo> createState() => _DemoState();
// }

// class _DemoState extends State<Demo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return Container(
//             decoration: BoxDecoration(gradient: background_gradient),
//             child: SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight: constraints.maxHeight, // Ensures full height
//                 ),
//                 child: Column(
//                   children: [
//                     // ✅ Fixed Height Container
//                     Container(
//                       height: displaysize.height * .4,
//                       width: displaysize.width,
//                       child: Padding(
//                         //fixed sized
//                         padding: EdgeInsets.only(
//                             top: displaysize.height * .05,
//                             right: displaysize.width * .04,
//                             left: displaysize.width * .04),
//                         child: Column(
//                           children: [
//                             custom_back_button(context, 'Edit profile'),
//                             Expanded(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   //content
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),

//                     // ✅ Flexible Growing Container
//                     LayoutBuilder(
//                       builder: (context, boxConstraints) {
//                         return Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
                                  // topLeft:
                                  //     Radius.circular(displaysize.width * .04),
                                  // topRight:
                                  //     Radius.circular(displaysize.width * .04)),
//                               color: app_theme_bg),
//                           constraints: BoxConstraints(
//                               minHeight: constraints.maxHeight - 200,
//                               minWidth: constraints.maxWidth // Remaining space
//                               ),
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: displaysize.width * .04),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: displaysize.height * .02,
//                                 ),
//                                 Text("Title",
//                                     style: TextStyle(
//                                         fontFamily: 'general_sans',
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: displaysize.height * .025,
//                                         color: app_theme_blue2)),
//                                 SizedBox(
//                                   height: displaysize.height * .03,
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
