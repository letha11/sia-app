import 'dart:convert';

import 'package:equatable/equatable.dart';

class Transcript extends Equatable {
  final List<TranscriptData>? data;
  final bool? success;

  const Transcript({this.data, this.success});

  factory Transcript.fromJson(Map<String, dynamic> data) => Transcript(
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => TranscriptData.fromMap(e as Map<String, dynamic>))
            .toList(),
        success: data['success'] as bool?,
      );

  String toJson() {
    return json.encode({
      'data': data?.map((e) => e.toMap()).toList(),
      'success': success,
    });
  }

  Transcript copyWith({
    List<TranscriptData>? data,
    bool? success,
  }) {
    return Transcript(
      data: data ?? this.data,
      success: success ?? this.success,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [data, success];
}

class TranscriptData extends Equatable {
  final String? grade;
  final String? number;
  final String? semester;
  final String? sks;
  final String? subject;
  final String? subjectCode;

  const TranscriptData({
    this.grade,
    this.number,
    this.semester,
    this.sks,
    this.subject,
    this.subjectCode,
  });

  factory TranscriptData.fromMap(Map<String, dynamic> data) => TranscriptData(
        grade: data['grade'] as String?,
        number: data['number'] as String?,
        semester: data['semester'] as String?,
        sks: data['sks'] as String?,
        subject: data['subject'] as String?,
        subjectCode: data['subject_code'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'grade': grade,
        'number': number,
        'semester': semester,
        'sks': sks,
        'subject': subject,
        'subject_code': subjectCode,
      };

  factory TranscriptData.fromJson(String data) {
    return TranscriptData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  TranscriptData copyWith({
    String? grade,
    String? number,
    String? semester,
    String? sks,
    String? subject,
    String? subjectCode,
  }) {
    return TranscriptData(
      grade: grade ?? this.grade,
      number: number ?? this.number,
      semester: semester ?? this.semester,
      sks: sks ?? this.sks,
      subject: subject ?? this.subject,
      subjectCode: subjectCode ?? this.subjectCode,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      grade,
      number,
      semester,
      sks,
      subject,
      subjectCode,
    ];
  }
}
