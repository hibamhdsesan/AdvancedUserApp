import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddInterviewSessionDoc extends StatefulWidget {
  @override
  State<AddInterviewSessionDoc> createState() => _AddInterviewSessionDocState();
}

class _AddInterviewSessionDocState extends State<AddInterviewSessionDoc> {
  double _expandedHeight = 0.0;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    _expandedHeight = MediaQuery.of(context).size.height / 4;
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          _expandedHeight = constraints.maxHeight / 4;
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                expandedHeight: _expandedHeight,
                pinned: true,
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                      color:Color(0xff292D3D) ,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 0;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'Activity',
                                    style: TextStyle(
                                      color: _selectedIndex == 0 ? Colors.blue : Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Container(
                                    height: 3,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: _selectedIndex == 0 ? Colors.blue : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),

                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 1;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'Interview',
                                    style: TextStyle(
                                      color: _selectedIndex == 1 ? Colors.blue : Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(

                                      height: 3,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        color: _selectedIndex == 1 ? Colors.blue : Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),

                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 2;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'Exam',
                                    style: TextStyle(
                                      color: _selectedIndex == 2 ? Colors.blue : Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: _selectedIndex == 2 ? Colors.blue : Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    height: 3,
                                    width: 90,

                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                      ],
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 10),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Image(
                    image: AssetImage('assets/images/3D young man in headphone sitting with laptop.png'),
                  ),
                ),
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 350.0,
                        decoration: BoxDecoration(
                          color: index.isEven ? Color(0xFFA5EAD1) : Color(0xffDEC5FF),
                          borderRadius: BorderRadius.circular(23.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, top: 15),
                              child: Row(
                                children: [
                                  const Text(
                                    'Title',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF292D3D),
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                  SvgPicture.asset(
                                    'assets/icon/edit.svg',
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                      'assets/icon/delete.svg',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                'ghjkkjhgfdsdfghjklkjhgfdfghjklkjhgfdfghjklkjhgfdsdfghjukgfdsdfghjkjhgfdsdftgyuj',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF292D3D),
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Date',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF292D3D),
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      Text(
                                        '09:30 AM',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF292D3D),
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 30),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Start',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF292D3D),
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      Text(
                                        '09:30 AM',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF292D3D),
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'End',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF292D3D),
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      Text(
                                        '09:30 AM',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF292D3D),
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,)
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: 5,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddInterviewSessionDoc extends StatefulWidget {
  @override
  State<AddInterviewSessionDoc> createState() => _AddInterviewSessionDocState();
}

class _AddInterviewSessionDocState extends State<AddInterviewSessionDoc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
                color: Color(0xff292D3D),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Image(
                image: AssetImage('assets/images/3D young man in headphone sitting with laptop.png'),
              ),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5, // عدد العناصر في القائمة

              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(

                      width: 350.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF92D8BF),
                        borderRadius: BorderRadius.circular(23.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, top: 15),
                            child: Row(
                              children: [
                                Text(
                                  'Title',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF292D3D),
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                                SvgPicture.asset(
                                  'assets/icon/edit.svg',
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SvgPicture.asset(
                                    'assets/icon/delete.svg',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF292D3D),
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Date',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF292D3D),
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    Text(
                                      '09:30 AM',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF292D3D),
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 30),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Start',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF292D3D),
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    Text(
                                      '09:30 AM',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF292D3D),
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'End',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF292D3D),
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    Text(
                                      '09:30 AM',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF292D3D),
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,)
                        ],
                      ),
                    ),
                  ),
                );
              },

            ),
           /* Center(
              child: Container(

                width: 350.0,
                decoration: BoxDecoration(
                  color: Color(0xFF92D8BF),
                  borderRadius: BorderRadius.circular(23.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 15),
                      child: Row(
                        children: [
                          Text(
                            'Title',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF292D3D),
                              fontFamily: 'Inter',
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          SvgPicture.asset(
                            'assets/icon/edit.svg',
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              'assets/icon/delete.svg',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF292D3D),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF292D3D),
                                  fontFamily: 'Inter',
                                ),
                              ),
                              Text(
                                '09:30 AM',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF292D3D),
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Start',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF292D3D),
                                  fontFamily: 'Inter',
                                ),
                              ),
                              Text(
                                '09:30 AM',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF292D3D),
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'End',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF292D3D),
                                  fontFamily: 'Inter',
                                ),
                              ),
                              Text(
                                '09:30 AM',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF292D3D),
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}


 */