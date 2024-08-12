/*import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'controllers/NewannouncementController.dart';

class AnnouncementPage extends StatefulWidget {
  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  final AnnouncementController announcementController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Obx(() {
              if (announcementController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: announcementController.announcements.length,
                      itemBuilder: (context, index) {
                        var announcement = announcementController.announcements[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                          child: Container(
                            width: 100,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              color: Color(0xFFDBC6FC),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        announcement.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(announcement.description),
                                      SizedBox(height: 10),
                                      Text("Service ID: ${announcement.serviceID}"),
                                      Text("User ID: ${announcement.userID}"),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Obx(() => IconButton(
                                      icon: SvgPicture.asset(announcement.isSaved.value ? 'assets/icon/save.svg' : 'assets/icon/unsave.svg'),
                                      onPressed: () {
                                        if (announcement.isSaved.value) {
                                          announcementController.unsaveAnnouncement(announcement.id);
                                        } else {
                                          announcementController.saveAnnouncement(announcement.id);
                                        }
                                      },
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
*/

//واجهة زي العسل
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'controllers/NewannouncementController.dart';



class AnnouncementPage extends StatefulWidget {
  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  final AnnouncementController announcementController = Get.put(AnnouncementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Obx(() {
              if (announcementController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() =>
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: announcementController.announcements
                              .length,
                          itemBuilder: (context, index) {
                            var announcement = announcementController
                                .announcements[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 30, left: 30),
                              child: Container(
                                width: 100,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28),
                                  color: Color(0xFFDBC6FC),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            announcement.title,
                                            style: TextStyle(fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10),
                                          Text(announcement.description),
                                          SizedBox(height: 10),
                                          Text("Service ID: ${announcement
                                              .serviceID}"),
                                          Text("User ID: ${announcement
                                              .userID}"),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          icon: SvgPicture.asset(
                                              announcement.isSaved
                                                  ? 'assets/icon/save.svg'
                                                  : 'assets/icon/unsave.svg'),
                                          onPressed: () {
                                            announcementController
                                                .toggleSaveAnnouncement(index);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                  ],
                ),
              );
            }),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: () => _showAddAnnouncementDialog(context),
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showAddAnnouncementDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController serviceIDController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Announcement'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: serviceIDController,
                decoration: InputDecoration(labelText: 'Service ID'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                announcementController.addAnnouncement(
                  titleController.text,
                  descriptionController.text,
                  int.parse(serviceIDController.text),
                );
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}




