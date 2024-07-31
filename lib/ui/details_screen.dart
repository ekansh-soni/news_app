import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/model/news_model.dart' as news_model;
import 'package:news/utils/common_style.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  final news_model.Articles? flag;
  const DetailsScreen({super.key, this.flag});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var userData = widget.flag;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextWidget("Source: ", size_txt: 14.sp, isbold: true,),
            CustomTextWidget(userData!.source!.name ?? '',size_txt: 14.sp,)
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all()
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(userData.title, isbold: true, size_txt: 14.sp,max_lines: 2,),
                  spaceHeight(10.h),
                  CustomTextWidget(userData.content, size_txt: 12.sp,max_lines: 20,),
                  spaceHeight(10.h),
                  CustomTextWidget(userData.description, size_txt: 12.sp,max_lines: 20,),
                  spaceHeight(10.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(userData.urlToImage.toString()),
                  ),
                  spaceHeight(10.h),
                  Row(
                    children: [
                      Text(
                        "Published At: ",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      spaceWidth(10.w),

                      CustomTextWidget(userData.publishedAt, size_txt: 12.sp,max_lines: 20, ),
                    ],
                  ),
                  spaceHeight(10.h),
                  Row(
                    children: [
                      Text(
                        "Redirect to Site: ",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      spaceWidth(10.w),

                      InkWell(
                        onTap: (){
                          openLinks(userData.url);
                        },
                        child: Text(
                          "Click Here",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontStyle: FontStyle.italic,
                              color: Colors.blue.shade800,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

openLinks(url) async {
  //final url = "";
  if (await canLaunchUrl(Uri.parse(url))) {
    launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView);
  } else {
    throw 'Could not launch $url';
  }
}