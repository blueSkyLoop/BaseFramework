//
//  OOVVIFileManager.h
//  BaseFramework
//
//  Created by Beelin on 17/2/21.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger) {
    OOFileTypeImage,
    OOFileTypeVoice,
    OOFileTypeVideo
}OOFileType;


@interface OOVVIFileManager : NSObject


+ (id)sharedManager;

#pragma Get
/** 
 获取路径
 @param directory 文件名
 */
- (NSString *)getLibarayCacheWithDirectory:(NSString *)directory;

/** 
 获取视频存储URL,视频名以当前日期为名
 */
- (NSURL*)getVideoSaveFilePathString;


#pragma mark - Query
/** 
 判断文件是否存在, 如果存在 返回
 */
- (BOOL)fileExistsWithName:(NSString *)fileName fileType:(OOFileType)fileType file:(void (^)(NSData * data,BOOL isExist))block_file;

#pragma mark - 
/** 
 压缩视频，转mp4格式
 */
- (void)compressedVideoToMFileTypeMPEG4WithVideoUrl:(NSURL *)videoUrl didFinishCompressed:(void(^)(NSURL *, UIImage *))finishCompressed;
@end
