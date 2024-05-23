import 'package:flutter/material.dart';
import 'package:takwira_app/views/messages/chat1.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff343835),
      appBar: AppBar(
        backgroundColor: const Color(0xff343835),
        iconTheme: const IconThemeData(color: Color(0xFFF1EED0)),
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'New Message',
            style: TextStyle(
              color: Color(0xFFF1EED0),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 17),
                Text(
                  'To',
                  style: TextStyle(
                    color: const Color(0xFFA09F8D),
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    width: 2000,
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Expanded(
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: found.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Chat1(),
                      ),
                    );
                  },
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
    );
  }
}
