import 'package:flutter/cupertino.dart';

class Task {
  final int id;
  final String title;
  final String note;
  final int isCompleted;
  final String date;
  final String startTime;
  final String endTime;
  final int color;
  final int remind;
  final String repeat;

//<editor-fold desc="Data Methods">

  Task({
    this.id,
    @required this.title,
    @required this.note,
    @required this.isCompleted,
    @required this.date,
    @required this.startTime,
    @required this.endTime,
    @required this.color,
    @required this.remind,
    @required this.repeat,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          note == other.note &&
          isCompleted == other.isCompleted &&
          date == other.date &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          color == other.color &&
          remind == other.remind &&
          repeat == other.repeat);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      note.hashCode ^
      isCompleted.hashCode ^
      date.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      color.hashCode ^
      remind.hashCode ^
      repeat.hashCode;

  @override
  String toString() {
    return 'Task{' +
        ' id: $id,' +
        ' title: $title,' +
        ' note: $note,' +
        ' isCompleted: $isCompleted,' +
        ' date: $date,' +
        ' startTime: $startTime,' +
        ' endTime: $endTime,' +
        ' color: $color,' +
        ' remind: $remind,' +
        ' repeat: $repeat,' +
        '}';
  }

  Task copyWith({
    int id,
    String title,
    String note,
    int isCompleted,
    String date,
    String startTime,
    String endTime,
    int color,
    int remind,
    String repeat,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      color: color ?? this.color,
      remind: remind ?? this.remind,
      repeat: repeat ?? this.repeat,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'title': this.title,
      'note': this.note,
      'isCompleted': this.isCompleted,
      'date': this.date,
      'startTime': this.startTime,
      'endTime': this.endTime,
      'color': this.color,
      'remind': this.remind,
      'repeat': this.repeat,
    };
  }

 factory Task.fromJson(Map<String, dynamic> Json) {
    return Task(
      id: Json['id'] ,
      title: Json['title'],
      note: Json['note'],
      isCompleted: Json['isCompleted'] ,
      date: Json['date'] ,
      startTime: Json['startTime'] ,
      endTime: Json['endTime'],
      color: Json['color'] ,
      remind: Json['remind'] ,
      repeat: Json['repeat'] ,);
  }

//</editor-fold>
}
