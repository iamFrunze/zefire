import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zefire/resources/images.dart';
import 'package:zefire/resources/strings.dart';
import 'package:zefire/screens/start/bloc/start_bloc.dart';
import 'package:zefire/screens/start/views/loader.dart';
import 'package:zefire/screens/start/views/logo_mage_view.dart';
import 'package:zefire/screens/start/views/text_button.dart';

import 'bloc/start_bloc.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  StartBloc _bloc;

  @override
  void initState() {
    _bloc = StartBloc();
    _bloc.add(GetBondedDevices());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener(
        bloc: _bloc,
        listener: (context, state) {
          if (state is RouteToControlState)
            Navigator.pushNamedAndRemoveUntil(
                context,
                Strings.routeToControlPaneScreen,
                (Route<dynamic> route) => false);
        },
        child: BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              switch (state.runtimeType) {
                case SearchForDevices:
                  {
                    return AnnotatedRegion<SystemUiOverlayStyle>(
                        value: SystemUiOverlayStyle(
                            statusBarColor: Colors.transparent,
                            systemNavigationBarColor:
                                Theme.of(context).backgroundColor),
                        child: Scaffold(
                          body: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Images.start_background),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                logoImageView,
                                loader(),
                              ],
                            ),
                          ),
                        ));
                  }
                case RouteToSearchState:
                  {
                    return AnnotatedRegion<SystemUiOverlayStyle>(
                        value: SystemUiOverlayStyle(
                            statusBarColor: Colors.transparent,
                            systemNavigationBarColor:
                                Theme.of(context).backgroundColor),
                        child: Scaffold(
                          body: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Images.start_background),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                logoImageView,
                                texButton(context, () async {
                                  Navigator.pushReplacementNamed(context,
                                      Strings.routeToDeviceSearchScreen);
                                })
                              ],
                            ),
                          ),
                        ));
                  }
              }
              return AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      systemNavigationBarColor:
                          Theme.of(context).backgroundColor),
                  child: Scaffold(
                    body: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Images.start_background),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ));
            }),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
