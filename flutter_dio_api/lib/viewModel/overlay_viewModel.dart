import 'package:flutter/material.dart';

class OverlayViewModel{

  BuildContext context;

  OverlayViewModel({required this.context,});

  OverlayEntry? overlayEntry;
  void showOverlay(){
    if(overlayEntry!=null) return;
    overlayEntry=OverlayEntry(
        builder: (context)=> Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: removeOverlay, // Close overlay on tap outside
                behavior: HitTestBehavior.opaque,
              ),
            ),
            Positioned(
                top: 105,
                right: 0,
                child: Material(
                  elevation: 5,
                  child: Container(
                    height: 400,
                    width: 200,
                    color: Colors.blue.shade200,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text('---Select Category---',style: TextStyle(fontSize: 20),),
                        ),
                        TextButton(onPressed: (){}, child: Text('General')),
                        TextButton(onPressed: (){}, child: Text('business')),
                        TextButton(onPressed: (){}, child: Text('entertainment')),
                        TextButton(onPressed: (){}, child: Text('health')),
                        TextButton(onPressed: (){}, child: Text('science')),
                        TextButton(onPressed: (){}, child: Text('sports')),
                        TextButton(onPressed: (){}, child: Text('technology')),
                      ],
                    ),
                  ),
                )
            )
          ],
        )

    );
    Overlay.of(context).insert(overlayEntry!);
  }
  void removeOverlay(){
    overlayEntry?.remove();
    overlayEntry=null;
  }
}