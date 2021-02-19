import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rbazaar/App/productlist/ProductListPage.dart';
import 'file:///D:/Neeraj/git%20project/rbazaar/lib/App/productdetails/ProductListDetailsPage.dart';
import 'package:rbazaar/Global/GlobalConstants.dart';
import 'package:rbazaar/utils/mycolors.dart';
import 'SubCategoryBloc.dart';
import 'SubCategoryModel.dart';

class SubCategoryPage extends StatefulWidget {
  int catId;
  String catImagePath;
  var catName;
  SubCategoryPage({this.catName,this.catId, this.catImagePath});

  @override
  SubCategoryPageState createState() => SubCategoryPageState();
}

class SubCategoryPageState extends State<SubCategoryPage> {
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
        body: Container(
            height: Get.height,
            width: Get.width,
            color: Colors.white,
            child: Stack(
              children: [
                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
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
                          image: NetworkImage(
                              widget.catImagePath??
                                  ""),
                          placeholder: AssetImage(
                              'assets/images/placeholder.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      StreamBuilder<SubCategoryModel>(
                        stream: bloc.homeServiceSubject.stream,
                        builder: (context, AsyncSnapshot<SubCategoryModel> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.error == null &&snapshot.data.status == false) {
                              return _buildErrorWidget(snapshot.data.message);
                            } else if (snapshot.error == null && snapshot.data.isNull) {
                              return _buildErrorWidget("No Data Found");
                            } else if (snapshot.error != null || snapshot.data.isNull) {
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
                    ],)
                   ),
              ],
            )));
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
    return  Positioned(
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



  Widget _subcategory(SubCategoryModel data) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Shop by Category',
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
          Container(child:  GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data?.subCategories.length,
              gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return new InkWell(
                  child:  Container(
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
                          Expanded(flex: 3,child:  ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            ),
                            child: FadeInImage(
                              height: 150,
                              image: NetworkImage("https://kredivation.com/kawach/chiken2.jpg"??""),
                              placeholder: AssetImage(
                                  'assets/images/placeholder.png'),
                              fit: BoxFit.fill,
                            ),
                          ),),
                      Expanded(flex:1,child: Container(
                        margin: const EdgeInsets.only(
                            bottom: 3, top: 10.0, left: 3, right: 3),
                        child: Text(
                          data?.subCategories[index]?.subCategory,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),)

                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.to(ProductListPage(subcatName:data?.subCategories[index]?.subCategory,catId:widget.catId,catImagePath:widget.catImagePath,subCatTitle:data?.subCategories[index]?.subCategory));
                  },
                );
              }))

        ],
      ),
    );
  }
}
