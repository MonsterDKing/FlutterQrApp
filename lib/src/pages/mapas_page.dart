import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/Scans.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as util;

class MapasPage extends StatelessWidget {

  final scansBloc = new ScansBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final scans = snapshot.data;
        if (scans.length == 0) {
          return Center(
            child: Text('No hay informacion'),
          );
        }
        return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, i) => Dismissible(
                  onDismissed: (direccion) => scansBloc.borrarScans(scans[i].id),
                  background: Container(
                    color: Colors.red,
                  ),
                  key: UniqueKey(),
                  child: ListTile(
                    onTap: () => util.abrirScan(scans[i],context),
                    leading: Icon(
                      Icons.cloud_queue,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(scans[i].valor),
                    subtitle: Text('ID : ${scans[i].id}'),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                    ),
                  ),
                ));
      },
    );
  }
}
