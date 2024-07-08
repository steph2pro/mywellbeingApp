
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';

class ChatSimple extends StatefulWidget {
  @override
  _ChatSimpleState createState() => _ChatSimpleState();
}

class _ChatSimpleState extends State<ChatSimple> {
  
  @override
  Widget build(BuildContext context){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
        padding: const EdgeInsets.only(right: 80),
        child: ClipPath(
         clipper: UpperNipMessageClipper(MessageType.receive),
         child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color(0xFFE1E1E2),
          ),
          child: const Text("Que puis je faire pour toi",
          style: TextStyle(
            fontSize: 16,
          ),
         ),
        ),

        ),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Padding(
             padding: const EdgeInsets.only(top: 20,left: 80),
             child: ClipPath(
              clipper: LowerNipMessageClipper(MessageType.send),
              child: Container(
                padding: const EdgeInsets.only(left: 20,top: 10,bottom: 25,right: 20),
                decoration: const BoxDecoration(
                  color: Color(0xFF7165D6),
                ),
                child:  const Text(
                  "Bonjour dr besoin de conseil",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
             ),
             ),
        )
      ],
    );
  }
}