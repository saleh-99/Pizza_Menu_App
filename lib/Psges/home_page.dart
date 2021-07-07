import '../flutter_flow/radio_button_group.dart';
import '../flutter_flow/app_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String radioButtonValue1;
  bool checkboxListTileValue1;
  bool checkboxListTileValue2;
  String radioButtonValue2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0x8FFAA307),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // TODO replace wiht image circle
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: Container(
                          width: 120,
                          height: 120,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://picsum.photos/seed/426/600',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                child: Text(
                                  'Hello World',
                                  textAlign: TextAlign.center,
                                  style: AppTheme.title1,
                                ),
                              ),
                              AutoSizeText(
                                'fdsfdsafadgdfadgdfgfdggdfgdfgdgdfdsfdsafadgdfadgdfgfdggdfgdfgdgd',
                                textAlign: TextAlign.start,
                                style: AppTheme.bodyText2,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0x00EEEEEE),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // TODO replace wiht Radio Button
                            RadioButtonGroup(
                              options: ['Option 1', 'Option 2', 'Option 3'],
                              onChanged: (value) {
                                setState(() => radioButtonValue1 = value);
                              },
                              optionHeight: 25,
                              textStyle: AppTheme.bodyText1,
                              buttonPosition: RadioButtonPosition.left,
                              direction: Axis.vertical,
                              radioButtonColor: AppTheme.secondaryColor,
                              toggleable: false,
                              horizontalAlignment: WrapAlignment.start,
                              verticalAlignment: WrapCrossAlignment.start,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0x00EEEEEE),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RadioButtonGroup(
                              options: ['Option 1', 'Option 2', 'Option 3'],
                              onChanged: (value) {
                                setState(() => radioButtonValue2 = value);
                              },
                              optionHeight: 25,
                              textStyle: AppTheme.bodyText1,
                              buttonPosition: RadioButtonPosition.left,
                              direction: Axis.vertical,
                              radioButtonColor: AppTheme.secondaryColor,
                              toggleable: false,
                              horizontalAlignment: WrapAlignment.start,
                              verticalAlignment: WrapCrossAlignment.start,
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
