import 'dart:async';

import 'package:qrreaderapp/src/bloc/validator.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _singleton = new ScansBloc._internal();
  factory ScansBloc() {
    return _singleton;
  }
  ScansBloc._internal() {
    //Obtener scans de la base de datos
    obtenerScans();
  }

  final _scanController = StreamController<List<ScanModel>>.broadcast();
  Stream<List<ScanModel>> get scansStream =>
      _scanController.stream.transform(validarGeo);
  Stream<List<ScanModel>> get scansStreamHttp =>
      _scanController.stream.transform(validarHttp);

  dispose() {
    _scanController?.close();
  }

  obtenerScans() async {
    _scanController.sink.add(await DBProvider.db.getTodosScans());
  }

  agregarScan(ScanModel scan) async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScanTodos() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }
}
