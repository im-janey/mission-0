// import 'dart:typed_data';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart'; // 주석 처리
// // import 'package:firebase_storage/firebase_storage.dart'; // 주석 처리
// import 'package:intl/intl.dart';

// import 'upload_image.dart';
// // import 'firestore_service.dart'; // 주석 처리

// class DiaryPage extends StatefulWidget {
//   final DateTime date;
//   final String? initialNote;
//   final String? initialImageUrl;
//   final void Function(String? imageUrl, String note) onSave;
//   final VoidCallback onDelete;

//   DiaryPage({
//     required this.date,
//     this.initialNote,
//     this.initialImageUrl,
//     required this.onSave,
//     required this.onDelete,
//   });

//   @override
//   _DiaryPageState createState() => _DiaryPageState();
// }

// class _DiaryPageState extends State<DiaryPage> {
//   late TextEditingController _noteController;
//   // final FirestoreService _firestoreService = FirestoreService(); // 주석 처리
//   bool _isSaved = false;
//   bool _isEditing = false;
//   Uint8List? _imageBytes;
//   String? _imageUrl;

//   @override
//   void initState() {
//     super.initState();
//     _noteController = TextEditingController(text: widget.initialNote);
//     _imageUrl = widget.initialImageUrl;
//     // _loadDiaryEntry(); // 주석 처리
//   }

//   @override
//   void dispose() {
//     _noteController.dispose();
//     super.dispose();
//   }

//   // Firebase 관련 함수들 주석 처리
//   // Future<void> _loadDiaryEntry() async {
//   //   // Firestore에서 데이터 가져오기 로직
//   // }

//   Future<void> _save() async {
//     // FirebaseAuth 관련 코드 제거
//     // FirebaseStorage 업로드 로직 제거

//     try {
//       // _firestoreService.saveDiaryEntry(...); // 주석 처리

//       widget.onSave(_imageUrl, _noteController.text);
//       setState(() {
//         _isSaved = true;
//         _isEditing = false;
//       });
//       Navigator.of(context).pop(); // 현재 DiaryPage 닫기
//     } catch (e) {
//       print('Failed to save diary entry: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('다이어리 저장 실패')),
//       );
//     }
//   }

//   // Future<void> _deleteDiaryEntry() async {
//   //   // Firestore 문서 삭제 로직 제거
//   //   // Firebase Storage에서 이미지 삭제 로직 제거
//   // }

//   void _resetState() {
//     setState(() {
//       _isSaved = false;
//       _isEditing = true;
//       _noteController.text = '';
//       _imageBytes = null;
//       _imageUrl = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(CupertinoIcons.xmark),
//         ),
//         centerTitle: true,
//         title: Text(
//           DateFormat('yyyy년 M월').format(widget.date),
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         actions: [
//           if (_isEditing || !_isSaved)
//             IconButton(
//               icon: Icon(Icons.check),
//               onPressed: _save,
//             ),
//         ],
//         backgroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.only(left: 8),
//                 child: Row(
//                   children: [
//                     Text(
//                       '${DateFormat('d ').format(widget.date)}',
//                       style:
//                           TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
//                     ),
//                     Text(
//                       '${DateFormat('EEEE').format(widget.date)}',
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                     ),
//                     Spacer(),
//                     if (_isSaved && !_isEditing)
//                       IconButton(
//                         onPressed: _showBottomSheet,
//                         icon: Icon(Icons.more_vert),
//                       ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 padding: EdgeInsets.all(8.0),
//                 child: Column(
//                   children: <Widget>[
//                     TextField(
//                       controller: _noteController,
//                       cursorColor: Color(0XFFFF9C27),
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: '소중한 추억을 기록하세요...',
//                         hintStyle: TextStyle(color: Color(0XFF74828D)),
//                       ),
//                       style: TextStyle(color: Color(0XFF4E5968)),
//                       maxLines: null,
//                       enabled: _isEditing ||
//                           (_noteController.text.isEmpty || _imageBytes == null),
//                     ),
//                     SizedBox(height: 10),
//                     Container(
//                       height: 300,
//                       width: double.infinity,
//                       color: Colors.white,
//                       child: Stack(
//                         fit: StackFit.expand,
//                         children: [
//                           if (_imageBytes != null)
//                             Image.memory(
//                               _imageBytes!,
//                               fit: BoxFit.cover,
//                             )
//                           else if (_imageUrl != null)
//                             Image.network(
//                               _imageUrl!,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Center(
//                                     child: Text('이미지를 불러오는 중 문제가 발생했습니다.'));
//                               },
//                             ),
//                           Positioned(
//                             bottom: 8,
//                             right: 8,
//                             child: UploadImage(onPickImage: _handleImagePick),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
