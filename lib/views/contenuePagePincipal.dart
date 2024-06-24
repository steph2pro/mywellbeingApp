
import 'package:flutter/material.dart';
import 'package:mywellbeing/views/widgets/imageSlider.dart';
import 'package:mywellbeing/views/widgets/imcWidget.dart';
import 'package:mywellbeing/views/widgets/exerciceWidget.dart';
import 'package:mywellbeing/views/widgets/programeWidget.dart';
import 'package:mywellbeing/views/specialisteList.dart';
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
              SpecialisteList(),
              ImcWidget(),
              ExerciceWidget(),
              ],
        )
      )
      
    );
  }
}
