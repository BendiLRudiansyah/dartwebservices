import 'package:mysql_client/mysql_client.dart';

import '../config/conection.dart';

abstract class Mysql {
Future createConnection();

  Future fetchData({required MySQLConnection conn, required String table, Map<String, dynamic>? join});
  Future insertData({required MySQLConnection conn, required String table, required List<String> columns, required dynamic body});
}
class MysqlClient extends Mysql{
  @override
  Future createConnection() async{
    // TODO: implement createConnection
   MySQLConnection conn = await Connection.getKoneksi();
    return conn;
  }

  @override
  Future fetchData({required MySQLConnection conn, required String table, Map<String, dynamic>? join}) async{
    // TODO: implement fetchData
    StringBuffer sql = StringBuffer();
    IResultSet result;

    sql.clear();
    sql.write("SELECT * FROM $table \n");
    if(join != null) {
      join["tables"].forEach((element) {
        sql.write("${join["join"]} ${element["table"]} \n");
        sql.write("   ON ${element["table"]}.${element["column"]} = $table.${element["column"]} \n");
      });
    }
    result = await conn.execute(sql.toString());

    return result;
  }

  @override
  Future insertData({required MySQLConnection conn, required String table, required List<String> columns, required body}) {
    // TODO: implement insertData
    throw UnimplementedError();
  }
  
}