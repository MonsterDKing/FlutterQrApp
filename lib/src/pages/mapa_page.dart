import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';


class MapaPage extends StatelessWidget {

  final map = new MapController();
  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text('Coordenadas QR'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.my_location),
              onPressed: (){
                map.move(scan.getLatLng(), 15);
              },
            )
          ],
        ),
        body: _crearFlutterMap(scan),
    );
  }

  Widget _crearFlutterMap(ScanModel scan){
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center:  scan.getLatLng(),
        zoom: 17
      ),
      layers: [
        _crearMapa(),
        _crearMarcador(scan)
      ],
    );
  }

  _crearMapa(){
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1Ijoia2luZ29ma2luZzk5IiwiYSI6ImNqeHNyZ3A3ZzBtcjEzbXJzM2N0ZXVyYjQifQ.BGjgSReTmfWfg3pEeNSO9g',
        'id': 'mapbox.satellite' //streets,  dark , light , outdoors, satellite 
      }
    );
  }

  _crearMarcador(ScanModel scan){
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 120.0,
          height: 120.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
            child: Icon(Icons.location_on, size: 70, color:  Theme.of(context).primaryColor,),
          )
        )
      ]
    );
  }
}