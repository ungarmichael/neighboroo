import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:geolocator/geolocator.dart';
import 'package:neighboroo/components/first_neighboroo-components/FirstNeighborooSearch.dart';
import 'package:neighboroo/components/general-components/button.dart';
import 'package:neighboroo/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:neighboroo/dynamic.dart';
import 'package:neighboroo/models/GoogleMap.dart';
import 'package:neighboroo/provider/GoogleMapMarker.dart';
import 'package:provider/provider.dart';

class NbFirstNeighborooMapScreen extends StatefulWidget {
  @override
  _NbFirstNeighborooMapScreenState createState() =>
      _NbFirstNeighborooMapScreenState();
}

class _NbFirstNeighborooMapScreenState
    extends State<NbFirstNeighborooMapScreen> {
  var _initialPosition;
  var _controller;
  List<Marker> _markers;
  @override
  void initState() {
    _markers = [];
    _initialPosition = CameraPosition(target: LatLng(0, 0), zoom: 4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: StoreConnector<NbGoogleMap, NbGoogleMap>(
        converter: (store) => store.state,
        builder: (context, state) {
          this._markers = state.markers == null ? [] : state.markers;
          return Container(
            color: globe,
            width: MediaQuery.of(context).size.width * 1,
            padding: EdgeInsets.all(10.0),
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10.0, top: 4, bottom: 5),
                  child: Text("Place Search Area on Map",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: text_color,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0, bottom: 10, left: 20),
                  child: Text(
                    "Place a Marker on the Map where you want to search",
                    style: TextStyle(
                      color: hint_text_color,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: GoogleMap(
                            myLocationButtonEnabled: false,
                            initialCameraPosition: _initialPosition,
                            mapType: MapType.normal,
                            onMapCreated: (controller) {
                              setState(() {
                                _controller = controller;
                              });
                            },
                            markers: _markers.toSet(),
                            // markers: provider.markers.toSet(),
                            // markers: provider.markers.toSet(),
                            onTap: (coordinate) {
                              _controller.animateCamera(
                                  CameraUpdate.newLatLng(coordinate));
                              // provider.addMarker(Marker(
                              //     position: coordinate,
                              //     markerId:
                              //     MarkerId(Random().nextInt(100).toString())));
                              Marker m = new Marker(
                                  position: coordinate,
                                  markerId: MarkerId(
                                      Random().nextInt(100).toString()));
                              _markers.add(m);
                              StoreProvider.of<NbGoogleMap>(context)
                                  .dispatch(_markers);
                            }, // onMapCreated: _onMapCreated,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Expanded(
                          //     child: Container(
                          //     padding: EdgeInsets.only(top: 15.0, right: 5),
                          //     child: NbButton(
                          //       buttonname: "back",
                          //       buttoncolor: red,
                          //     )
                          //   ),
                          // ),
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.only(
                                    top: 15.0, left: 5, right: 5),
                                child: NbButton(
                                    buttonname: "you",
                                    buttoncolor: red,
                                    buttonfunction: () => {})),
                          ),
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.only(top: 15.0, left: 5),
                                child: NbButton(
                                  buttonname: "continue",
                                  buttoncolor: red,
                                  buttonfunction: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => NbFirstNeighborooSearch())),
                                  },
                                )),
                          ),
                        ],
                      )
                    ],
                    // child: Text(),
                  ),
                )
              ],
            )),
          );
        },
      ),
    );
  }
}

// class NbFirstNeighborooMapScreen extends StatefulWidget {
//   @override
//   _NbFirstNeighborooMapScreenState createState() => _NbFirstNeighborooMapScreenState();
// }

// class _NbFirstNeighborooMapScreenState extends State<NbFirstNeighborooMapScreen> {

//   GoogleMapController _controller;
//   final LatLng _center = const LatLng(45.521563, -122.677433);
//   List<Marker> markers = [];
//   CameraPosition _initalPosition;
//   // final Map<String, Marker> _markers = {};

//   @override
//   void initState() {
//     _initalPosition = CameraPosition(target: LatLng(0.0000, 0.0000), zoom: 11);
//     super.initState();
//   }

//   void onContinueButtonEvent(BuildContext ctx) {
//     for (Marker m in markers) {
//       print(m);
//       Provider.of<Markers>(ctx, listen: false).addToMarkers(m);
//     }
//     Navigator.of(ctx).pop();
//   }

//   addMarker(coordinate) {
//     setState(() {
//       int id = Random().nextInt(100);
//       markers.add(Marker(position: coordinate, markerId: MarkerId(id.toString())));
//       print(coordinate.toString());
//     });
//   }

//   // void _getLocation() async {
//   //   var currentLocation = await Geolocator()
//   //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
//   //   print(currentLocation.latitude);
//   //   print(currentLocation.longitude);
//   //   setState(() {
//   //     _markers.clear();
//   //     _initalPosition = CameraPosition(
//   //         target: LatLng(currentLocation.latitude, currentLocation.longitude),
//   //         zoom: 11);
//   //     final marker = Marker(
//   //       markerId: MarkerId("curr_loc"),
//   //       position: LatLng(currentLocation.latitude, currentLocation.longitude),
//   //       infoWindow: InfoWindow(title: 'Your Location'),
//   //     );
//   //     _markers["current location"] = marker;
//   //   });
//   //   print(_markers.toString());
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider.value(
//           value: Markers(),
//         ),
//       ],
//       child: MaterialApp(
//         home: Scaffold(
//           backgroundColor: Colors.white,
//           body: Container(
//             color: globe,
//             padding: EdgeInsets.all(10.0),
//             child: SafeArea(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     margin: EdgeInsets.only(left: 10.0, top: 4, bottom: 5),
//                     child: Text("Place Search Area on Map",
//                         style: TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.w700,
//                           color: text_color,
//                         )),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 0, bottom: 10, left: 20),
//                     child: Text(
//                       "Place a Marker on the Map where you want to search",
//                       style: TextStyle(
//                         color: hint_text_color,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                       child: GoogleMap(
//                         myLocationButtonEnabled: false,
//                         initialCameraPosition: _initalPosition,
//                         mapType: MapType.normal,

//                         onMapCreated: (controller) {
//                           setState(() {
//                             _controller = controller;
//                           });
//                         },
//                         markers: markers.toSet(),
//                         onTap: (coordinate) {
//                           _controller.animateCamera(
//                               CameraUpdate.newLatLng(coordinate));
//                           addMarker(coordinate);
//                         },
//                         // onMapCreated: _onMapCreated,
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       // Expanded(
//                       //     child: Container(
//                       //     padding: EdgeInsets.only(top: 15.0, right: 5),
//                       //     child: NbButton(
//                       //       buttonname: "back",
//                       //       buttoncolor: red,
//                       //     )
//                       //   ),
//                       // ),
//                       Expanded(
//                         child: Container(
//                             padding:
//                                 EdgeInsets.only(top: 15.0, left: 5, right: 5),
//                             child: NbButton(
//                                 buttonname: "you",
//                                 buttoncolor: red,
//                                 buttonfunction: () => {})),
//                       ),
//                       Expanded(
//                           child: FlatButton(
//                               onPressed: () => onContinueButtonEvent(context),
//                               color: Colors.red,
//                               child: Text("Markers load"))),
//                       Expanded(
//                         child: Container(
//                             padding: EdgeInsets.only(top: 15.0, left: 5),
//                             child: NbButton(
//                               buttonname: "continue",
//                               buttoncolor: red,
//                               buttonfunction: () => {},
//                             )),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
