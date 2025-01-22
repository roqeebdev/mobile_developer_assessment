class Employee {
  final int id;
  final String firstName;
  final String lastName;
  final String designation;
  final int level;
  final double productivityScore;
  final String currentSalary;
  final int employmentStatus;

  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.designation,
    required this.level,
    required this.productivityScore,
    required this.currentSalary,
    required this.employmentStatus,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      designation: json['designation'],
      level: json['level'],
      productivityScore: json['productivity_score'],
      currentSalary: json['current_salary'],
      employmentStatus: json['employment_status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'designation': designation,
      'level': level,
      'productivity_score': productivityScore,
      'current_salary': currentSalary,
      'employment_status': employmentStatus,
    };
  }
  Employee copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? designation,
    int? level,
    double? productivityScore,
    String? currentSalary,
    int? employmentStatus,
  }) {
    return Employee(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      designation: designation ?? this.designation,
      level: level ?? this.level,
      productivityScore: productivityScore ?? this.productivityScore,
      currentSalary: currentSalary ?? this.currentSalary,
      employmentStatus: employmentStatus ?? this.employmentStatus,
    );
  }
}
