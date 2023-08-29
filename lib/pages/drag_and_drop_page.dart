import 'package:flutter/material.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

class DragAndDropPage extends StatefulWidget {
  const DragAndDropPage({Key? key}) : super(key: key);

  @override
  State<DragAndDropPage> createState() => _DragAndDropPageState();
}

class _DragAndDropPageState extends State<DragAndDropPage> {
  List<Word> wordList = [
    Word(qes: 'car', ans: '차'),
    Word(qes: 'apple', ans: '사과'),
    Word(qes: 'banana', ans: '바나나'),
    Word(qes: 'orange', ans: '오렌지'),
    Word(qes: 'flutter', ans: '실룩거리다'),
  ];
  void moveStationOrder(int oldIndex, int newIndex) {
    if (oldIndex != newIndex) {
      Word movedStation = wordList.removeAt(oldIndex);
      wordList.insert(newIndex, movedStation);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: DragAndDropLists(
              listDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
                border: Border.all(
                  color: Colors.blue,
                  width: 1,
                ),
                color: Colors.white,
              ),
              children: List.generate(
                wordList.length,
                (index) => DragAndDropList(
                  header: Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      top: 24,
                    ),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow,
                          ),
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          wordList[index].qes,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  children: <DragAndDropItem>[
                    DragAndDropItem(
                      child: GestureDetector(
                        child: Container(
                          width: 288,
                          margin: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Text(
                                '정답 : ${wordList[index].ans}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onItemReorder: (int a, int b, int c, int d) => {},
              onListReorder: moveStationOrder,
              onListDraggingChanged: (list, dragging) => print('zz'),
              listPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              listDragHandle: DragHandle(
                verticalAlignment: DragHandleVerticalAlignment.top,
                child: Padding(
                    padding: EdgeInsets.only(
                      right: 16,
                      top: 26,
                    ),
                    child: Icon(Icons.menu)),
              ),
              listDecorationWhileDragging: BoxDecoration(
                color: Colors.white.withOpacity(.3),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Word {
  final String qes;
  final String ans;

  Word({
    required this.qes,
    required this.ans,
  });
}
