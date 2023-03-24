import 'package:flutter/material.dart';

class genLoginSignupHeader extends StatelessWidget {

  String headerName;
  genLoginSignupHeader(this.headerName);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10,),
          Text(headerName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 30
            ),
          ),
          SizedBox(height: 10,),
          Image.asset("assets/images/logo.jpeg",
            height: 100,
            width: 150,),
          SizedBox(height: 5,),
          Text('NKD LOG',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black38,
                fontSize: 30
            ),
          ),
        ],
      ),
    );
  }
}
