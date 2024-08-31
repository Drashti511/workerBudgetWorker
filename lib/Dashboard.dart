import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:worker_budget_worker/Bookings.dart';
import 'package:worker_budget_worker/UserAcc.dart';
import 'ApplyWork.dart';
import 'Approval.dart';
import 'Home_Page.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int index = 0;
  final _screens = [
    const Home_Page(),
    const Bookings(),
    const Approval(),
    const UserAcc(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[index],
      backgroundColor : HexColor('#ffe6e6'),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const ApplyWork())); },
        backgroundColor: HexColor('#0B4360'),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: HexColor('#76c7ef'),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14 , fontWeight: FontWeight.w500 , color: Colors.white),
          ),
        ),
          child: NavigationBar(
            height: 60,
            backgroundColor: HexColor('#0B4360'),
            selectedIndex: index,
            onDestinationSelected: (index) => setState(() {
              this.index = index;
            }),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined, color: Colors.white,),
                label: "Home",
              ),
              NavigationDestination(
                icon: Icon(Icons.work_outline_rounded, color: Colors.white,),
                label: "Work" ,
              ),
              NavigationDestination(
                icon: Icon(Icons.approval_sharp, color: Colors.white,),
                label: "Applications" ,
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline, color: Colors.white,),
                label: "Account" ,
              ),
            ],
          ),
        ),
      );
    }
}

