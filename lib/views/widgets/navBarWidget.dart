import 'package:flutter/material.dart';
import 'package:petitparser/parser.dart';
import '../notification.dart';
import '../myProfile.dart';
import '../recherche.dart';
import '../../models/userModel/userModel.dart';
class NavBarWidget extends StatelessWidget {
  const NavBarWidget({super.key});
Widget build(BuildContext context) {
  return Container(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      UserModel.getUser();
                      // Action à effectuer lorsque tu cliques sur l'image
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyProfile()),
                      );
                    },
                    child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/profile.png'),
                          radius: 20,
                        ),
                        
                    
                  ), 
                  SizedBox(width: 7),
                  IconButton(
                      icon: Icon(Icons.search),
                      iconSize: 30,
                      onPressed: () {
                        Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Recherche()),
                            );
                        // Action à effectuer lors du clic sur l'icône de recherche
                      },
                    ),
                    GestureDetector(
                    onTap: () {
                      // Action à effectuer lorsque tu cliques sur l'image
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NotificationList()),
                      );
                    },
                    child: Stack(
                      children: [
                        IconButton(
                          icon: Icon(Icons.notifications),
                          iconSize: 30,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NotificationList()),
                            ); // Action à effectuer lors du clic sur l'icône de notification
                          },
                        ),
                        Positioned(
                          right: 5,
                          top: 18,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.green,
                            child: Text(
                              "5",
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                        
                    
                  ), 
                    
                  // IconButton(
                  //     icon: Icon(Icons.notifications),
                  //     onPressed: () {
                  //      Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => NotificationList()),
                  //     ); // Action à effectuer lors du clic sur l'icône de notification
                  //     },
                  //   ),
                  //   Positioned(
                  //         width: 2,
                  //         height: 10,
                  //       child: CircleAvatar(
                  //           radius: 50,
                  //           backgroundColor: Colors.green,
                  //           child: Text("5",
                  //           style: TextStyle(color: Colors.white),
                  //           )
                  //       ),
                  //       bottom: -10,
                  //       left:10,
                  //     ),
                    // Column(
                    //   children: [
                        
                        
                    //   ],)
                ],
              ),
            );
}
}








 