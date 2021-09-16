import 'package:flutter/material.dart';

class TwShows extends StatelessWidget {
  const TwShows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tw shows not implemented yet',style: TextStyle(fontSize: 24)),
            SizedBox(height:20),
            Icon(Icons.settings,size: 48),
          ],
        ),
      ),
    );
  }
}
