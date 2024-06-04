import 'package:mysql1/mysql1.dart';
import 'dart:async';

class Database{

  Database();

  MySqlConnection? conn;

  Future<void> connectDB() async {
// Create a connection settings object
    conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: '*****',
      db: 'DBNAME',
    ),
    );

    // Create a connection object
    print("Database connetcion made!");
  }

  Future<String> sendQuery (String sqlQuery) async {
    // Send a query and get the results
    final results = await conn?.query(sqlQuery);
    print("Query sent: $sqlQuery");

    late var result;
    for (var row in results!) {
      result = row[0];
    }

    return result.toString();
  }


  Future<List<String>> sendListQuery(String sqlQuery) async {
    // Send a query and get the results
    final results = await conn?.query(sqlQuery);
    print("Query sent: $sqlQuery");

    if (results != null) {
      List<String> resultList = [];
      for (var row in results) {
        resultList.add(row.first.toString());
      }
      return resultList;
    } else {
      // Handle the case where results is null, e.g., return an empty list
      return [];
    }
  }

  Future<dynamic> noReturnQuery (String sqlQuery) async {
    // Send a query and get the results
    final results = await conn?.query(sqlQuery);
    print("Query sent: $sqlQuery");
  }

  Future<void> closeDB() async {
    // Close the connection
    await conn?.close();
    print("Database connection closed!");
  }
}
