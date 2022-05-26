import 'package:flutter/material.dart';

class HowToPlayTheGame extends StatelessWidget {
  const HowToPlayTheGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "charchters",
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          height: 300,
          width: mysize.width,
          child: Column(
            children: [
              SizedBox(
                height: mysize.height * 0.1,
                child: Text(
                  "Kira",
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
