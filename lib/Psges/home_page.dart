import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pizzeria_menu/models/modals.dart';
import 'package:provider/provider.dart';
import '../components/radio_button_group.dart';
import '../components/app_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool checkboxListTileValue1;
  bool checkboxListTileValue2;

  @override
  Widget build(BuildContext context) {
    return Consumer<List<PizzaDetails>>(
      builder: (_, List<PizzaDetails> pizzaDetails, w) {
        if (PizzaDetails != null) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: pizzaDetails.length,
            itemBuilder: (_, int index) {
              if (pizzaDetails.isNotEmpty)
                return pizzaDetailItem(pizzaDetail: pizzaDetails[index]);
              return Text("data");
            },
          );
        }
        return Text('loading');
      },
    );
  }

  Widget pizzaDetailItem({PizzaDetails pizzaDetail}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0x8FFAA307),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: Container(
                    width: 120,
                    height: 120,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40.0),
                        child: Image.network(
                          pizzaDetail.image,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace stackTrace) {
                            return Text('No Image');
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                          child: Text(
                            pizzaDetail.title,
                            textAlign: TextAlign.center,
                            style: AppTheme.title1,
                          ),
                        ),
                        Text(
                          pizzaDetail.description,
                          textAlign: TextAlign.start,
                          style: AppTheme.bodyText2,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Divider(
              height: 8,
              thickness: 1.5,
              indent: 20,
              endIndent: 20,
              color: AppTheme.secondaryColor,
            ),
            StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              crossAxisSpacing: 3,
              mainAxisSpacing: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: pizzaDetail.modifiers.length,
              itemBuilder: (_, int index) {
                return modifierDetailItem(
                    modifier: pizzaDetail.modifiers[index]);
              },
              staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
            ),
          ],
        ),
      ),
    );
  }

  Widget modifierDetailItem({Modifier modifier}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(modifier.name + " :"),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.blueGrey, width: 1.5)),
            child: RadioButtonGroup(
              options:
                  modifier.options.map((item) => item.name.toString()).toList(),
              onChanged: (value) {
                setState(() => null);
              },
              optionHeight: 30,
              textPadding: EdgeInsets.all(2.0),
              textStyle: AppTheme.bodyText1,
              buttonPosition: RadioButtonPosition.left,
              direction: Axis.vertical,
              radioButtonColor: AppTheme.secondaryColor,
              toggleable: !modifier.required,
              horizontalAlignment: WrapAlignment.start,
              verticalAlignment: WrapCrossAlignment.start,
            ),
          ),
        ],
      ),
    );
  }
}
