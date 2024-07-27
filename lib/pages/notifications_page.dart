import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List notifications = [];
  bool isLoading = true;
  bool isLoadingMore = false;
  int page = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchNotifications();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        fetchMoreNotifications();
      }
    });
  }

  Future<void> fetchNotifications() async {
    final response =
        await http.get(Uri.parse('http://34.69.190.172/api/notifications/'));
    if (response.statusCode == 200) {
      setState(() {
        notifications = json.decode(response.body);
        isLoading = false;
      });
    } else {
      // Handle server error
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchMoreNotifications() async {
    setState(() {
      isLoadingMore = true;
    });
    page++;
    final response =
        await http.get(Uri.parse('http://34.69.190.172/api/notifications/'));
    if (response.statusCode == 200) {
      setState(() {
        notifications.addAll(json.decode(response.body));
        isLoadingMore = false;
      });
    } else {
      // Handle server error
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Notifications",
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return ListTile(
                        title: Text(
                          notification['title'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(notification['summary']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationDetailPage(
                                  notification: notification),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                if (isLoadingMore)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
    );
  }
}

class NotificationDetailPage extends StatelessWidget {
  final Map notification;

  const NotificationDetailPage({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(notification['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification['content'],
                style: const TextStyle(fontSize: 16.0)),
            const SizedBox(height: 20.0),
            Text('Source:',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () {
                // Handle link tap
              },
              child: Text(
                notification['source'],
                style: const TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
