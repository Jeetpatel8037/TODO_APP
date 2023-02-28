import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Controller/HomeController.dart';
import '../Helperes/db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  int initialIndex = 0;

  late TabController tabController;
  PageController pageController = PageController();

  TextEditingController task = TextEditingController();
  TextEditingController category = TextEditingController();
  HomeController homeController = Get.put(HomeController());

  getData () async {
    DBHelper dbHelper = DBHelper();
    homeController.dataList.value = await dbHelper.readData();
  }


  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today, Feb 28"),
        actions: [
          IconButton(onPressed: () {
            AlertDialog(
              content: Column(
                // children: [
                //   TextField(),
                // ],
              ),
            );
          }, icon: Icon(Icons.add))
        ],
      ),
      body: Obx(
            () => ListView.builder(itemCount: homeController.dataList.length,itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              title: Text("${homeController.dataList[i]['task']}"),
              subtitle: Text("${homeController.dataList[i]['category']}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: (){
                    DBHelper.dbHalper.deleteData(id: i-1);
                    getData();
                  }, icon: Icon(Icons.delete,color: Colors.red,))
                ],
              ),


            ),
          );
        } ),
        // body: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const Padding(
        //         padding: EdgeInsets.all(8.0),
        //         child: Text("TODO(3)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
        //       ),
        //       const Padding(
        //         padding: EdgeInsets.all(8.0),
        //         child: Text("Your Task ",style: TextStyle(fontSize: 15)),
        //       ),
        //       Text("Category",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
        //       const Divider(),
        //       SizedBox(height: 10),
        //       const Padding(
        //         padding: EdgeInsets.all(8.0),
        //         child: Text("Done(2)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
        //       ),
        //       const Padding(
        //         padding: EdgeInsets.all(8.0),
        //         child: Text("Your Task",style: TextStyle(fontSize: 15)),
        //       ),
        //       const Text("Category",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
        //       Spacer(),
        //       TabBar(
        //           indicatorSize: TabBarIndicatorSize.tab,
        //           controller: tabController,
        //           indicatorColor: Colors.teal,
        //           indicatorWeight: 5,
        //           onTap: (val){},
        //           tabs: [
        //             Tab(icon: Icon(Icons.home,color: Colors.teal,),
        //             ),
        //             Tab(icon: Icon(Icons.calendar_month,color: Colors.teal,),)
        //           ]),
        //       // TabBarView(
        //       //     controller: tabController,
        //       //     children: [
        //       //       HomePage(),
        //       //     //  CalenderPage(),
        //       //     ])
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Insert Yout Task"),
              content: Column(
                children: [
                  TextField(controller: task,decoration: const InputDecoration(border: OutlineInputBorder(),hintText: ("Task")),),
                  const SizedBox(height: 15),
                  TextField(controller: category,decoration: const InputDecoration(border: OutlineInputBorder(),hintText: ("Category")),),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      ElevatedButton(onPressed: () async {
                        DBHelper dbHelper = DBHelper();
                        dbHelper.insertData(task: task.text, category: category.text,);
                        homeController.dataList.value = await dbHelper.readData();
                      }, child: const Text("Insert")),
                      SizedBox(width: 5),
                      ElevatedButton(onPressed: ()  {
                        Navigator.of(context).pop();
                      }, child: const Text("cancel")),
                    ],
                  ),

                ],
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),

    );
  }
}
