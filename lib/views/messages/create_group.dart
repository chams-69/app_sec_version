import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final _formKey = GlobalKey<FormState>();
  late String _groupName;

  List<Map<String, dynamic>> allPlayers = [
    //name=fname+lname
    {"userName": "Chams69", "name": "Chams Ben Hmouda"},
    {"userName": "Mahdi", "name": "Mahdi Nasri"},
    {"userName": "hlayem", "name": "mohamed hlayem"},
    {"userName": "nasri", "name": "mohamed nasri"},
    {"userName": "mohamed", "name": "mohamed mohamed"},
    {"userName": "foulen", "name": "foulen fouleni"},
    {"userName": "wahch", "name": "mohamed ali"},
    {"userName": "Chams69", "name": "Chams Ben Hmouda"},
    {"userName": "Mahdi", "name": "Mahdi Nasri"},
    {"userName": "hlayem", "name": "mohamed hlayem"},
    {"userName": "nasri", "name": "mohamed nasri"},
    {"userName": "mohamed", "name": "mohamed mohamed"},
    {"userName": "foulen", "name": "foulen fouleni"},
    {"userName": "wahch", "name": "mohamed ali"},
  ];

  List<Map<String, dynamic>> found = [];
  @override
  void initState() {
    found = allPlayers;
    super.initState();
  }

  void filter(String onSearch) {
    List<Map<String, dynamic>> results = [];
    if (onSearch.isEmpty) {
      results = allPlayers;
    } else {
      results = allPlayers
          .where((element) =>
              element["name"]
                  .toString()
                  .toLowerCase()
                  .contains(onSearch.toLowerCase()) ||
              element["userName"]
                  .toString()
                  .toLowerCase()
                  .contains(onSearch.toLowerCase()))
          .toList();
    }
    setState(() {
      found = results;
    });
  }

  List<Map<String, dynamic>> selectedPlayers = [];

  void togglePlayerSelection(int index) {
    setState(() {
      if (selectedPlayers.contains(found[index])) {
        selectedPlayers.remove(found[index]);
      } else {
        selectedPlayers.add(found[index]);
      }
    });
  }

  String? imagePath;

  @override
  Widget build(BuildContext context) {
    double a = 0;
    double screenWidth = MediaQuery.of(context).size.width;
    double width(double width) {
      a = width / 430;
      return screenWidth * a;
    }

    return Scaffold(
      backgroundColor: const Color(0xff343835),
      appBar: AppBar(
        backgroundColor: const Color(0xff343835),
        iconTheme: const IconThemeData(color: Color(0xFFF1EED0)),
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Create Group',
            style: TextStyle(
              color: Color(0xFFF1EED0),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                },
                child: const Text(
                  'Create',
                  style: TextStyle(
                    color: Color(0xFF599068),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width(20)),
          child: Column(
            children: [
              SizedBox(width: width(13)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width(21)),
                child: InkWell(
                  onTap: () async {
                    try {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() {
                          imagePath = pickedFile.path;
                        });
                      }
                    } on PlatformException catch (e) {
                      print('Failed to pick image: $e');
                    }
                  },
                  child: Ink(
                    child: Stack(
                      children: [
                        Container(
                          width: width(348),
                          height: width(174),
                          color: const Color(0xff474D48),
                          child: imagePath != null
                              ? Image.file(
                                  File(imagePath!),
                                  fit: BoxFit.cover,
                                  opacity: const AlwaysStoppedAnimation(0.2),
                                )
                              : Image.asset(
                                  'assets/images/groupCover.png',
                                  fit: BoxFit.cover,
                                  opacity: const AlwaysStoppedAnimation(0.2),
                                ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: width(45)),
                            Center(
                              child: IconButton(
                                onPressed: () async {
                                  try {
                                    final pickedFile = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (pickedFile != null) {
                                      setState(() {
                                        imagePath = pickedFile.path;
                                      });
                                    }
                                  } on PlatformException catch (e) {
                                    print('Failed to pick image: $e');
                                  }
                                },
                                icon: Image.asset(
                                  'assets/images/photo.png',
                                  width: width(45),
                                  height: width(45),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                try {
                                  final pickedFile = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  if (pickedFile != null) {
                                    setState(() {
                                      imagePath = pickedFile.path;
                                    });
                                  }
                                } on PlatformException catch (e) {
                                  print('Failed to pick image: $e');
                                }
                              },
                              child: Text(
                                'Upload Cover Photo',
                                style: TextStyle(
                                  color: const Color(0xFFBFBCA0),
                                  fontSize: width(12),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: width(15)),
              Form(
                key: _formKey,
                child: TextFormField(
                  style: const TextStyle(color: Color(0xFFF1EED0)),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Enter Group name',
                    hintStyle: TextStyle(
                      color: const Color(0xFFA09F8D),
                      fontSize: width(14),
                      fontWeight: FontWeight.normal,
                    ),
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Group name';
                    } else if (value.length < 3 || value.length > 60) {
                      return 'Group name must be 3 to 60 characters long';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _groupName = value!;
                  },
                ),
              ),
              SizedBox(height: width(30)),
              SizedBox(
                width: screenWidth,
                child: Text(
                  'invite Players',
                  style: TextStyle(
                    color: const Color(0xFFBFBCA0),
                    fontSize: width(14),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.transparent,
                height: width(35),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(width(9)),
                  child: Container(
                    width: 2000,
                    color: Color(0xff474D48),
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Image.asset('assets/images/searchIcon.png'),
                        SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, 0, width(10), width(5)),
                            child: TextField(
                              onChanged: (value) => filter(value),
                              style: const TextStyle(
                                color: Color(0xFFF1EED0),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                hintStyle: TextStyle(
                                  color: const Color(0xFFA09F8D),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w100,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: MediaQuery.of(context).size.height * 0.82,
                child: ListView.builder(
                  itemCount: found.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => togglePlayerSelection(index),
                    child: Column(
                      children: [
                        Stack(children: [
                          ListTile(
                            leading: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/profileIcon.png',
                                  width: 50,
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 9, 8, 9),
                                    child: Image.asset(
                                      'assets/images/avatar.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              found[index]['userName'],
                              style: TextStyle(
                                color: const Color(0xFFF1EED0),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(found[index]['name']),
                            subtitleTextStyle: TextStyle(
                              color: const Color(0xFFA09F8D),
                            ),
                          ),
                          if (selectedPlayers.contains(found[index]))
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff599068).withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                        ]),
                        SizedBox(height: 3),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
