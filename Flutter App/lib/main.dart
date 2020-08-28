import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget space = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [],
      ),
    );
    var column = Row(
      children: [
        Spacer(),
        RaisedButton.icon(
          onPressed: _launchURL,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          label: Text(
            'WWW',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.web_asset,
            color: Colors.white,
          ),
          textColor: Colors.white,
          splashColor: Colors.red,
          color: Colors.blueGrey[800],
        ),
        Spacer(),
        RaisedButton.icon(
          onPressed: _launchURL2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          label: Text(
            'GIT',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.code,
            color: Colors.white,
          ),
          textColor: Colors.white,
          splashColor: Colors.red,
          color: Colors.blueGrey[800],
        ),
        Spacer(),
        RaisedButton.icon(
          onPressed: _launchURL3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          label: Text(
            'LNKDN',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.recent_actors,
            color: Colors.white,
          ),
          textColor: Colors.white,
          splashColor: Colors.red,
          color: Colors.blueGrey[800],
        ),
        Spacer(),
        RaisedButton.icon(
          onPressed: _launchURL4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          label: Text(
            'RSME',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.business_center,
            color: Colors.white,
          ),
          textColor: Colors.white,
          splashColor: Colors.red,
          color: Colors.blueGrey[800],
        ),
        Spacer(),
      ],
    );

    Widget buttonSection = column;

    Widget textSection = Container(
        padding: const EdgeInsets.all(50),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blueGrey[700],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Text(
            'MATTHEW BOWEN',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        ));

    Widget newtextSection = Container(
        padding: const EdgeInsets.all(15),
        child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: const Text.rich(
              TextSpan(
                text:
                    'I am a software devoloper and a father of two! \nI enjoy programming, eating my wifes food and playing games with my kids!\n', // default text style
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  height: 1.2,
                  fontSize: 15,
                  color: Colors.black87,
                ),

                children: <TextSpan>[
                  TextSpan(
                      text:
                          '\nI have also developed add-ons for popular video games using LUA. I also pick up lesser known languages fairly quickly. \nI have utilized different functions and languages in the projects on my github.\n \nThey range from simple projects to relatively neat and complex ones.',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1.0,
                        height: 1.2,
                      )),
                  TextSpan(
                      text:
                          'I enjoy programming in C#, Python, Javascript and Dart. I am always learning and looking to improve myself. Currently, I am working with Dart and Flutter to create mobile applications.',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1.0,
                        height: 1.2,
                      )),
                ],
              ),
            )));
    Widget newtextSections = Container(
        padding: const EdgeInsets.all(15),
        child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: const Text.rich(
              TextSpan(
                text:
                    'Thanks for checking my portfolio test application out!\n', // default text style
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  height: 1.2,
                  fontSize: 15,
                  color: Colors.black87,
                ),

                children: <TextSpan>[
                  TextSpan(
                      text: 'Again, this is totally just a test application.\n',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1.0,
                        height: 1.2,
                      )),
                  TextSpan(
                      text: 'I\'ll be adding to this a lot!',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1.0,
                        height: 1.2,
                      )),
                ],
              ),
            )));
    return MaterialApp(
      title: 'Gruzzly.co',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[800],
          title: Text(''),
        ),
        body: ListView(
          children: [
            Image.asset(
              'assets/images/Gruzzly.png',
              width: 550,
              height: 100,
              fit: BoxFit.fitWidth,
            ),
            buttonSection,
            space,
            Image.asset(
              'assets/images/me.png',
              width: 250,
              height: 250,
            ),
            textSection,
            newtextSection,
            newtextSections
          ],
        ),
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://gruzzly.co';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURL2() async {
  const url = 'https://github.com/gruzzly-bear/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURL3() async {
  const url = 'https://www.linkedin.com/in/matthew-bowen-oh/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURL4() async {
  const url = 'https://gruzzly.co/Stylesheet/Resume.pdf';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
