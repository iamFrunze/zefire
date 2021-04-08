import 'package:flutter/material.dart';
import 'package:zefire/resources/strings.dart';

Future<Widget> showError(
    context, textTitle, textDescription, buttonText, action) async {
  await Future.delayed(Duration(microseconds: 1));
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Theme.of(context).backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 19, left: 16, right: 16),
                child: Text(
                  textTitle,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 16, left: 16, right: 16, bottom: 19),
                child: Text(
                  textDescription,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Expanded(
                    child: SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed: action ??
                            () {
                              Navigator.pop(context);
                            },
                        child: Text(buttonText,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
