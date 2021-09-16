import 'package:flutter/material.dart';

class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('News not implemented yet',style: TextStyle(fontSize: 24)),
            SizedBox(height:20),
            Icon(Icons.settings,size: 48),
          ],
        ),
      ),
    );
  }
}
