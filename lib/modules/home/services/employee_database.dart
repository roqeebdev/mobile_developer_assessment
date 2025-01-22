import 'package:mobile_assessment/modules/home/models/employee.model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/employees.db';

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE employees (
           id INTEGER PRIMARY KEY,
            firstName TEXT,
            lastName TEXT,
            designation TEXT,
            level INTEGER,
            productivityScore REAL,
            currentSalary TEXT,
            employmentStatus INTEGER
          )
        ''');
      },
    );
  }

  Future<void> saveEmployees(List<Employee> employees) async {
    final db = await database;
    for (var employee in employees) {
      await db.insert(
        'employees',
        {
          'id': employee.id,
          'firstName': employee.firstName,
          'lastName': employee.lastName,
          'designation': employee.designation,
          'level': employee.level,
          'productivityScore': employee.productivityScore,
          'currentSalary': employee.currentSalary,
          'employmentStatus': employee.employmentStatus,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Employee>> fetchAllEmployees() async {
    final db = await database;
    final result = await db.query('employees');
    return result.map((e) => Employee.fromJson(e)).toList();
  }

  Future<void> clearEmployees() async {
    final db = await database;
    await db.delete('employees');
  }
}
