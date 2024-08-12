import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'addsession.dart';
import 'controllers/ServiceController.dart';
import 'edit_session.dart';

class Advanced_related_session_view extends StatelessWidget {
  final ServiceController serviceController = Get.put(ServiceController());
  final List<String> colors = [
    '#FF8B3A',
    '#BFB9FD',
    '#77B8A1',
  ];

  @override
  Widget build(BuildContext context) {
    final int? passedServiceId = Get.arguments; // Get the passed service ID

    return Scaffold(
      body: Obx(() {
        if (serviceController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (serviceController.sessions.isEmpty) {
          return Center(child: Text('No Sessions Found'));
        } else {
          // إذا كانت قيمة passedServiceId null، اعتمد أول service ID كـ id افتراضي
          final int serviceId = passedServiceId ?? serviceController.sessions.first.id;

          return Stack(
            children: [
              ListView.builder(
                itemCount: serviceController.sessions.length,
                itemBuilder: (context, index) {
                  var session = serviceController.sessions[index];
                  Color containerColor = Color(int.parse(colors[index % 3].substring(1, 7), radix: 16) + 0xFF000000);
                  Color intersectColor = containerColor.withOpacity(0.7);
                  Color lighterColor = intersectColor.withOpacity(0.8);

                  return Padding(
                    padding: const EdgeInsets.only(left: 35, top: 15),
                    child: Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Container(
                          width: 330,
                          height: 215,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: lighterColor,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Icon(
                            Icons.circle,
                            size: 100,
                            color: intersectColor,
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 30, top: 15),
                                  child: Text(
                                    session.id.toString(),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text(
                                    session.status,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 50),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        session.sessionName,
                                        textAlign: TextAlign.left,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                        ),
                                      ),
                                      SizedBox(width: 5), // Add space between text and icon
                                      Icon(
                                        Icons.qr_code,
                                        size: 24,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    session.sessionDescription,
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10, top: 140),
                              child: const Text(
                                'Date',
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, top: 140),
                              child: Text(
                                session.sessionDate,
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10, top: 160),
                                  child: const Text(
                                    'Start',
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10, bottom: 20),
                                  child: Text(
                                    session.sessionStartTime,
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 160),
                                  child: const Text(
                                    'End',
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    session.sessionEndTime,
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (session.status == 'created' || session.status == 'closed') {
                                  serviceController.startSession(session.id);
                                } else if (session.status == 'active') {
                                  serviceController.closeSession(session.id);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 210, top: 160),
                                child: Icon(
                                  session.status == 'created' || session.status == 'closed'
                                      ? Icons.play_arrow
                                      : Icons.close,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                      () => EditSessionView(
                                    sessionId: session.id,
                                    initialSessionName: session.sessionName,
                                    initialSessionDescription: session.sessionDescription,
                                    initialSessionDate: session.sessionDate,
                                    initialSessionStartTime: session.sessionStartTime,
                                    initialSessionEndTime: session.sessionEndTime,
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10, top: 160),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                serviceController.deleteSession(session.id, serviceId);
                                serviceController.fetchSessions(serviceId);
                                print(serviceId);
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 160),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 30,
                right: 30,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.to(() => AddSessionView(), arguments: serviceId);
                  },
                  backgroundColor: Color(0xFF292D3D),
                  child: Icon(Icons.add),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
