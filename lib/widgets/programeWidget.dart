import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgrameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue,
            Colors.lightBlue,
            Colors.green,
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
            Text("Programme les plus suivies",
              style: TextStyle(color: Colors.white,fontSize: 30),
              textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Column(
                children: [
                Row(
                mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            
                            padding: EdgeInsets.only(bottom: 7),
                            color: Colors.redAccent,
                            width: 160,
                            child: Column(
                              children: [
                                Image.asset("assets/images/image3.jpg"),
                                Text("allimentation",
                                  style: TextStyle(color: Colors.white,fontSize: 20,),
                                  textAlign: TextAlign.center,
                                  )
                              ],
                            )
                          
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 7),
                            color: Colors.red,
                            width: 160,
                            child: Column(
                              children: [
                                Image.asset("assets/images/image2.jpg"),
                                Text("Sportif",
                                  style: TextStyle(color: Colors.white,fontSize: 20,),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            )
                          
                          )
                        ],
                      ),
                    ),
                    
                  ],
                ),
                SizedBox(height: 10),
                Row(
                mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 7),
                            color: Colors.redAccent,
                            width: 160,
                            child: Column(
                              children: [
                                Image.asset("assets/images/image4.png",
                                height: 200,
                                ),
                                Text("hydratation",
                                  style: TextStyle(color: Colors.white,fontSize: 20,),
                                  textAlign: TextAlign.center,
                                  )
                              ],
                            )
                          
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 7),
                            color: Colors.red,
                            width: 160,
                            child: Column(
                              children: [
                                Image.asset("assets/images/image1.jpeg",
                                  width: 200,
                                ),
                                Text("Meditation",
                                  style: TextStyle(color: Colors.white,fontSize: 20,),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            )
                          
                          )
                        ],
                      ),
                    ),
                    
                  ],
                ),
                ]
              )
          ]
      ),
    );
  }
}
