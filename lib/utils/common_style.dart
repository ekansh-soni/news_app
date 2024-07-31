
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingDialog {
  LoadingDialog({
    required this.context,
    required this.title,
    required this.message,
    required this.dismissable,
  });

  final Widget title;
  final Widget message;
  final bool dismissable;
  final BuildContext context;
  bool isShowing = false;

  void show() {
    if (!isShowing) {
      showGeneralDialog(
        barrierDismissible: dismissable,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        context: context,
        /* transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position:
                Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 200),*/
        pageBuilder: (_, __, ___) {
          return LoadingDialog_ui(
              title: title, message: message, dismissable: dismissable);
        },
      );
      isShowing = true;
    }
  }

  void dismiss() {
    if (isShowing) {
      Navigator.of(context, rootNavigator: true).pop();
      isShowing = false;
    }
  }
}

class LoadingDialog_ui extends StatelessWidget {
  const LoadingDialog_ui({
    Key? key,
    required this.title,
    required this.message,
    required this.dismissable,
  }) : super(key: key);

  final Widget title;
  final Widget message;
  final bool dismissable;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => dismissable ? true : false,
      child: Container(
        height: 1.sh,
        alignment: Alignment.center,
        // alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: 1.sw,
          height: 80.h,
          child: /*Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.h),
                    topRight: Radius.circular(10.h))),
            elevation: 10.h,
            child: Container(
                padding: EdgeInsets.all(10.h),
                child: Row(
                  children: [
                    CircularProgressIndicator(color: greenBgColor,),
                    SizedBox(width: 20.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [title, SizedBox(height: 10.h), message],
                    ),
                  ],
                )),
          )*/ Center(child: Image.asset("assets/loader.gif",height: 150,width: 150,),),
        ),
      ),
    );
  }
}

class Custom_Dialog {
  Custom_Dialog(
      {required this.mcontext,
        this.title,
        required this.message,
        this.dismissable = true,
        this.positive_btn_text,
        this.negative_btn_text,
        this.onpress,
        this.isClose = false,
        this.isfinish = false,
        this.dismissDialog = true,
        this.onnegative_press});

  bool dismissable = true;
  bool isClose = false;
  bool isfinish;
  bool dismissDialog;
  final BuildContext mcontext;
  final String message;
  String? title = "Message!!";
  String? positive_btn_text = "Done";
  String? negative_btn_text = "Cancel";
  Function? onpress, onnegative_press;

  void show() {
    showGeneralDialog(
      barrierDismissible: dismissable,
      barrierLabel: MaterialLocalizations.of(mcontext).modalBarrierDismissLabel,
      context: mcontext,
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: widget),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (context, __, ___) {
        return               WillPopScope(
          onWillPop: () async => dismissable ? true : false,
          child: Container(
            margin: EdgeInsets.only(
                top: 80.h, bottom: 56.h, left: 20.w, right: 20.w),
            height: 1.sh,
            alignment: Alignment.center,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  surfaceTintColor: Colors.blueGrey,
                  elevation: 3.h,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.blue,
                        padding: EdgeInsets.all(5.h),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 30.h,
                              width: 30.w,
                              child: const Icon(Icons.message,color: Colors.white,),
                            ),
                            SizedBox(width: 10.w),
                            CustomTextWidget(
                              title ?? "Message",
                              size_txt: 18.sp,
                              isbold: true,
                              color_txt: Colors.white,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30.w),
                        child: CustomTextWidget(
                          message,
                          max_lines: 10,
                          size_txt: 15.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            negative_btn_text != null
                                ? negative_btn_text!.isNotEmpty
                                ? TextButton(
                                child: Text(negative_btn_text!),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  if (onnegative_press != null) {
                                    onnegative_press!();
                                  }
                                })
                                : Container()
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomTextWidget extends StatelessWidget {
  final String? _title;
  final Color? _color;
  final double? _size;
  final int? _maxlines;
  final TextAlign? _textAlign;
  final double? _linespace;
  final String? _fontfamily;
  final bool _isbold;
  final bool _issemibold;
  final TextOverflow _textOverflow;

  CustomTextWidget(String? title,
      {Key? key,
        Color? color_txt,
        double? size_txt,
        int? max_lines,
        TextAlign? textAlign,
        double? line_space,
        String? font_family,
        bool isbold = false,
        bool issemibold = false,
        TextOverflow textOverflow = TextOverflow.ellipsis})
      : this._title = title,
        this._color = color_txt,
  //   this._size = size_txt,
        this._size = size_txt == null ? 11.sp : size_txt,
        this._maxlines = max_lines,
        this._textAlign = textAlign,
        this._linespace = line_space,
        this._fontfamily = font_family,
        this._isbold = isbold,
        this._issemibold = issemibold,
        this._textOverflow = textOverflow,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_title',
      style: TextStyle(
          fontWeight: _isbold
              ? FontWeight.w600
              : _issemibold
              ? FontWeight.w400
              : FontWeight.normal,
          color: _color,
          fontSize: _size,
          letterSpacing: _linespace,
          height: _linespace),
      overflow: _textOverflow,
      maxLines: _maxlines,
      textAlign: _textAlign,
    );
  }
}

SizedBox spaceHeight(double height){
  return SizedBox(height:  height,);
}

SizedBox spaceWidth(double width){
  return SizedBox(height:  width,);
}