import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  List<ToDo> toDoList = [];

  _addToDo() {
    ToDo toDoItem = ToDo();
    toDoItem.title = titleController.text;
    toDoItem.description = descController.text;
    toDoItem.isDone = false;

    setState(() {
      if (toDoItem.title != '' && toDoItem.description != '') {
        toDoList.add(toDoItem);
      }
    });
    titleController.clear();
    descController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Title',
              ),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Description',
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: toDoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      toDoList[index].title ?? '',
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      toDoList[index].description ?? '',
                      maxLines: 3,
                    ),
                    leading: InkWell(
                      onTap: () => {
                        setState(() {
                          toDoList[index].isDone = !(toDoList[index].isDone)!;
                        })
                      },
                      child: Icon(Icons.check_box,
                          color: toDoList[index].isDone == true
                              ? Colors.green
                              : Colors.grey),
                    ),
                    trailing: InkWell(
                      onTap: () => {
                        setState(() {
                          toDoList.remove(toDoList[index]);
                        })
                      },
                      child: const Icon(Icons.delete),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addToDo,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}

class ToDo {
  String? title;
  String? description;
  bool? isDone;
}
