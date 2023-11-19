import 'package:mysql_client/mysql_client.dart';

class Connection {
 static const connectionInfo ={

  "host": "localhost",
  "port": 3306,
    "username": "al_api",
    "password": "Test1234",
    "dbName": "ws_api",
    "secure": false
 }; 
 static Future getKoneksi() async {
    final mysql = await MySQLConnection.createConnection(
      host: Connection.connectionInfo["host"],
      port: Connection.connectionInfo["port"] as int,
      userName: Connection.connectionInfo["username"] as String,
      password: Connection.connectionInfo["password"] as String,
      databaseName: Connection.connectionInfo["dbName"] as String,
      secure: Connection.connectionInfo["secure"] as bool
    );

    return mysql;
  }

}