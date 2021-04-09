import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:zefire/resources/strings.dart';
import 'package:zefire/screens/connection_device/connection_device_screen.dart';

Widget DevicesList(List<ScanResult> arrayOfResult) {
  return Expanded(
    child: ListView.builder(
        itemCount: arrayOfResult.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              var device = arrayOfResult[index].device;
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConnectionDeviceScreen(
                    device: device,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 0.5, color: Theme.of(context).dividerColor),
                      bottom: BorderSide(
                          width: 0.5, color: Theme.of(context).dividerColor))),
              height: 80,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: Text(
                          arrayOfResult[index].device.name ?? "Unknown device",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ),
                    Container(
                      child: false
                          ? Text(
                              Strings.connected,
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          : Text(
                              Strings.disabled,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
  );
}

Widget AvailableDevicesTitle(context) => Container(
      margin: const EdgeInsets.only(top: 24, left: 16, bottom: 17),
      child: Row(
        children: [
          Text(
            Strings.availableDevices,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Container(
              height: 16,
              width: 16,
              margin: const EdgeInsets.only(left: 8),
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2.0,
              ))
        ],
      ),
    );
