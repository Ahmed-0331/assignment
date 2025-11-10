import 'package:flutter/material.dart';

void main() {
  runApp(ContactListApp());
}

class ContactListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactListScreen(),
    );
  }
}

class ContactListScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  final List<Map<String, String>> contacts = [
    {'name': 'Jawad', 'number': '01877-777777'},
    {'name': 'Ferdous', 'number': '01673-777777'},
    {'name': 'Hasan', 'number': '01745-777777'},
    {'name': 'Hasan', 'number': '01745-777777'},
    {'name': 'Hasan', 'number': '01745-777777'},
    {'name': 'Hasan', 'number': '01745-777777'},
    {'name': 'Hasan', 'number': '01745-777777'},
    {'name': 'Ahmed', 'number': '01745-777777'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact List',
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Name field
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Ahmed',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),

            // Number field
            TextFormField(
              controller: numberController,
              decoration: InputDecoration(
                hintText: '01745-787878',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            // Add button
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: Text('Add', style: TextStyle(fontSize: 18,color: Colors.white)),
              ),
            ),
            SizedBox(height: 15),

            // Contact lis
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Icon(Icons.person, color: Colors.brown),
                      title: Text(
                        contact['name']!,
                        style: TextStyle(
                          color: Colors.red[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(contact['number']!),
                      trailing: Icon(Icons.call, color: Colors.blue),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
