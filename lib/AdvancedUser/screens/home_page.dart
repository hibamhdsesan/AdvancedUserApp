import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:testme/AdvancedUser/controllers/my_service_controller.dart';
import 'package:testme/Advanceduser_session_view.dart';
import 'package:testme/controllers/ServiceController.dart';
import '../../NewSub.dart';
import '../../controllers/FavoriteCategory.dart';
import '../../search.dart';


class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {

  final TextEditingController _searchController = TextEditingController();
  final FavoriteController _categoryController = Get.put(FavoriteController());
  final ServiceController serviceController = Get.put(ServiceController());
  final MyServiceController _myServiceController=Get.put(MyServiceController());


  final List<Color> colors = [
    Color(0xFF9C66F3),
    Color(0xFF33A7E7),
    Color(0xFFFF8932),
    Color(0xFFEF5173),
    Color(0xFFDBC6FC),
    Color(0xFF77B8A1),
    Color(0xFFFF8932),
    Color(0xFF33A7E7),
    Color(0xFF9C66F3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'ITE',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontFamily: 'Inter',
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: SvgPicture.asset('assets/icon/more.svg'),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset('assets/icon/notification.svg'),
              onPressed: () {},
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF292D3D),
      body: SingleChildScrollView(
        child: Column(
          children: [
        Center(
        child: Container(
        width: 400,
          height: 120,
          child: Stack(
            children: [
              Positioned(
                width: 350,
                height: 52,
                left: 24,
                top: 24,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Color(0xFF9DA7AE),
                  ),
                  child: TextField(

                    controller: _searchController,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 50),
                    ),
                    onSubmitted: (query) {
                      Get.to(() => SearchResultsPage(query: query));
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Positioned(
                left: 40,
                top: 36,
                child: SvgPicture.asset('assets/icon/search.svg'),
              ),
            ],
          ),
        ),
      ),

            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 20,right: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Expanded(
                    child: Divider(
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                  SizedBox(width: 8), // المسافة بين الخطوط والنص
                  Text(
                    'My Services',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Inter',
                      // height: 1.5,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Divider(
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              if (_myServiceController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              return Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _myServiceController.myservices.length,
                    itemBuilder: (context, index) {
                      var myservice = _myServiceController.myservices[index];
                      bool hasChildren = myservice.children != null && myservice.children.isNotEmpty;

                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: InkWell(
                            onTap: () {
                              // لا يوجد حاجة لشيء هنا عند النقر على البطاقة الخارجية
                            },
                            child: Card(
                              color: Color(0xFFFEE2D7),
                              child: Container(
                                width: 250,
                                child: hasChildren
                                    ? ExpansionTile(
                                  title: Text(myservice.serviceName),
                                  subtitle: Text(myservice.serviceDescription),
                                  children: myservice.children.map((child) {
                                    return ListTile(
                                      title: Text(child.serviceName),
                                      subtitle: Text(child.serviceDescription),
                                      onTap: () {
                                        int childId = child.id;
                                        print(childId);
                                        _myServiceController.fetch_general_Sessions(childId);
                                        Get.to(() => Advanced_session_view(), arguments: childId);
                                      },
                                    );
                                  }).toList(),
                                )
                                    : ListTile(
                                  title: Text(myservice.serviceName),
                                  subtitle: Text(myservice.serviceDescription),
                                  onTap: () {
                                    int serviceId = myservice.id;
                                    _myServiceController.fetch_general_Sessions(serviceId);
                                    Get.to(() => Advanced_session_view(), arguments: serviceId);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),






            Stack(
              children: [
                Center(
                  child: Container(
                    width:  MediaQuery.of(context).size.width,
                    height: 449,
                    margin: const EdgeInsets.only(left: 2, top: 100),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Obx(
                            () => _categoryController.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: _categoryController.categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            final category = _categoryController.categories[index];
                            Color color = colors[index % colors.length];
                            return GestureDetector(
                              onTap: () {
                                _categoryController.fetchSubjects(category.id);
                                Get.to(() => SubjectPage());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: color,
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        category.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '${category.serviceYear}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
