import 'dart:convert';
import 'dart:io';

import 'package:mysql_client/mysql_client.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'helpers/mysql_client.dart';
import 'model/mahasiswa.dart';
import 'services/mhs_services.dart';
MysqlClient client=MysqlClient();
// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get("/mahasiswa", getMahasiswa)
  ..get('/echo/<message>', _echoHandler);
Future<Response> getMahasiswa(Request req) async{
  try {
    final MySQLConnection conn;
    final List<Mahasiswa> results = [];
    final ResultSet rs;

    conn = await client.createConnection();
    await conn.connect();
    print("connected");
    rs = await client.fetchData(conn: conn, table: "tb_mahasiswa", join: {
      "join": "LEFT JOIN",
      "tables": [{
        "table": "tb_prodi",
        "column": "prodi_id"
      }]
    });
    for(var item in rs.rows) {
      var data = {};

      data["mhs_id"] = item.assoc()["mhs_id"];
      data["mhs_npm"] = item.assoc()["mhs_npm"];
      data["mhs_nama"] = item.assoc()["mhs_nama"];
      data["mhs_jk"] = item.assoc()["mhs_jk"];
      data["prodi"] = json.encode({
        "prodi_id": item.assoc()["prodi_id"],
        "prodi_nama": item.assoc()["prodi_nama"]
      });
      data["mhs_foto_1"] = item.assoc()["mhs_foto_1"];
      data["mhs_foto_2"] = item.assoc()["mhs_foto_2"];


      results.add(mahasiswaFromJson(json.encode(data)));
    }
    await Future.delayed(Duration.zero);
    await conn.close();

    return Response.ok(mahasiswasToJson(results));
  } catch(e) {
    print(e);
    return Response(400, body: e);
  }
}
Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
