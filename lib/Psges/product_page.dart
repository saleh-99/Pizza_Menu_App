import '../flutter_flow/app_theme.dart';

import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  TextEditingController descriptionFieldController;
  TextEditingController titleFieldController;

  @override
  void initState() {
    super.initState();
    descriptionFieldController = TextEditingController();
    titleFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FloatingActionButton pressed ...');
        },
        backgroundColor: AppTheme.secondaryColor,
        elevation: 8,
        child: Icon(
          Icons.add,
          color: AppTheme.tertiaryColor,
          size: 28,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                        child: Image.network(
                          'https://picsum.photos/seed/620/600',
                          width: MediaQuery.of(context).size.width * 0.25,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: TextFormField(
                                controller: titleFieldController,
                                decoration: InputDecoration(
                                  hintText: 'Title',
                                  hintStyle: AppTheme.title3,
                                  enabledBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color(0x74FAA307),
                                ),
                                style: AppTheme.title3,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: TextFormField(
                                controller: descriptionFieldController,
                                decoration: InputDecoration(
                                  hintText: 'Description',
                                  hintStyle: AppTheme.bodyText2,
                                  enabledBorder: AppTheme.kUnderlineInputBorder,
                                  focusedBorder: AppTheme.kUnderlineInputBorder,
                                  filled: true,
                                  fillColor: Color(0x4FFAA307),
                                ),
                                style: AppTheme.bodyText2,
                                maxLines: 3,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Divider(
                    height: 5,
                    thickness: 5,
                    indent: 5,
                    endIndent: 5,
                    color: AppTheme.secondaryColor,
                  ),
                  ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Color(0x74FAA307),
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: 'Name of modifier...',
                                          hintStyle: AppTheme.bodyText1,
                                          filled: true,
                                          fillColor: Color(0x4FFAA307),
                                        ),
                                        style: AppTheme.bodyText1,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: AppTheme.secondaryColor,
                                        size: 30,
                                      ),
                                      iconSize: 30,
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SwitchListTile(
                                      value: true,
                                      onChanged: (newValue) =>
                                          setState(() => newValue),
                                      title: Text(
                                        'Required',
                                        textAlign: TextAlign.center,
                                        style: AppTheme.bodyText1,
                                      ),
                                      tileColor: Color(0x00FAA307),
                                      activeColor: AppTheme.secondaryColor,
                                      dense: true,
                                    ),
                                  ),
                                  Expanded(
                                    child: SwitchListTile(
                                      value: true,
                                      onChanged: (newValue) =>
                                          setState(() => newValue),
                                      title: Text(
                                        'One-Many',
                                        style: AppTheme.bodyText1,
                                      ),
                                      tileColor: Color(0x00FAA307),
                                      activeColor: AppTheme.secondaryColor,
                                      dense: true,
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                height: 15,
                                thickness: 3,
                                indent: 25,
                                endIndent: 25,
                                color: AppTheme.secondaryColor,
                              ),
                              ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(8, 0, 8, 0),
                                            child: TextFormField(
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                hintText: 'Name....',
                                                hintStyle: AppTheme.bodyText1,
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5),
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5),
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5),
                                                  ),
                                                ),
                                                filled: true,
                                                fillColor: Color(0x4FFAA307),
                                              ),
                                              style: AppTheme.bodyText1,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(8, 0, 8, 0),
                                            child: TextFormField(
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                hintText: '0.0',
                                                hintStyle: AppTheme.bodyText1,
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15),
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15),
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                                filled: true,
                                                fillColor: Color(0x4FFAA307),
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        13, 13, 13, 13),
                                                prefixIcon: Icon(
                                                  Icons.attach_money,
                                                ),
                                              ),
                                              style: AppTheme.bodyText1,
                                              textAlign: TextAlign.center,
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            print('IconButton pressed ...');
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: AppTheme.secondaryColor,
                                            size: 25,
                                          ),
                                          iconSize: 25,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
