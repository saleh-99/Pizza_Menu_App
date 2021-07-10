import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../components/app_theme.dart';

import 'package:flutter/material.dart';

class GoogleMapPage extends StatefulWidget {
  GoogleMapPage({Key key}) : super(key: key);

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  TextEditingController textController;

  static const initialCameraPosition =
      CameraPosition(target: LatLng(31.9539, 35.9106), zoom: 9);

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: initialCameraPosition,
              myLocationButtonEnabled: false,
              trafficEnabled: true,
            ),
            Align(
              alignment: Alignment(0, 0.92),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0x5D283B58),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFFF5F5F5),
                            elevation: 15,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0x5D283B58),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFFF5F5F5),
                            elevation: 15,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.09, -0.95),
              child: Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                          child: Icon(
                            Icons.search,
                            color: Color(0xFF95A1AC),
                            size: 24,
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: TextFormField(
                              controller: textController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Search for truck...',
                                labelStyle: AppTheme.bodyText1,
                                hintText: 'Find your truck by name',
                                hintStyle: AppTheme.bodyText1,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x004B39EF),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x004B39EF),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: AppTheme.bodyText1,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.tune_rounded,
                          color: Color(0xFF95A1AC),
                          size: 24,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
