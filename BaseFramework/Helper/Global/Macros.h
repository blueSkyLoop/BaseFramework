//
//  Macros.h
//  BaseFramework
//
//  Created by Mantis-man on 16/1/16.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//  定义宏

#pragma mark - frame
/** 屏幕宽度 **/
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

/** 屏幕高度 **/
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/** 顶部栏高度 **/
#define TOPBARHEIGHT 64

/** 顶部栏高度 **/
#define TARBARHEIGHT 49

// 计算自适应高度
#define rectHeight(objc)         (Screen_Width / 375.0) * objc


#pragma mark - Device
//是否为IOS7及以上
#define IOS7ABOVE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f ? YES : NO)

//是否为IOS8及以上
#define IOS8ABOVE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f ? YES : NO)

//是否为Iphone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//是否为iPhone6
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

//是否为iPhone6 Plus
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)


#pragma mark - Color
// RGB色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBColor_alpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
// 随机色
#define RandomColor ZPRGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//十六进制转RGB色
#define UIColorFromRGB(rgbValue) UIColorFromRGBWithAlpha(rgbValue, 1.0f)
#define UIColorFromRGBWithAlpha(rgbValue, alpha1) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha1]

//主调色
#define ColorMain RGBColor(90,136, 231)
//背景色
#define ColorBackgroud RGBColor(245,245, 245)
//分割线色
#define ColorSeparator RGBColor(221,221, 221)

//正常文本色
#define ColorBody RGBColor(51,51, 51)
//内容文本色
#define ColorContent RGBColor(102,102, 102)
//次要辅助色
#define ColorSecondary RGBColor(153,153, 153)
//按钮高亮色
#define ColorHighlight RGBColor(60,93, 161)


#pragma mark - Font
//正常大小
#define FontBody [UIFont systemFontOfSize:16]            //文章标题、输入文字
#define FontContent [UIFont systemFontOfSize:14]         //一般字号，文章正文
#define FontMin [UIFont systemFontOfSize:12]             //注释文字，解释说明



#pragma mark - Use Class
/** 常用类 */
/** 常用分类 */
/** 常用第三方类 */
#import "Singleton.h"

#pragma mark - Othor
/** 生成UUID */
#define OOUUID [NSUUID UUID].UUIDString

//获取沙盒 Document
#define PATH_DOCUMENT [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Libaray目录的Cache
#define PATH_CACHE [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//获取泥沙盒 tmp
#define PATH_TMP NSTemporaryDirectory();


// 字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
// 数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
// 字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
// 是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
// 是否空对象
#define IS_NULL_CLASS(OBJECT) [OBJECT isKindOfClass:[NSNull class]]

//弱引用/强引用  可配对引用在外面用WeakSelf(self)，block用StrongSelf(self)  也可以单独引用在外面用WeakSelf(self) block里面用weakself
#define WeakSelf(type)  __weak typeof(type) weak##type = type;
#define StrongSelf(type)  __strong typeof(type) type = weak##type;
