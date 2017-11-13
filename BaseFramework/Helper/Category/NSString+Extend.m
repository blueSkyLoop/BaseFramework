//
//  NSString+Extend.m
//  BaseFramework
//
//  Created by Mantis-man on 16/1/18.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "NSString+Extend.h"
#import <commoncrypto/CommonDigest.h>
@implementation NSString (extend)
+ (NSString *)URLParamWithDict:(NSDictionary *)param
{
    NSMutableString *result = [NSMutableString string];
    
    for (NSString *key in param)
    {
        [result appendFormat:@"%@=%@&", key, [param objectForKey:key]];
    }
    if ([result length] > 0)
    {
        [result deleteCharactersInRange:NSMakeRange([result length] - 1, 1)];
    }
    
    return result;
}

+ (BOOL)isValidatePhone:(NSString *)phone
{
    NSString *phoneRegex = @"^1[0-9]{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}

+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


- (BOOL)isEmptyString
{
    return (nil == self) || (self.length == 0);
}

- (BOOL)isEmptyStringTrim
{
    return [[self trim] isEmptyString];
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


#pragma mark -
#pragma mark - http://

- (NSString *)httpUrl
{
    if ([self isEmptyStringTrim])
    {
        return nil;
    }
    
    if ([self hasPrefix:@"http://"])
    {
        return self;
    }
    else
    {
        return [NSString stringWithFormat:@"http://%@", [self trim]];
    }
}

#pragma mark -
#pragma mark -- has substring
// options yes 忽略大小写
- (BOOL)hasSubString:(NSString *)aString options:(BOOL)bIgnore
{
    if ([aString isEmptyString])
    {
        return NO;
    }
    
    NSRange range;
    if (bIgnore)
    {
        range = [self rangeOfString:aString options:NSCaseInsensitiveSearch
                 | NSNumericSearch];
    }
    else
    {
        range = [self rangeOfString:aString];
    }
    
    if (range.length == 0)
    {
        return NO;
    }
    
    return YES;
}

// 检查中文
- (BOOL)containChinese
{
    NSString *Chinese = @"^[\\u4e00-\\u9fa5]+$";
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Chinese];
    
    if ([regextestct evaluateWithObject:self] == YES)
    {
        return YES;
    }
    
    return NO;
}

- (NSString*)md5
{
    if(nil == self)
        return nil;
    
    const char*cStr =[self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
           result[0], result[1], result[2], result[3],
           result[4], result[5], result[6], result[7],
           result[8], result[9], result[10], result[11],
           result[12], result[13], result[14], result[15]
           ];
}

// 检查是否为中英文混合
- (BOOL)isChineseEnglish
{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *regex = @"([\u4e00-\u9fa5]+[a-zA-z]+)|([a-zA-z]+[\u4e00-\u9fa5]+)|([\u4e00-\u9fa5]+)|([a-zA-z]+)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",regex];
    if ([predicate evaluateWithObject:trimmedString] == YES)
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)isIPAddress
{
    NSArray *			components = [self componentsSeparatedByString:@"."];
    NSCharacterSet *	invalidCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    
    if ( [components count] == 4 )
    {
        NSString *part1 = [components objectAtIndex:0];
        NSString *part2 = [components objectAtIndex:1];
        NSString *part3 = [components objectAtIndex:2];
        NSString *part4 = [components objectAtIndex:3];
        
        if ( 0 == [part1 length] ||
            0 == [part2 length] ||
            0 == [part3 length] ||
            0 == [part4 length] )
        {
            return NO;
        }
        
        if ( [part1 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part2 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part3 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part4 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound )
        {
            if ( [part1 intValue] <= 255 &&
                [part2 intValue] <= 255 &&
                [part3 intValue] <= 255 &&
                [part4 intValue] <= 255 )
            {
                return YES;
            }
        }
    }
    
    return NO;
}


- (NSString*)md532BitLower

{
    
    const char *cStr = [self UTF8String];
    
    unsigned char result[16];
    
    
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    
    CC_MD5( cStr,[num intValue], result );
    
    
    
    return [[NSString stringWithFormat:
             
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             
             result[0], result[1], result[2], result[3],
             
             result[4], result[5], result[6], result[7],
             
             result[8], result[9], result[10], result[11],
             
             result[12], result[13], result[14], result[15]
             
             ] lowercaseString];
    
}

- (NSString*)md532BitUpper

{
    
    const char *cStr = [self UTF8String];
    
    unsigned char result[16];
    
    
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    
    CC_MD5( cStr,[num intValue], result );
    
    
    
    return [[NSString stringWithFormat:
             
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             
             result[0], result[1], result[2], result[3],
             
             result[4], result[5], result[6], result[7],
             
             result[8], result[9], result[10], result[11],
             
             result[12], result[13], result[14], result[15]
             
             ] uppercaseString];
    
}

- (CGSize)boundingRectWithfont:(UIFont *)font{
    NSDictionary *dict = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}
- (CGSize)boundingRectWithfont:(UIFont *)font sizeMakeWidth:(CGFloat)width{
    NSDictionary *dict = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}
@end
