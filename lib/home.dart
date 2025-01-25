import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'dbService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool Personal = true, Office = false, College = false;
  bool suggest = false;
  TextEditingController todoController = TextEditingController();
  Stream?toDoTask;

  getOnTheLoad() async {
    toDoTask = await DataBaseService().getTask(Personal
        ? "Personal"
        : Office
            ? "Office"
            : "College");
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  Widget getWork() {
    return StreamBuilder(
      stream: toDoTask,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Show a loader while waiting for data
        }
        if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return Center(child: Text("No Data Found")); // Show a message if no data is available
        }
        return ListView.builder(
          shrinkWrap: true, // Ensures ListView takes only the required space
          physics: NeverScrollableScrollPhysics(), // Disables scrolling to avoid conflict with parent scrolling
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot data = snapshot.data.docs[index];
            print(data["work"]);
            return CheckboxListTile(
              activeColor: Colors.green.shade400,
              title: Text(data["work"]),
              value: data["Yes"],
              onChanged: (newValue){
                Future.delayed(Duration(seconds: 5),(){
                  DataBaseService().DeleteTask(data["id"], Personal?"Personal":Office?"Office":"College");
                });
                setState(() async{
                  await DataBaseService().TicMethod(
                      data["id"], Personal
                      ? "Personal"
                      : Office
                      ? "Office"
                      : "College");
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade400,
        onPressed: () {
          openBox();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      appBar: AppBar(
        title: Text("data"),
        // backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Add this line to resolve the issue
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Personal
                      ? Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Personal",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                      : GestureDetector(
                      onTap: () async {
                        Personal = true;
                        Office = false;
                        College = false;
                        await getOnTheLoad();
                        setState(() {});
                      },
                      child: Text(
                        "Personal",
                        style: TextStyle(fontSize: 20),
                      )),
                  College
                      ? Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "College",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                      : GestureDetector(
                      onTap: () async {
                        Personal = false;
                        Office = false;
                        College = true;
                        await getOnTheLoad();
                        setState(() {});
                      },
                      child: Text(
                        "College",
                        style: TextStyle(fontSize: 20),
                      )),
                  Office
                      ? Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Office",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                      : GestureDetector(
                      onTap: () async {
                        Personal = false;
                        Office = true;
                        College = false;
                        await getOnTheLoad();
                        setState(() {});
                      },
                      child: Text(
                        "Office",
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            getWork(), // Ensure this widget does not use Expanded or Flexible
          ],
        ),
      ),

    );
  }

  Future openBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            content: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Align cancel to the corner
                    children: [
                      Text(
                        "Add ToDo Task",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Colors.red.shade400,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      hintText: "Enter Task!",
                      hintStyle: TextStyle(
                          color: Colors.grey.shade600), // Subtle hint color
                      labelText: "Task",
                      labelStyle: TextStyle(
                          color: Colors.blue.shade800), // Blue label color
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded border
                        borderSide: BorderSide(
                          color: Colors.blue.shade800, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded border
                        borderSide: BorderSide(
                          color: Colors.blue, // Border color when focused
                          width: 2.0, // Border width when focused
                        ),
                      ),
                      filled: true, // Add a background color
                      fillColor: Colors.grey.shade100, // Light grey background
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10), // Padding inside the input
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          String id = randomAlphaNumeric(10);
                          String Task = todoController.text.toString();
                          Map<String, dynamic> userTodo = {
                            "work": Task,
                            "id": id,
                            "Yes":false,
                          };
                          if (todoController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Task cannot be empty!",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                backgroundColor: Colors.redAccent.shade400,
                              ),
                            );
                          } else {
                            if (Personal) {
                              DataBaseService().addPersonalTask(userTodo, id);
                              Navigator.pop(context);
                              todoController.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Task added successfully to Personal",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  backgroundColor: Colors.green.shade400,
                                ),
                              );
                            } else if (College) {
                              DataBaseService().addCollegTask(userTodo, id);
                              Navigator.pop(context);
                              todoController.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Task added successfully to College",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  backgroundColor: Colors.green.shade400,
                                ),
                              );
                            } else {
                              DataBaseService().addOfficeTask(userTodo, id);
                              Navigator.pop(context);
                              todoController.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Task added successfully to Office",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  backgroundColor: Colors.green.shade400,
                                ),
                              );
                            }
                          }
                        },
                        child: Text("Save")),
                  )
                ],
              ),
            ),
          );
        });
  }
}
