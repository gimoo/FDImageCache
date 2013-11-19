//
//  FDInit.h
//  study
//
//  Created by 笑虎 on 13-11-11.
//  Copyright (c) 2013年 笑虎. All rights reserved.
//

#ifndef study_FDInit_h
#define study_FDInit_h
#define XD_DEBUG 1

#define __XDLOG(s, ...) NSLog(@"%@",[NSString stringWithFormat:(s), ##__VA_ARGS__])

#if XD_DEBUG == 0
#define XDLOG(...) do {} while (0)
#elif XD_DEBUG == 1
#define XDLOG(...) __XDLOG(__VA_ARGS__)
#endif

//防止警告
#define XDSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//检测是否为空
#define XDIsNull(id) [id isEqual:[NSNull null]]

//当前屏幕高度
#define FD_SCREEN_MAIN_HEIGHT [[UIScreen mainScreen] bounds].size.height

//是否为iphone5设备
#define FD_IS_IPHONE5 (FD_SCREEN_MAIN_HEIGHT == 568)

//顶部nav导航+状态条
#define FD_SCREEN_NAV_HEIGHT 64

#define XD_RANDOM_0_1() ((random() / (float)0x7fffffff ))
#endif
