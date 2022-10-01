import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reorderable_list/data_model.dart';


class ReorderList extends StatefulWidget {
  const ReorderList({Key? key}) : super(key: key);

  @override
  _ReorderListState createState() => _ReorderListState();
}

class _ReorderListState extends State<ReorderList> {
  List<DataModel> colorList =  [
    DataModel(name: "Dog", image: 'assets/images/dog.jpg'),
    DataModel(name: "Giraffe", image: 'assets/images/giraffe.jpg'),
    DataModel(name: "Koala", image: 'assets/images/koala.jpg'),
    DataModel(name: "Panda", image: 'assets/images/panda.jpg'),
  ];

  // List.generate(100, (index) => "Product ${index.toString()}");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final appbar =  AppBar(
      title: Row(
        children: [
          SizedBox(
            width: screenWidth * 0.042,
            height: screenHeight * 0.042,
            child: SvgPicture.asset("assets/images/insta.svg",
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: screenWidth * 0.02,
          ),
          const Text("basic_flutter",style: TextStyle(color: Colors.grey,),),
        ],
      ),
      centerTitle: true,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: WillPopScope(
        onWillPop: ()async{

          return Future(() => false);
        },
        child: Scaffold(
            appBar: appbar,
            resizeToAvoidBottomInset: true,
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              child: SizedBox(
                width: screenWidth,
                height: screenHeight,

                child: ReorderableListView.builder(
                    itemCount: colorList.length,
                    itemBuilder: (context, index) {
                      return itemList(index);
                    },
                    // The reorder function
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) {
                          newIndex = newIndex - 1;
                        }
                        final element = colorList.removeAt(oldIndex);
                        colorList.insert(newIndex, element);
                        // context.read<CubitClass>().reorderColors(colorList);
                      });
                    }),

              ),
            )
        ),
      ),
    );
  }


  Widget itemList(int index){
    return InkWell(
      key: ValueKey(colorList[index]),
      onTap: (){
        for(int i=0 ; i<colorList.length ; i++){
          print(colorList[i].name);
        }

      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),

        decoration: BoxDecoration(
            color: Colors.grey[800],
            boxShadow: [

              BoxShadow(
                color: Colors.grey[900]! ,
                spreadRadius: 1,
                blurRadius: 3,
                offset:Offset(0, 2), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        width: double.infinity,
        height: 100,
        child: Row(

          children: [
            const SizedBox(
              width: 20,
            ),
            CircleAvatar(
              radius: 40, // Image radius
              backgroundImage: AssetImage(colorList[index].image),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(colorList[index].name,style: const TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 16),)


          ],
        )

      ),
    );
  }
}

