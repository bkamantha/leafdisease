import 'package:flutter/material.dart';
import 'package:leaf_disease_identification_app/Models/results_class.dart';
import 'package:leaf_disease_identification_app/Pages/navbar.dart';
import 'package:leaf_disease_identification_app/api_constant.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../widgets/expandable_text.dart';

class ResultPage extends StatefulWidget {
  final Result result;
  //final bool routing;
  const ResultPage({
    super.key,
    required this.result,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> with TickerProviderStateMixin {
  //Result? result;

  @override
  Widget build(BuildContext context) {
    final TabController tabController = TabController(length: 2, vsync: this);
    List<int> imageListI = widget.result.diseaseImages.i;
    List<int> imageListA = widget.result.diseaseImages.a;
    debugPrint(imageListA.toString());
    debugPrint(imageListI.toString());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      home: Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text(
            "Result",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          // if ther error coccoured wrp following widget with coloumn
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.result.diseaseName!
                            .replaceAll(RegExp('[\\W_]+'), ' '),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 400.0,
                      child: FutureBuilder(
                        future: Future.delayed(const Duration(seconds: 3)),
                        builder: (c, s) =>
                            s.connectionState == ConnectionState.done
                                ? Image.network(
                                    "${ApiConstants.bASEURL}images/D/${widget.result.diseaseImages.d.first}",
                                    fit: BoxFit.fill,
                                  )
                                : const Center(
                                    child: SizedBox(
                                      width: 80.0,
                                      height: 80.0,
                                      child: CircularProgressIndicator(
                                        color: Colors.black26,
                                      ),
                                    ),
                                  ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TabBar(
                    controller: tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    labelPadding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    indicator: DotIndicator(
                      color: Colors.black,
                      distanceFromCenter: 16,
                      radius: 3,
                      paintingStyle: PaintingStyle.fill,
                    ),
                    tabs: const [
                      Tab(
                        child: Text(
                          "Identifiied Images",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Infected Area",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                  ),
                  width: double.maxFinite,
                  height: 300,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      ListView.builder(
                        itemCount: imageListI.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox(
                                  width: 200.0,
                                  height: 300.0,
                                  child: Image.network(
                                    "${ApiConstants.bASEURL}images/I/${imageListI[index]}",
                                    fit: BoxFit.fill,
                                  )),
                            ),
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: imageListA.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox(
                                width: 200.0,
                                height: 300.0,
                                child: FutureBuilder(
                                  future: Future.delayed(
                                      const Duration(seconds: 3)),
                                  builder: (c, s) => s.connectionState ==
                                          ConnectionState.done
                                      ? Image.network(
                                          "${ApiConstants.bASEURL}images/A/${imageListA[index]}",
                                          fit: BoxFit.fill,
                                        )
                                      : const Center(
                                          child: SizedBox(
                                            width: 80.0,
                                            height: 80.0,
                                            child: CircularProgressIndicator(
                                              color: Colors.black26,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Container(
                    width: double.maxFinite,
                    height: 250.0,
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(20)),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ExpandedWidget(
                              textTitle: "Disease Infomations",
                              text: widget.result.diseaseInformations,
                            ),
                            ExpandedWidget(
                              textTitle: "Prevention Method",
                              text: widget.result.preventionMethod,
                            ),
                            ExpandedWidget(
                              textTitle: "Result Info",
                              text: widget.result.resultInfo,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
