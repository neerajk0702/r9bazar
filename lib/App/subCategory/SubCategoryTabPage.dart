import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rbazaar/App/productlist/ProductListPage.dart';
import 'package:rbazaar/App/productlist/ProductModel.dart';
import 'CustomTabView.dart';
import 'file:///D:/Neeraj/git%20project/rbazaar/lib/App/productdetails/ProductListDetailsPage.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/mycolors.dart';
import 'SubCategoryBloc.dart';
import 'SubCategoryModel.dart';

class SubCategoryTabPage extends StatefulWidget {
  int catId;
  String catImagePath;
  var catName;
  int initPosition = 0;

  SubCategoryTabPage({this.catName, this.catId, this.catImagePath});

  @override
  SubCategoryTabPageState createState() => SubCategoryTabPageState();
}

class SubCategoryTabPageState extends State<SubCategoryTabPage> {
  SubCategoryBloc bloc = SubCategoryBloc();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.getSubcategoryListData(widget.catId);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: _scaffoldkey,
        appBar:  AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title:  Text(
            widget.catName,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          // centerTitle: true,
        ),
        body: Container(
            height: Get.height,
            width: Get.width,
            color: Colors.white,
            child: StreamBuilder<SubCategoryModel>(
              stream: bloc.homeServiceSubject.stream,
              builder: (context,
                  AsyncSnapshot<SubCategoryModel> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.error == null &&
                      snapshot.data.status == false) {
                    return _buildErrorWidget(snapshot.data.message);
                  } else if (snapshot.error == null &&
                      snapshot.data.isNull) {
                    return _buildErrorWidget("No Data Found");
                  } else if (snapshot.error != null ||
                      snapshot.data.isNull) {
                    return _buildErrorWidget(snapshot.error);
                  }
                  return _subcategory(snapshot.data);
                } else if (snapshot.hasError) {
                  return _buildErrorWidget(snapshot.error);
                } else {
                  return _buildLoadingWidget();
                }
              },
            )

            /*Stack(
              children: [
                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        _topBar(),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          ),
                          child: FadeInImage(
                            height: 230,
                            width: Get.width,
                            image: NetworkImage(widget.catImagePath ?? ""),
                            placeholder:
                                AssetImage('assets/images/placeholder.png'),
                            fit: BoxFit.fill,
                          ),
                        ),

                      ],
                    )),
              ],
            ))*/
        )

    );
  }

  Widget loadingIndicator(SubCategoryBloc bloc) => StreamBuilder<bool>(
        stream: bloc.isLoading,
        builder: (context, snap) {
          return Container(
            child: (snap.hasData && snap.data)
                ? CircularProgressIndicator()
                : null,
          );
        },
      );

  Widget _buildLoadingWidget() {
    return Positioned(
        child: Center(
      child: loadingIndicator(bloc),
    ));
  }

  Widget _buildErrorWidget(String message) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
      ],
    ));
  }

  _topBar() {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 0),
      color: MyColors.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  widget.catName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

//productbuild(data?.subCategories[index])
  Widget _subcategory(SubCategoryModel data) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      child: CustomTabView(
        initPosition: widget.initPosition,
        itemCount: data?.subCategories?.length,
        tabBuilder: (context, index) =>
            Tab(child:
            Container(child: Text(
              data?.subCategories[index]?.subCategory,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),)
            ), ),
        pageBuilder: (context, index) =>
            Center(child: productbuild(data?.subCategories[index])),
        onPositionChange: (index) {
          print('current position: $index');
          widget.initPosition = index;
        },
        onScroll: (position) => print('$position'),
      ),
    );
  }

//REFRENCE https://stackoverflow.com/questions/50036546/how-to-create-a-dynamic-tabbarview-render-a-new-tab-with-a-function-in-flutter
  Widget productbuild(SubCategories subCategories) {
    return FutureBuilder(
      future: bloc.getProductListData(subCategories.subCategory, widget.catId),
      builder: (context, AsyncSnapshot<ProductModel> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.error == null && snapshot.data.status == false) {
            return _buildErrorWidget(snapshot.data.message);
          } else if (snapshot.error == null && snapshot.data.isNull) {
            return _buildErrorWidget("No Data Found");
          } else if (snapshot.error != null || snapshot.data.isNull) {
            return _buildErrorWidget(snapshot.error);
          }
          return _productList(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _productList(ProductModel data) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 0, left: 0, right: 0),
      child: SingleChildScrollView(scrollDirection: Axis.vertical,
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Divider(height: 10,color: Colors.black45,),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Shop by Products',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data?.products?.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return new InkWell(
                      child: Container(
                        width: Get.width / 2,
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            top: 3, bottom: 3, left: 2, right: 2),
                        child: Card(
                          color: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                  ),
                                  child: FadeInImage(
                                    height: 150,
                                    image: NetworkImage(Constants.imageUrl +
                                        data?.products[index]?.folderName +
                                        data?.products[index]?.fileName ??
                                        ""),
                                    placeholder: AssetImage(
                                        'assets/images/placeholder.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, top: 7.0, left: 3, right: 3),
                                  child: Text(
                                    data?.products[index]?.productName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.to(ProductListDetailsPage(productName:data?.products[index]?.productName,catId:widget.catId,
                            imagePath:Constants.imageUrl +  data?.products[index]?.folderName +  data?.products[index]?.fileName ?? "",
                            productTitle:data?.products[index]?.productName,productsno:data?.products[index]?.dsno));
                      },
                    );
                  }))
        ],
      ),)


    );
  }



/*Widget _subcategory3(SubCategoryModel data) {
    return new MaterialApp(
        home: DefaultTabController(
            length: data?.subCategories?.length,
            child: new Scaffold(
                appBar: new AppBar(
                  title: new Text("Title"),
                  bottom: new TabBar(
                    isScrollable: true,
                    tabs: List<Widget>.generate(data?.subCategories?.length, (int index){
                      print(data?.subCategories[0].subCategory);
                      return new Tab(icon: Icon(Icons.directions_car), text: "some random text");

                    }),
                  ),
                ),
                body: new TabBarView(
                  children: List<Widget>.generate(data?.subCategories?.length, (int index){
                    return productbuild(data?.subCategories[index]);

                  }),
                )
            ))
    );
  }*/
}
