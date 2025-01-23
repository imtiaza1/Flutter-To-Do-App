import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'dbService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool personal = true, office = false, college = false;
  bool suggest = false;
  TextEditingController todoController = TextEditingController();
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
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  personal
                      ? Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
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
                          onTap: () {
                            personal = true;
                            office = false;
                            college = false;
                            setState(() {});
                          },
                          child: Text(
                            "Personal",
                            style: TextStyle(fontSize: 20),
                          )),
                  college
                      ? Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
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
                          onTap: () {
                            personal = false;
                            office = false;
                            college = true;
                            setState(() {});
                          },
                          child: Text(
                            "College",
                            style: TextStyle(fontSize: 20),
                          )),
                  office
                      ? Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
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
                          onTap: () {
                            personal = false;
                            office = true;
                            college = false;
                            setState(() {});
                          },
                          child: Text(
                            "Office",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CheckboxListTile(
                activeColor: Colors.green.shade400,
                title: Text("Do it Today"),
                value: suggest,
                onChanged: (newvalue) {
                  setState(() {
                    suggest = newvalue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            )
          ],
        ),
      ),
    );
  }

  openBox() {
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
                          String Task=todoController.text.toString();
                          Map<String,dynamic>userTodo={
                            "work":Task,
                            "id":id
                          };
                          if(todoController.text.trim().isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Task cannot be empty!",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),
                                backgroundColor: Colors.redAccent.shade400,
                              ),
                            );
                          }else{
                            if(personal){
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
                                        color: Colors.black
                                    ),
                                  ),
                                  backgroundColor: Colors.green.shade400,
                                ),
                              );
                            }else if(college){
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
                                        color: Colors.black
                                    ),
                                  ),
                                  backgroundColor: Colors.green.shade400,
                                ),
                              );
                            }else{
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
                                        color: Colors.black
                                    ),
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
