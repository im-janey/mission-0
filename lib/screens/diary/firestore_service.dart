// import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveDiaryEntry(
      String userId, DateTime date, String note, String? imageUrl) async {
    try {
      // Firebase를 사용하는 코드를 주석 처리하고, 대신 print 문으로 대체합니다.
      print('Simulated saving diary entry for $userId on $date');
      print('Note: $note, Image URL: $imageUrl');
    } catch (e) {
      print('Failed to save diary entry: $e');
      throw e;
    }
  }

  Future<DiaryEntry?> getDiaryEntry(String userId, DateTime date) async {
    try {
      // Firebase 없이 시뮬레이션 데이터를 반환하도록 수정
      print('Simulated fetching diary entry for $userId on $date');
      return DiaryEntry(
        note: 'Simulated note',
        imageUrl: 'https://example.com/simulated_image.jpg',
        date: date,
      );
    } catch (e) {
      print('Error fetching diary entry: $e');
      return null;
    }
  }

  Future<void> deleteDiaryEntry(String userId, DateTime date) async {
    try {
      // Firebase를 사용하는 코드를 주석 처리하고, 대신 print 문으로 대체합니다.
      print('Simulated deleting diary entry for $userId on $date');
    } catch (e) {
      print('Failed to delete diary entry: $e');
      throw e;
    }
  }
}

// DiaryEntry 클래스의 예시 (Firestore 데이터 모델)
class DiaryEntry {
  final String? note;
  final String? imageUrl;
  final DateTime? date;

  DiaryEntry({this.note, this.imageUrl, this.date});

  factory DiaryEntry.fromFirestore(Map<String, dynamic> data) {
    return DiaryEntry(
      note: data['note'],
      imageUrl: data['imageUrl'],
      date: DateTime.parse(data['date']), // 문자열을 DateTime으로 변환
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'note': note,
      'imageUrl': imageUrl,
      'date': date?.toIso8601String(), // DateTime을 문자열로 변환
    };
  }
}
