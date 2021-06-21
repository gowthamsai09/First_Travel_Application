import 'package:flutter/material.dart';
import '';

class mydrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: <Widget> [
          UserAccountsDrawerHeader(
              accountName: Text("Gowtham sai"),
              accountEmail: Text("gowthamsai123@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://images.unsplash.com/photo-1564564321837-a57b7070ac4f?ixid=MXwxMjA3fDB8MHxzZWFyY2h8OHx8Z3V5fGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
              )
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Gowtham Sai"),
            subtitle: Text("Student"),
            trailing: Icon(Icons.edit),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("Email"),
            subtitle: Text("gowthamsai123@gmail.com"),
            trailing: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}