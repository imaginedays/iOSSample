//
//  RWCommonMacro.h
//  iOSSizeClasses
//
//  Created by imaginedays on 2018/9/18.
//  Copyright © 2018年 黄可. All rights reserved.
//

#ifndef RWCommonMacro_h
#define RWCommonMacro_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


#pragma mark - Screen
#define RW_STATUS_BAR_HEIGHT ([UIDevice isPhoneX] ? 44.0f : 20.0f) //!< 状态栏高度
#define RW_NAVI_BAR_HEIGHT 44.0f                                   //!< 导航条高度

#define RW_KEYWINDOW     ([UIApplication sharedApplication].keyWindow)
#define RW_SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define RW_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define RW_SCREEN_SCALE  ([UIScreen mainScreen].scale)

#define RW_STATUS_BAR_HEIGHT ([UIDevice isPhoneX] ? 44.0f : 20.0f) //!< 状态栏高度
#define RW_NAVI_BAR_HEIGHT 44.0f                                   //!< 导航条高度
#define RW_TAB_BAR_HEIGHT ([UIDevice isPhoneX] ? 83.0f : 49.0f)    //!< TabBar高度
#define RW_TOOL_BAR_HEIGHT ([UIDevice isPhoneX] ? 83.0f : 44.0f)   //!< ToolBar高度
#define RW_TOP_BAR_HEIGHT ([UIDevice isPhoneX] ? 88.0f : 64.0f)    //!< 状态栏+导航条的高度
#define RW_SPLIT_LINE_WIDTH (1.0f / RW_SCREEN_SCALE)              //!< 分割线宽度或高度
#define RW_BOTTOM_SAFEAREA_HEIGHT ([UIDevice isPhoneX] ? 34.0f : 0.0f) //!< iPhone X 底部安全区域高度

#define iPhoneX ([UIDevice isPhoneX])

#pragma mark - Color
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define RGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

// 以十六进制方式传入，例如 HexRGB(0x005DA9)、HexRGB(color_main) 等
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

// 以字符串方式传入，例如 HexColor(@"#EEEEEE")、HexColor(kBackColor)
#define HexColor(hexString) [UIColor colorWithHex:hexString]
#define HexColorWithAlpha(hexString, a) [UIColor colorWithHex:hexString alpha:a]

#define kMainColor @"#4D7FFF"
#define kBackGroundColor @"#F3F5F9"


#endif /* RWCommonMacro_h */
