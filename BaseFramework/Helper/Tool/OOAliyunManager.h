//
//  OOAliyunManager.h
//  BaseFramework
//
//  Created by Beelin on 17/3/2.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OOImageModel;
@interface OOAliyunManager : NSObject
+ (id)sharedManager;

#pragma mark - 
/**
 单张图片上传
 @return 文件名
 @return 压缩过的图片
 */
- (void)uploadImageToAliyunWithImage:(UIImage *)image success:(void (^)(OOImageModel *))successBlock failed:(void (^)())failedBlock;
/** 多张图片上传 */
- (void)uploadImageToAliyunWithArrayImage:(NSArray *)arrayImage success:(void (^)(NSArray<OOImageModel *> *))successBlock failed:(void (^)())failedBlock;


#pragma mark -
/** 音频上传 */
- (void)uploadMP3ToAliyunWithFileName:(NSString *)fileName success:(void (^)())successBlock failed:(void (^)())failedBlock;
/** 音频下载 */
- (void)downloadMP3ToAliyunWithFileName:(NSString *)fileName success:(void (^)())successBlock failed:(void (^)())failedBlock;

#pragma mark -
/** 视频上传 */
- (void)uploadMP4ToAliyunWithFileName:(NSString *)fileName success:(void (^)())successBlock failed:(void (^)())failedBlock;
/** 视频下载 */
- (void)downloadMP4ToAliyunWithFileName:(NSString *)fileName success:(void (^)())successBlock failed:(void (^)())failedBlock;

#pragma mark - 
/** 根据文件名，获取url */
- (NSString *)getDownloadURLStringWithObjectName:(NSString *)objectName;

#pragma mark -
/** 取消上传操作 */
- (void)cancelAndRemovePutOperationWithKey:(NSString *)key;
/** 取消全部上传操作 */
- (void)removeAllPutOperation;
@end


/** 
 多张图片 model
 */
@interface OOImageModel : NSObject
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@end

