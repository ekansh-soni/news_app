import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/bloc/news_bloc.dart';
import 'package:news/model/news_model.dart';
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
  LoadingDialog? pr;
  NewsViewModel? newsViewModel;
  NewsModelBloc? newsModelBloc;

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

  @override
  Widget build(BuildContext context) {
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
                setState(() {});

              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: CustomTextWidget("Today's News",size_txt: 16.sp,),
            automaticallyImplyLeading: false,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              newsViewModel != null ? 
                  Expanded(
                    child: ListView.builder(
                      itemCount: newsViewModel!.articles!.length,
                      padding: EdgeInsets.all(8.w),
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
                              side: BorderSide(color: const Color(0xffD90429).withOpacity(0.4))
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
                  : Container(),
            ],
          ),
        ));
  }
}
