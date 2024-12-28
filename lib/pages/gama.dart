import 'package:bucharest/utils/forecastileprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class gama extends StatefulWidget {
  const gama({super.key});

  @override
  State<gama> createState() => gamaState();
}

class gamaState extends State<gama> {
  TileOverlay? _tileOverlay;

  DateTime _forecastDate = DateTime.now();

  _initTiles(DateTime date) async {
    final String overlayId = date.millisecondsSinceEpoch.toString();

    final TileOverlay tileOverlay = TileOverlay(
      tileOverlayId: TileOverlayId(overlayId),
      tileProvider: ForecastTileProvider(
        dateTime: date,
        // mapType: 'PAR0',
        mapType: 'PR0',
        opacity: 0.4,
      ),
    );
    setState(() {
      _tileOverlay = tileOverlay;
    });
  }

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(35, -14),
    zoom: 4,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            onMapCreated: (GoogleMapController controller) {
              setState(() {});
              _initTiles(_forecastDate);
            },
            tileOverlays:
                _tileOverlay == null ? {} : <TileOverlay>{_tileOverlay!},
          ),
          Positioned(
            bottom: 30,
            child: SizedBox(
              height: 90,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 20,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _forecastDate =
                              _forecastDate.subtract(const Duration(hours: 3));
                        });
                        _initTiles(_forecastDate);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        backgroundColor: const Color(0XFF2b2b2b),
                        shadowColor: Colors.blue.shade200,
                        elevation: 8,
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Color(0xffa3865d),
                        size: 30,
                      ),
                    ),
                  ),
                  Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 10,
                      shadowColor: Colors.grey.shade400,
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black),
                        child: Text(
                          'Prediction Date:\n${DateFormat('yyyy-MM-dd ha').format(_forecastDate)}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xffa3865d),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    child: ElevatedButton(
                      onPressed:
                          _forecastDate.difference(DateTime.now()).inDays >= 10
                              ? null
                              : () {
                                  setState(() {
                                    _forecastDate = _forecastDate
                                        .add(const Duration(hours: 3));
                                  });
                                  _initTiles(_forecastDate);
                                },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        backgroundColor:
                            _forecastDate.difference(DateTime.now()).inDays >=
                                    10
                                ? Colors.grey
                                : const Color(0xff2b2b2b),
                        shadowColor:
                            _forecastDate.difference(DateTime.now()).inDays >=
                                    10
                                ? Colors.transparent
                                : const Color(0xff2b2b2b),
                        elevation:
                            _forecastDate.difference(DateTime.now()).inDays >=
                                    10
                                ? 0
                                : 8,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Color(0xffa3865d),
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
