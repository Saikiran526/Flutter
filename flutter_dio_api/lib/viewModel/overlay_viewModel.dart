import 'package:flutter/material.dart';
import 'package:flutter_dio_api/providers/category_provider.dart';
import 'package:provider/provider.dart';

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
                        // TextButton(onPressed: (){categoryProvider.setCategory("")}, child: Text('General')),
                        TextButton(
                            onPressed: (){
                              Provider.of<CategoryProvider>(context, listen: false).setCategory("general");
                              removeOverlay();
                            },
                            child: Text('general')
                        ),
                        TextButton(
                            onPressed: (){
                              Provider.of<CategoryProvider>(context, listen: false).setCategory("business");
                              removeOverlay();
                            },
                            child: Text('business')
                        ),
                        TextButton(
                            onPressed: (){
                              Provider.of<CategoryProvider>(context, listen: false).setCategory("entertainment");
                              removeOverlay();
                            },
                            child: Text('entertainment')
                        ),
                        TextButton(
                            onPressed: (){
                              Provider.of<CategoryProvider>(context, listen: false).setCategory("health");
                              removeOverlay();
                            },
                            child: Text('health')
                        ),
                        TextButton(
                            onPressed: (){
                              Provider.of<CategoryProvider>(context, listen: false).setCategory("science");
                              removeOverlay();
                            },
                            child: Text('science')
                        ),
                        TextButton(
                            onPressed: (){
                              Provider.of<CategoryProvider>(context, listen: false).setCategory("sports");
                              removeOverlay();
                            },
                            child: Text('sports')
                        ),
                        TextButton(
                            onPressed: (){
                              Provider.of<CategoryProvider>(context, listen: false).setCategory("technology");
                              removeOverlay();
                            },
                            child: Text('technology')
                        ),
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