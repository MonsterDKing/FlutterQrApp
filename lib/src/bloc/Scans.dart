import 'dart:async';

import 'package:qrreaderapp/src/providers/db_provider.dart';


class ScansBloc {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }


  ScansBloc._internal(){
    //Obtener scans de la base de datos 
    obtenerScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;


  dispose(){
    _scansController?.close();
  }



  //Metodo para obtenre toda la informacion de los scans atravez de 
  obtenerScans() async {
    _scansController.sink.add( await DBProvider.db.getTodosScans());
  }

  agregarScan(ScanModel scan) async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }
  //borrar scans

  borrarScans(int id)async{
   await DBProvider.db.deleteScan(id);
   obtenerScans();
  }

  borrarTodosScans() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }




}