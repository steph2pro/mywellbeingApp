
import 'package:flutter/material.dart';
import 'package:mywellbeing/widgets/imageSlider.dart';
import 'package:mywellbeing/widgets/imcWidget.dart';
import 'package:mywellbeing/widgets/exerciceWidget.dart';
import 'package:mywellbeing/widgets/programeWidget.dart';
class ContenuePagePincipal extends StatelessWidget {
  const ContenuePagePincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column( 
              children: [
              ImageSider(),
              ProgrameWidget() ,
              ImcWidget(),
              ExerciceWidget()
              ],
        )
      )
      
    );
  }
}
