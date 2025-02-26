
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/view/userlist.dart';
import '../model/user_model.dart';
import '../service/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<User>> futureUsers;
  List<User> filteredUsers = [];
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    futureUsers = ApiService.fetchUsers();
    futureUsers.then((users) {
      setState(() {
        filteredUsers = users;
      });
    });
  }

  Future<void> _refresh() async {
    await _fetchUsers();
  }

  void _filterUsers(String query) {
    setState(() {
      isSearching = query.isNotEmpty;
      futureUsers.then((users) {
        filteredUsers = users
            .where((user) =>
        user.name.toLowerCase().contains(query.toLowerCase()) ||
            user.email.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F7FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "All Users",
          style: GoogleFonts.lato(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: _filterUsers,
                style: GoogleFonts.lato(color: Colors.black87),
                decoration: InputDecoration(
                  hintText: "Search users...",
                  hintStyle: GoogleFonts.lato(color: Colors.grey[600]),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  prefixIcon: Icon(Icons.search, color: Colors.blueAccent.shade700),
                  suffixIcon: isSearching
                      ? IconButton(
                    icon: Icon(Icons.clear, color: Colors.grey.shade700),
                    onPressed: () {
                      searchController.clear();
                      _filterUsers('');
                    },
                  )
                      : null,
                ),
              ),
            ),
          ),
          // User List
          Expanded(
            child: FutureBuilder<List<User>>(
              future: futureUsers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.blueAccent.shade700),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Failed to load users",
                      style: GoogleFonts.lato
                        (
                        fontSize: 16,
                        color: Colors.redAccent,
                      ),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "No users found",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: _refresh,
                    color: Colors.blueAccent.shade700,
                    backgroundColor: Colors.white,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        return UserCard(user: filteredUsers[index]);
                      },
                      
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
