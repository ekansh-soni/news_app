import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/bloc/news_bloc.dart';
import 'package:news/model/news_model.dart' as news_model_bean ;
import 'package:news/ui/details_screen.dart';
import '../Utils/strings.dart';
import '../utils/common_style.dart';
import '../utils/route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController editingController = TextEditingController();
  LoadingDialog? pr;
  news_model_bean.NewsViewModel? newsViewModel;
  NewsModelBloc? newsModelBloc;

  List<String> itemData = List.empty(growable: true);
  List<String> listOfAnchor = List.empty(growable: true);


  @override
  void initState() {
    super.initState();
    pr = LoadingDialog(
        context: context,
        dismissable: AppConstants.progress_dismissiable,
        title: CustomTextWidget(
          "Loading",
          size_txt: 18.sp,
          color_txt: Colors.black,
          isbold: true,
        ),
        message: CustomTextWidget(
          "Please wait, we are processing your data",
          max_lines: 2,
          size_txt: 12.sp,
        ));
    initView();
  }

  initView(){
    newsModelBloc = BlocProvider.of<NewsModelBloc>(context);
    newsModelBloc!.add(FetchNewsModelsEvent());
  }

  void filterItem(String query){
    setState(() {
      listOfAnchor = itemData.where((element) => element.toLowerCase().contains(query.toLowerCase()),).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(listOfAnchor);
    return MultiBlocListener(
        listeners: [
          BlocListener<NewsModelBloc, NewsModelState>(
            listener: (context, state) async {
              if (state is NewsModelErrorState) {
                pr!.dismiss();
                debugPrint(state.message);
                Custom_Dialog(
                    mcontext: context,
                    message: state.message,
                    positive_btn_text: "OK")
                    .show();
              }
              else if (state is NewsModelCloseState) {
                pr!.dismiss();
                debugPrint(state.message);
                Custom_Dialog(
                    mcontext: context,
                    message: state.message,
                    positive_btn_text: "Proceed",
                    dismissable: false,
                    isClose: true,
                    onpress: () {
                      sendRoute(
                          context, RoutesName.splash,);
                    }).show();
              }
              else if (state is NewsModelInitialState) {
                pr!.show();
              }
              else if (state is NewsModelLoadingState) {
                pr!.show();
              }
              else if (state is NewsModelLoadedState) {
                pr!.dismiss();
                newsViewModel = state.NewsModels;
                for(var i = 0 ; i < newsViewModel!.articles!.length; i++){
                  itemData.add(newsViewModel!.articles![i].author.toString());
                }
                setState(() {});

              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: CustomTextWidget("Today's News",size_txt: 16.sp,color_txt: Colors.white,),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.bookmark_border,color: Colors.white,))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: newsViewModel != null ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.r)
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.w)
                  ),
                  controller: editingController,
                  onChanged: (value) {
                    filterItem(value);
                    print(value);
                  },
                ),
                spaceHeight(10.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: newsViewModel!.articles!.length,

                    itemBuilder: (context, index) {
                      var listData = newsViewModel!.articles![index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(8.r),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(flag: listData,),));
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomTextWidget("Author: ", size_txt: 12.sp, isbold: true,),
                                    Expanded(child: CustomTextWidget(listData.author, size_txt: 12.sp, isbold: true,))
                                  ],
                                ),
                                Row(
                                  children: [
                                    CustomTextWidget("Title: ", size_txt: 10.sp, color_txt: Colors.blueGrey,),
                                    Expanded(child: CustomTextWidget(listData.title, size_txt: 10.sp, color_txt: Colors.grey,))
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )

              ],
            ): Container(),
          ),
        ));
  }
}
