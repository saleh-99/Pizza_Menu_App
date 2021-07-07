import '../flutter_flow/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class LoginPageWidget extends StatefulWidget {
  LoginPageWidget({Key key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  TextEditingController emailFieldController;
  TextEditingController passFieldController;
  bool passFieldVisibility;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailFieldController = TextEditingController();
    passFieldController = TextEditingController();
    passFieldVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAA307),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/rhinos-logo.png',
              width: 200,
              height: 200,
              fit: BoxFit.scaleDown,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 20),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0x66EEEEEE),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: TextFormField(
                        controller: emailFieldController,
                        decoration: InputDecoration(
                          hintText: 'Test@test.com',
                          hintStyle: GoogleFonts.getFont(
                            'Roboto',
                            color: AppTheme.tertiaryColor,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                          ),
                          prefixIcon: Icon(
                            Icons.alternate_email,
                            color: AppTheme.secondaryColor,
                          ),
                        ),
                        style: GoogleFonts.getFont(
                          'Roboto',
                          color: AppTheme.tertiaryColor,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Field is required';
                          }

                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 20),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0x65EEEEEE),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: TextFormField(
                        controller: passFieldController,
                        obscureText: !passFieldVisibility,
                        decoration: InputDecoration(
                          hintText: '***************',
                          hintStyle: GoogleFonts.getFont(
                            'Roboto',
                            color: AppTheme.tertiaryColor,
                            fontWeight: FontWeight.normal,
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppTheme.secondaryColor,
                          ),
                          suffixIcon: InkWell(
                            onTap: () => setState(
                              () => passFieldVisibility = !passFieldVisibility,
                            ),
                            child: Icon(
                              passFieldVisibility
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 22,
                            ),
                          ),
                        ),
                        style: GoogleFonts.getFont(
                          'Roboto',
                          color: AppTheme.tertiaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  height: 55,
                  child: RaisedButton(
                    onPressed: () {
                      context.read<AuthenticationService>().signIn(
                            email: emailFieldController.text.trim(),
                            password: passFieldController.text.trim(),
                          );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                    textColor: Color(0xFFFAFAFA),
                    color: AppTheme.secondaryColor,
                    child: Text(
                      'Login',
                      style: GoogleFonts.getFont(
                        'Roboto',
                        color: Color(0xFFFAFAFA),
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
