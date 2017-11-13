//
//  NSString+Extend.h
//  BaseFramework
//
//  Created by Mantis-man on 16/1/18.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)
/**
 *  拼接请求参数 参数1&参数2&参数3
 **/
+ (NSString *)URLParamWithDict:(NSDictionary *)param;

/**
 *  是否是手机号码
 **/
+ (BOOL)isValidatePhone:(NSString *)phone;

/**
 *  是否是邮箱
 **/
+ (BOOL)isValidateEmail:(NSString *)email;



- (NSString *)trim;// 去掉前后空格
- (BOOL)isEmptyStringTrim;
- (BOOL)isEmptyString;


// http://
- (NSString *)httpUrl;

// 包含字串
// options yes 忽略大小写
- (BOOL)hasSubString:(NSString *)aString options:(BOOL)bIgnore;

- (BOOL)containChinese;

- (NSString*)md5;

// 检查是否为中英文混合
- (BOOL)isChineseEnglish;


// 检查是否为ip地址
- (BOOL)isIPAddress;


//MD5 32位加密 小写
- (NSString*)md532BitLower;
//MD5 32位加密 大写
- (NSString*)md532BitUpper;

//计算文本单行字体高度
- (CGSize)boundingRectWithfont:(UIFont *)font;
//计算文本多行字体高度
- (CGSize)boundingRectWithfont:(UIFont *)font sizeMakeWidth:(CGFloat)width;

@end
