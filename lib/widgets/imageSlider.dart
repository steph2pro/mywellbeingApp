
import 'dart:async';
import 'package:flutter/material.dart';
class ImageSider extends StatefulWidget {
  const ImageSider({super.key});

  @override
  State<ImageSider> createState() => _ImageSiderState();
}
//
class ImagePlace extends StatelessWidget{
  final String? ImagePath;
  const ImagePlace({super.key,this.ImagePath});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Image.asset(
      ImagePath!,
      fit: BoxFit.cover,
    );
  }
}
final  List<String> ImagePaths = [
  "assets/images/image4.png",
  "assets/images/image3.jpg",
  "assets/images/image2.jpg",

];
late List<Widget> _pages;
int _activePage=0;
final PageController _pageController= PageController(initialPage: 0);
Timer? _timer;
//
class _ImageSiderState extends State<ImageSider> {  
  //fonction pour changer l'image appres un temps
  @override
  void startTimer(){
    _timer=Timer.periodic(
      Duration(seconds: 3),
      (timer){
        if (_pageController.page==ImagePaths.length-1) {
          _pageController.animateTo(
            0, 
            duration: Duration(milliseconds: 300), 
            curve: Curves.easeInOut);
        } else {
          _pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut);
        }
      });
      
  }
   @override
   void dispose(){
    super.dispose();
    _timer?.cancel();
   }
  @override
  void initState(){
    super.initState();
    _pages=List.generate(ImagePaths.length,(index)=>ImagePlace(ImagePath: ImagePaths[index],));
    startTimer();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 1),
      child:  Column(
            children: [
              Stack(
                
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: ImagePaths.length,
                      onPageChanged: (value){
                        setState(() {
                          _activePage=value;
                        });
                      },
                      itemBuilder: (context, index){
                        //on retoune le composent de l'image
                        return _pages[index];
                      },
                    ),
                  ),
                  //code pour les indicateur de la position de l'image
                  Positioned(
                    bottom:10,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(
                          _pages.length,
                          (index)=>Padding( 
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                              onTap:(){
                                _pageController.animateToPage(
                                  index,
                                  duration:Duration(milliseconds: 300),
                                  curve:Curves.easeIn);
                              },
                              child:CircleAvatar(
                                radius:4,
                                backgroundColor: _activePage == index 
                                ? Colors.blue
                                :Colors.white,
                              ),
                            )
                            )
                        ),
                      ),
                    ) 
                  )

                ],    
              )
             ],
            ),
    );
  }
}

