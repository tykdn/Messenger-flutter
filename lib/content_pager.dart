import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messenger_flutter/card_free.dart';
import 'package:messenger_flutter/card_recommend.dart';
import 'package:messenger_flutter/card_share.dart';
import 'package:messenger_flutter/card_special.dart';
import 'package:messenger_flutter/custom_appbar.dart';

class ContentPager extends StatefulWidget {
  //内部调动外部方法
  final ValueChanged<int> onPageChanged;
  //在线面定义的类，外部调动内部方法
  final ContentPagerController contentPagerController;
 //构造方法，可选参数
  const ContentPager({Key key, this.onPageChanged, this.contentPagerController}) 
  /**初始化列表**/
  : super(key: key);
  @override
  _ContentPagerState createState() => _ContentPagerState();
}

class _ContentPagerState extends State<ContentPager> {
  PageController _pageController = PageController(
    //视窗比例
     viewportFraction: 0.9
  );
  static List<Color> _colors=[
      Colors.blue,
      Colors.red,
      Colors.deepOrange,
      Colors.teal
  ]; 
  @override
  void initState() {
    if(widget.contentPagerController!=null){
      widget.contentPagerController._pageController = _pageController;
    }
    _statusBar();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //appBar
        CustomAppBar(),
        Expanded(
          //高度撑开，否则在Column中没有高度会报错
          child: PageView(
            onPageChanged: widget.onPageChanged,
            controller: _pageController,
            children: <Widget>[
              _wrapItem(CardRecommend()),
              _wrapItem(CardShare()),
              _wrapItem(CardFree()),
              _wrapItem(CardSpecial()),
            ],
        ),)
      ],
    );
  }
 Widget _wrapItem(Widget widget){
    return Padding(padding: EdgeInsets.all(10),
    child: widget,
    );
    //状态样式-沉浸式状态栏
  }
  _statusBar(){
    //黑色沉浸式状态栏，基于SystemUiOverlayStayle.dark修改了statueBarColor
    SystemUiOverlayStyle uiOverlayStyle = SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF000000),
      systemNavigationBarDividerColor: null,
      statusBarColor: Colors.transparent,//兼容了ios和安卓沉浸式状态栏
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(uiOverlayStyle);
  }
}
//内容区域的控制器
class ContentPagerController{
  PageController _pageController;
  void jumpToPage(int page){
    //dart 编程技巧：安全的调用
    _pageController?.jumpToPage(page);
  }
}