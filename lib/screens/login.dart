import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/services.dart';
import '../shared/shared_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserAuthService _authService = UserAuthService();

  @override
  void initState() {
    super.initState();
    _authService.user.then((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/topics');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme appTextTheme = Theme.of(context).textTheme;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage('assets/images/app_bg.jpg'),
                  fit: BoxFit.fill),
            ),
          ),
          Align(
            alignment: Alignment(0.0, -0.8),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlutterLogo(
                    size: 100,
                  ),
                  Text(
                    '+',
                    style: GoogleFonts.nunito(
                      textStyle: appTextTheme.headline.copyWith(
                        color: Color(0xff303238),
                        fontWeight: FontWeight.bold,
                        fontSize: 90,
                      ),
                    ),
                  ),
                  Icon(
                    FontAwesomeIcons.fireAlt,
                    size: 100,
                    color: Colors.orange[700],
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RoundedShadow.fromRadius(
              32,
              child: Container(
                width: double.infinity,
                color: Color(0xff303238),
                constraints: BoxConstraints(
                    maxHeight: screenHeight * 0.40,
                    minHeight: screenHeight * 0.25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Test your Dev skill'.toUpperCase(),
                      style: GoogleFonts.nunito(
                          textStyle: appTextTheme.title,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Login to Start',
                      style: Theme.of(context).textTheme.headline,
                      textAlign: TextAlign.center,
                    ),
                    LoginButton(
                      color: Colors.blue[600],
                      icon: FontAwesomeIcons.google,
                      loginMethod: _authService.googleSignIn,
                      text: 'CONTINUE WITH GOOGLE',
                    ),
                    LoginButton(
                      text: 'Continue as guest',
                      loginMethod: _authService.anonymousSignIn,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton({
    Key key,
    this.color,
    this.icon,
    this.text,
    this.loginMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: FlatButton.icon(
        padding: EdgeInsets.all(30),
        icon: Icon(icon, color: Colors.white),
        color: color,
        onPressed: () async {
          var user = await loginMethod();
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/topics');
          }
        },
        label: Expanded(
          child: Text('$text', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
