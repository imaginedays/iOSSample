//
//  RWCommonMacro.h
//  iOSSizeClasses
//
//  Created by imaginedays on 2018/9/18.
//  Copyright © 2018年 黄可. All rights reserved.
//

#ifndef RWCommonMacro_h
#define RWCommonMacro_h

#define RW_STATUS_BAR_HEIGHT ([UIDevice isPhoneX] ? 44.0f : 20.0f) //!< 状态栏高度
#define RW_NAVI_BAR_HEIGHT 44.0f                                   //!< 导航条高度

#define RW_KEYWINDOW     ([UIApplication sharedApplication].keyWindow)
#define RW_SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define RW_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define RW_SCREEN_SCALE  ([UIScreen mainScreen].scale)

#import "Masonry.h"
#endif /* RWCommonMacro_h */
