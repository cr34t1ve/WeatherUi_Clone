import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:weather_app_clone/helpers/weatherGetter.dart';
import 'package:weather_app_clone/model/weather.dart';
import 'package:weather_app_clone/utils/app_colors.dart';
import 'package:weather_app_clone/utils/app_config.dart';
import 'package:weather_app_clone/utils/constants.dart';
import 'package:weather_app_clone/widgets/navigationbar_widget.dart';
import 'package:weather_app_clone/widgets/textwidget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<WeatherForecast> futureWeather;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureWeather = WeatherService().fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          centerTitle: true,
          key: _scaffoldKey,
          backgroundColor: bgColor,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/images/Vectormenu.svg',
              color: textColor,
            ),
          ),
          actions: [
            Container(
              child: Switch(
                  value: isSwitchOn,
                  activeColor: Colors.yellow,
                  onChanged: (value) {
                    setState(() {
                      isSwitchOn = value;
                      isSwitchOn
                          ? bgColor = Color(0xFF262626)
                          : bgColor = Colors.white;
                      isSwitchOn
                          ? textColor = Colors.white
                          : textColor = Colors.black;
                      //review
                      isSwitchOn ? Brightness.light : Brightness.dark;
                    });
                  }),
            ),
          ],
        ),
        body: FutureBuilder<WeatherForecast>(
          future: futureWeather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final forecast = snapshot.data;
              final location = forecast.location;
              final country = forecast.country;
              final temperature = forecast.tempCelsius.toInt();
              final currentCondition = forecast.currentCondition;
              final hourlyTemp = forecast.forecastHour;
              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(80)),
                    child: Opacity(
                      opacity: 0.2,
                      child: Image.asset(
                        ImagesAvailable.backgroundImage["assetPath"],
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height / 3.5,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$location, $country",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(19),
                                color: textColor,
                                fontWeight: FontWeight.w600,
                                fontFamily: Fonts.primaryFont),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(37),
                      ),
                      Center(
                        child: Image.asset(
                            ImagesAvailable.partlyCloudy["assetPath"],
                            // height: getProportionateScreenWidth(20),
                            width: getProportionateScreenWidth(162)),
                      ),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      Center(
                        child:
                            // degrees()
                            Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(80),
                                  color: textColor,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: Fonts.primaryFont,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: temperature.toString()),
                                  TextSpan(
                                      text: "°",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(80),
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Fonts.primaryFont,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentCondition,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(23),
                              color: textColor,
                              fontWeight: FontWeight.w600,
                              fontFamily: Fonts.primaryFont,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(90)),
                      Center(
                        child: Text(
                          "Hourly",
                          style: TextStyle(
                            fontSize: 20,
                            color: textColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: Fonts.primaryFont,
                          ),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //
                          // first hourly forecast
                          //
                          Column(
                            children: [
                              Text(
                                "13:00pm",
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 11,
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Fonts.primaryFont,
                                ),
                              ),
                              SizedBox(height: getProportionateScreenHeight(5)),
                              Container(
                                child: Image.asset(
                                  ImagesAvailable.partlyCloudy["assetPath"],
                                  height: getProportionateScreenHeight(50),
                                  width: getProportionateScreenHeight(50),
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(1),
                              ),
                              // degrees1()
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(hourlyTemp[0].tempC.round().toString(),
                                      style: TextStyle(
                                        height: 1,
                                        fontSize: 22,
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Fonts.primaryFont,
                                      )),
                                  Text("°",
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Fonts.primaryFont,
                                      ))
                                ],
                              )
                            ],
                          ),
                          //
                          // second hourly forecast
                          //
                          Column(
                            children: [
                              Text(
                                "16:00pm",
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 11,
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Fonts.primaryFont,
                                ),
                              ),
                              SizedBox(height: getProportionateScreenHeight(5)),
                              Container(
                                child: Image.asset(
                                  ImagesAvailable.sunny["assetPath"],
                                  height: getProportionateScreenHeight(50),
                                  width: getProportionateScreenHeight(50),
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(1),
                              ),
                              // degrees2()
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(hourlyTemp[1].tempC.round().toString(),
                                      style: TextStyle(
                                        height: 1,
                                        fontSize: 22,
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Fonts.primaryFont,
                                      )),
                                  Text("°",
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Fonts.primaryFont,
                                      ))
                                ],
                              )
                            ],
                          ),
                          //
                          // third hourly forecast
                          //
                          Column(
                            children: [
                              Text(
                                "07:00pm",
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 11,
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Fonts.primaryFont,
                                ),
                              ),
                              SizedBox(height: getProportionateScreenHeight(5)),
                              Container(
                                child: Image.asset(
                                  ImagesAvailable.moonCloudy["assetPath"],
                                  height: getProportionateScreenHeight(50),
                                  width: getProportionateScreenHeight(50),
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(1),
                              ),
                              // degrees3()
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(hourlyTemp[12].tempC.round().toString(),
                                      style: TextStyle(
                                        height: 1,
                                        fontSize: 22,
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Fonts.primaryFont,
                                      )),
                                  Text("°",
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Fonts.primaryFont,
                                      ))
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                      bottom: 35,
                      left: getProportionateScreenWidth(50),
                      child: Container(
                          height: getProportionateScreenHeight(60),
                          width: getProportionateScreenWidth(275),
                          child: NavigationBar()))
                ],
              );
            }
            // loading weather animation
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/animation/load-icon-gif-21.jpg.gif',
                  width: 400,
                ),
                SizedBox(
                  height: 120.0,
                )
              ],
            );
          },
        ));
  }
}
