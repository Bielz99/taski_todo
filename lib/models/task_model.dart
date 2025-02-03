class Task {
  int? id;
  String title;
  String subtitle;
  bool isChecked;

  Task({
    this.id,
    required this.title,
    required this.subtitle,
    this.isChecked = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'isChecked': isChecked ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      isChecked: map['isChecked'] == 1,
    );
  }
}
