import 'package:drop_here_mobile/common/config/locator_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';

class ChooseUserPage extends StatelessWidget {
  final ThemeConfig themeConfig = locator.get<ThemeConfig>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("abc"),
        ),
        body: GridView.builder(
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 8.0 / 10.0,
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.all(5),
                child: Card(
                    semanticContainer: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/no_image.png'),
                                fit: BoxFit.fill),
                          ),
                        )),
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Name",
                              style: TextStyle(fontSize: 18.0),
                            )),
                      ],
                    )));
          },
        ));
  }
  // return Padding(
  //   padding: const EdgeInsets.only(top: 60.0),
  //   child: Column(
  //     children: [
  //       Text(
  //         Localization.of(context).bundle.whoAreYou,
  //         style: themeConfig.textStyles.secondaryTitle,
  //       ),
  //       Card
  //     ],
  //   ),
  // );
}
