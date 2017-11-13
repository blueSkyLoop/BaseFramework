//
//  OOVVIFileManager.m
//  BaseFramework
//
//  Created by Beelin on 17/2/21.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OOVVIFileManager.h"

#import <AVFoundation/AVFoundation.h>
#import "NSString+Extend.h"

@interface OOVVIFileManager()
@property (nonatomic, copy) NSString *basePath;
@end

@implementation OOVVIFileManager
+ (id)sharedManager
{
    static OOVVIFileManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[OOVVIFileManager alloc] init];
    });
    return manager;
}

#pragma mark - Creat
- (void)createLibarayCacheWithDirectoryName:(NSString *)directoryName{
    NSString * filePath = [self.basePath stringByAppendingPathComponent:directoryName];
    
    NSFileManager * fileMangaer = [NSFileManager defaultManager];
    BOOL success = [fileMangaer createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    if (!success) {
        NSAssert(!success, @"文件创建失败");
    }
}

#pragma mark - Get
- (NSString *)getLibarayCacheWithDirectoryName:(NSString *)directoryName{
    NSString *path = [self.basePath stringByAppendingPathComponent:directoryName];
    return path;
}

- (NSURL*)getVideoSaveFilePathString{
    NSString *fileName = [self createFileName];
    NSString *path = [NSString stringWithFormat:@"%@/%@.mp4", self.basePath, fileName];
    NSURL *url = [NSURL URLWithString:path];
    return url;
}

#pragma mark - Query
//  判断文件是否存在, 如果存在 返回
- (BOOL)fileExistsWithName:(NSString *)fileName fileType:(OOFileType)fileType file:(void (^)(NSData * data,BOOL isExist))block_file{
    NSFileManager* filemanager = [NSFileManager defaultManager];
    
    NSString * filePath = nil;
    switch (fileType) {
        case OOFileTypeImage:
            filePath = [NSString stringWithFormat:@"%@/%@.jpg",[self getLibarayCacheWithDirectoryName:@"Image"],fileName];
            break;
        case OOFileTypeVoice:
            filePath = [NSString stringWithFormat:@"%@/%@.mp3",[self getLibarayCacheWithDirectoryName:@"Voice"],fileName];
            break;
        case OOFileTypeVideo:
            filePath = [NSString stringWithFormat:@"%@/%@.mp4",[self getLibarayCacheWithDirectoryName:@"Video"],fileName];
            break;
    }
    
    BOOL flag;
    flag = [filemanager fileExistsAtPath:filePath isDirectory:nil];
    if (flag) {
        NSData * fileData = [NSData dataWithContentsOfFile:filePath];
        if (block_file) {
            block_file(fileData,YES);
            return YES;
        }
        else{
            return YES;
        }
    }
    else{
        block_file(nil,NO);
        return NO;
    }
}

#pragma mark - Public Method
- (void)compressedVideoToMFileTypeMPEG4WithVideoUrl:(NSURL *)videoUrl didFinishCompressed:(void (^)(NSURL *, UIImage *))finishCompressed{
    if (!videoUrl) return;

    AVURLAsset *avAsset = [[AVURLAsset alloc] initWithURL:videoUrl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
      
        exportSession.outputURL = [self getVideoSaveFilePathString];
        //优化网络
        exportSession.shouldOptimizeForNetworkUse = true;
        //转换后的格式
        exportSession.outputFileType = AVFileTypeMPEG4;
        //异步导出
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            // 如果导出的状态为完成
            if ([exportSession status] == AVAssetExportSessionStatusCompleted) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:exportSession.outputURL options:nil];
                    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
                    gen.appliesPreferredTrackTransform = YES;
                    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
                    NSError *error = nil;
                    CMTime actualTime;
                    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
                    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
                    CGImageRelease(image);
                    
                    //call back
                    finishCompressed(exportSession.outputURL, thumb);
                });
                
            }else{
                OOLog(@"当前压缩进 度:%f",exportSession.progress);
            }
        }];
    }

}
#pragma mark - Private
- (NSString *)createFileName{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString* nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    NSString *fileName = [nowTimeStr md532BitLower];
    return fileName;
}
#pragma mark - Getter
- (NSString *)basePath{
    if (!_basePath) {
        _basePath = PATH_CACHE;
    }
    return _basePath;
}

@end
