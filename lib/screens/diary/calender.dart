// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'diary_page.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime? _selectedDate;
  DateTime _focusedDay = DateTime.now();
  late CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<DateTime, Map<String, dynamic>> _dateEntries = {};

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _loadDiaryEntries();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadDiaryEntries(); // 페이지로 돌아올 때마다 데이터 새로 로드
  }

  Future<void> _loadDiaryEntries() async {
    // Firebase 없이 동작하도록 주석 처리 및 시뮬레이션 코드 추가
    // final uid = FirebaseAuth.instance.currentUser?.uid;
    final uid = "dummy_user_id"; // Firebase를 대체하는 더미 사용자 ID
    if (uid != null) {
      final entries = await loadDiaryEntries(uid);
      if (mounted) {
        setState(() {
          _dateEntries = entries;
        });
      }
    }
  }

  void _onMonthChange(int direction) {
    setState(() {
      _focusedDay = DateTime(
        _focusedDay.year,
        _focusedDay.month + direction,
        1,
      );
      if (_focusedDay.month > 12) {
        _focusedDay = DateTime(_focusedDay.year + 1, 1, 1);
      } else if (_focusedDay.month < 1) {
        _focusedDay = DateTime(_focusedDay.year - 1, 12, 1);
      }
      if (_selectedDate != null &&
          (_selectedDate!.month != _focusedDay.month ||
              _selectedDate!.year != _focusedDay.year)) {
        _selectedDate = DateTime(_focusedDay.year, _focusedDay.month, 1);
      }
    });
  }

  void _selectDate(DateTime date) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiaryPage(
          date: date,
          initialImageUrl: _dateEntries[date]?['imageUrl'],
          initialNote: _dateEntries[date]?['note'],
          onSave: (imageUrl, note) {
            setState(() {
              _dateEntries[date] = {
                'imageUrl': imageUrl,
                'note': note,
              };
            });
            _loadDiaryEntries(); // 저장 후 데이터 다시 로드
          },
          onDelete: () {
            setState(() {
              _dateEntries.remove(date);
            });
            _loadDiaryEntries(); // 삭제 후 데이터 다시 로드
          },
        ),
      ),
    ).then((_) => _loadDiaryEntries()); // DiaryPage에서 돌아올 때 데이터 다시 로드
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat monthFormat = DateFormat('MMMM');
    final DateFormat yearFormat = DateFormat('yyyy');
    final DateFormat selectedDateFormat = DateFormat('yyyy.MM.dd');
    String formattedDay =
        _selectedDate != null ? DateFormat('d').format(_selectedDate!) : '';
    String formattedMonth = _focusedDay != null
        ? monthFormat.format(_focusedDay)
        : 'No month selected!';
    String formattedYear =
        _focusedDay != null ? yearFormat.format(_focusedDay) : '';
    String formattedSelectedDate =
        _selectedDate != null ? selectedDateFormat.format(_selectedDate!) : '';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            height: 240,
            color: Color(0XFFFFDCB2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40),
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                      onPressed: () => _onMonthChange(-1),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              formattedMonth,
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: "Quando",
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              formattedYear,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Quando",
                                color: Color(0XFF43493E),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              formattedSelectedDate,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Quando",
                                color: Color(0XFF43493E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                      onPressed: () => _onMonthChange(1),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 45),
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TableCalendar(
                    firstDay: DateTime(2000),
                    lastDay: DateTime(2100),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDate, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDate = selectedDay;
                        _focusedDay = focusedDay;
                      });
                      _selectDate(selectedDay);
                    },
                    calendarFormat: _calendarFormat,
                    onFormatChanged: (format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    },
                    headerVisible: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Firebase 없이 작동하는 시뮬레이션 데이터 로드 함수
Future<Map<DateTime, Map<String, dynamic>>> loadDiaryEntries(String uid) async {
  // Firebase 대신 더미 데이터를 반환합니다.
  print("Simulating loading diary entries for user: $uid");
  return {
    DateTime.now(): {'note': 'Simulated note', 'imageUrl': null},
  };
}
