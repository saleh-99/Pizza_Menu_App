import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:pizzeria_menu/models/modals.dart';
import 'package:pizzeria_menu/services/database.dart';
import 'package:provider/provider.dart';

import '../components/app_theme.dart';

import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with AutomaticKeepAliveClientMixin {
  TextEditingController descriptionFieldController;
  TextEditingController titleFieldController;

  File _imageFile;

  @override
  void initState() {
    super.initState();
    descriptionFieldController = TextEditingController();
    titleFieldController = TextEditingController();
  }

  _getImage(ImageSource src) async {
    var pickedFile = await ImagePicker().getImage(source: src);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final pizzaDetailsProduct =
        Provider.of<Database>(context).pizzaDetailsProduct;
    titleFieldController.text = pizzaDetailsProduct.title;
    descriptionFieldController.text = pizzaDetailsProduct.description;
    _imageFile = pizzaDetailsProduct.image != ""
        ? File(pizzaDetailsProduct.image)
        : null;
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() async {
            await Provider.of<Database>(context, listen: false).createRecord();
          });
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        child: MaterialButton(
                          height: 150,
                          elevation: 15,
                          child: _imageFile != null
                              ? Image(
                                  image: AssetImage(_imageFile.path),
                                  fit: BoxFit.scaleDown,
                                )
                              : Icon(
                                  Icons.camera_alt,
                                  size: 60,
                                ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                      title: Text("Camera/Gallery"),
                                      children: <Widget>[
                                        SimpleDialogOption(
                                          onPressed: () async {
                                            Navigator.pop(
                                                context); //close the dialog box
                                            await _getImage(
                                                ImageSource.gallery);
                                            pizzaDetailsProduct.image =
                                                _imageFile.path;
                                          },
                                          child:
                                              const Text('Pick From Gallery'),
                                        ),
                                        SimpleDialogOption(
                                          onPressed: () async {
                                            Navigator.pop(
                                                context); //close the dialog box
                                            _getImage(ImageSource.camera);
                                          },
                                          child:
                                              const Text('Take A New Picture'),
                                        ),
                                      ]);
                                });
                          },
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: TextFormField(
                                onChanged: (string) {
                                  pizzaDetailsProduct.title =
                                      titleFieldController.text;
                                },
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
                            Padding(
                              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: TextFormField(
                                onChanged: (string) {
                                  pizzaDetailsProduct.description =
                                      descriptionFieldController.text;
                                },
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
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 15.0),
                          child: Divider(
                            height: 5,
                            thickness: 5,
                            indent: 5,
                            endIndent: 5,
                            color: AppTheme.secondaryColor,
                          )),
                    ),
                    Text("Add Modifier"),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          pizzaDetailsProduct.modifiers.add(new Modifier(
                              required: false,
                              oneMany: false,
                              options: [Option()]));
                        });
                      },
                      icon: Icon(
                        Icons.add_circle,
                        color: AppTheme.secondaryColor,
                        size: 40,
                      ),
                      iconSize: 50,
                    )
                  ]),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: pizzaDetailsProduct.modifiers == null
                          ? 0
                          : pizzaDetailsProduct.modifiers.length,
                      itemBuilder: (_, int index) {
                        if (pizzaDetailsProduct.modifiers.isNotEmpty)
                          return buildModifier(
                              modifier: pizzaDetailsProduct.modifiers[index],
                              delete: () {
                                setState(() {
                                  pizzaDetailsProduct.modifiers.removeAt(index);
                                });
                              });
                        return Text("data");
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildModifier({Modifier modifier, Function delete}) {
    var nameController = TextEditingController()..text = modifier.name;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Color(0xFFF6C776),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: (string) {
                            modifier.name = nameController.text;
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Name of modifier...',
                            hintStyle: AppTheme.bodyText1,
                            filled: true,
                            fillColor: Color(0x4FFAA307),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        "Add Option",
                        style: TextStyle(fontSize: 12),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            modifier.options.add(Option(name: "", price: ""));
                          });
                        },
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: AppTheme.secondaryColor,
                          size: 30,
                        ),
                        iconSize: 30,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SwitchListTile(
                        value: modifier.required,
                        onChanged: (newValue) =>
                            setState(() => modifier.required = newValue),
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
                        value: modifier.oneMany,
                        onChanged: (newValue) =>
                            setState(() => modifier.oneMany = newValue),
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: modifier == null ? 0 : modifier.options.length,
                  itemBuilder: (_, int index) {
                    if (modifier.options.isNotEmpty)
                      return buildOption(
                          option: modifier.options[index],
                          delete: () {
                            setState(() {
                              modifier.options.removeAt(index);
                            });
                          });
                    return Text("data");
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -10,
          right: -8,
          child: IconButton(
            onPressed: delete,
            icon: Icon(
              Icons.cancel_outlined,
              color: AppTheme.secondaryColor,
              size: 30,
            ),
            iconSize: 30,
          ),
        ),
      ],
    );
  }

  Widget buildOption({Option option, Function delete}) {
    var nameController = TextEditingController()..text = option.name;
    var priceController = TextEditingController()..text = option.price;
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: TextFormField(
                onChanged: (string) {
                  option.name = nameController.text;
                },
                controller: nameController,
                obscureText: false,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Name....',
                  hintStyle: AppTheme.bodyText1,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
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
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: TextFormField(
                onChanged: (string) {
                  option.price = priceController.text;
                },
                controller: priceController,
                obscureText: false,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: '0.0',
                  hintStyle: AppTheme.bodyText1,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  filled: true,
                  fillColor: Color(0x4FFAA307),
                  contentPadding: EdgeInsets.fromLTRB(13, 13, 13, 13),
                  prefixIcon: Icon(
                    Icons.attach_money,
                  ),
                ),
                style: AppTheme.bodyText1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          IconButton(
            onPressed: delete,
            icon: Icon(
              Icons.delete,
              color: AppTheme.secondaryColor,
              size: 25,
            ),
            iconSize: 25,
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
