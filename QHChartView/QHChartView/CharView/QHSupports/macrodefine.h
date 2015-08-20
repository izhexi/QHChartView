//
//  macrodefine.h
//  QHSimpleFrame
//
//  Created by imqiuhang on 15/3/31.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//


//>>>>>>>>>>>>>>>>>>>>>一些公共的宏定义 如宏方法，颜色，字体，通知的key等


#ifndef macrodefine_h
#define macrodefine_h

//>>>>>>>>>>>>>>>>>>>>>宏方法

//keyWindow,屏幕宽 屏幕高
#define KEY_WINDOW                [[UIApplication sharedApplication] keyWindow]
#define screenWidth               [[UIScreen mainScreen] bounds].size.width
#define screenHeight              [[UIScreen mainScreen] bounds].size.height

///RGB
#define QHRGBA(r, g, b,a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:a]
#define QHRGB(r, g, b) QHRGBA(r,g,b,1)

///请使用 MSLog代替NSLog MSLog在发布的产品不会打印日志
#ifdef DEBUG
#define MSLog(fmt,...) NSLog((@"\n\n[行号]%d\n" "[函数名]%s\n" "[日志]"fmt"\n"),__LINE__,__FUNCTION__,##__VA_ARGS__);
#else
#define MSLog(fmt,...);
#endif



//>>>>>>>>>>>>>>>>>>>>>版本相关

//IOS版本号 float
#define IOS_VERSION            [[[UIDevice currentDevice] systemVersion] floatValue]

///是否是iPad
#define IS_IPAD                (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

///app版本号  string类型 如 1.0.1
#define APPVERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]







//>>>>>>>>>>>>>>>>>>>>>宏量

//custom的错误信息打印头,用于和系统的错误区分

#define customErrorDoMain @"imqiuhang_customErrorDoMain"

#define noresultErrorCode 2364900

#define tabBarHeight 48.f



//>>>>>>>>>>>>>>>>>>>>>颜色,字体等公共属性

/*颜色*/

#define titleColor                     QHRGB(67,73,82)
#define subTitleLableColor             QHRGB(122,128,137)


/*字体*/

#define defaultFont(s) [UIFont fontWithName:@"STHeitiSC-Light" size:s]



//>>>>>>>>>>>>>>>>>>>>>通知Name


#define ExampleViewControllerDidDoSomethingNotify @"ExampleViewControllerDidDoSomethingNotify"



#endif







