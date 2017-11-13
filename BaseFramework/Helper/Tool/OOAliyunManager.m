//
//  OOAliyunManager.m
//  BaseFramework
//
//  Created by Beelin on 17/3/2.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OOAliyunManager.h"

#import "AliyunOSSiOS/OSSService.h"
#import <SDImageCache.h>

static NSString * const kEndPoint = @"http://oss-cn-shenzhen.aliyuncs.com";
static NSString * const kBucketName = @"huijiale";

//获取沙盒 Libaray目录的Cache
#define PATH_CACHE [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface OOAliyunManager ()
@property (nonatomic, strong) OSSClient *client;
@property (nonatomic, strong) NSMutableDictionary *putDict;
@end

@implementation OOAliyunManager
#pragma mark - Init
+ (id)sharedManager
{
    static OOAliyunManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[OOAliyunManager alloc] init];
    });
    return manager;
}
- (instancetype)init{
    if (self = [super init]) {
        [self setOSSConfig];
    }
    return self;
}

#pragma mark - OSS config
- (void)setOSSConfig{
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId: @""
                                                                                          secretKeyId:@"" securityToken:@""];
    
    OSSClientConfiguration * conf = [OSSClientConfiguration new];
    conf.maxRetryCount = 2;
    conf.timeoutIntervalForRequest = 30;
    conf.timeoutIntervalForResource = 24 * 60 * 60;
    
    self.client = [[OSSClient alloc] initWithEndpoint:kEndPoint credentialProvider:credential clientConfiguration:conf];
    
}

/** 获取OSS相关配置 */
- (BOOL)getOssConfig{
    return YES;
}

#pragma mark - Upload
- (void)uploadObjectToAliyunWithFileName:(NSString *)fileName filePath:(NSString *)filePath success:(void (^)())successBlock failed:(void (^)())failedBlock{
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = kBucketName;
    put.objectKey = fileName;
    put.uploadingFileURL = [NSURL fileURLWithPath:filePath];
    // put.uploadingData = <NSData *>; // 直接上传NSData
    
    //add putDict
    [self.putDict setObject:put forKey:fileName];
    
#ifdef DEBUG
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        // 当前上传段长度、当前已经上传总长度、一共需要上传的总长度
        OOLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
#endif
    
    OSSTask * putTask = [self.client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            OOLog(@"upload object success!");
            [self.putDict removeAllObjects];
            successBlock();
        } else {
            if (task.error.code == -403) {
                if ([self getOssConfig]) {
                    [self setOSSConfig];
                    [self uploadObjectToAliyunWithFileName:fileName filePath:filePath success:successBlock failed:failedBlock];
                }else{
                    failedBlock();
                }
            }else{
                failedBlock();
            }
        }
        [self.putDict removeObjectForKey:fileName];
        return nil;
    }];
}

- (void)uploadImageToAliyunWithImage:(UIImage *)image success:(void (^)(OOImageModel *model))successBlock failed:(void (^)())failedBlock{
    NSString *fileName = [[NSUUID UUID].UUIDString stringByAppendingString:@".png"];
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = kBucketName;
    put.objectKey = fileName;
    
    NSString *urlStr = [self getDownloadURLStringWithObjectName:fileName];
    //add putDict
    [self.putDict setObject:put forKey:fileName];
    
    UIImage *newImage;
    @autoreleasepool {
        newImage = [UIImage imageWithData:UIImageJPEGRepresentation(image, 0.6)];
    }
    [[SDImageCache sharedImageCache] storeImage:newImage forKey:urlStr toDisk:YES];
    [[SDImageCache sharedImageCache] diskImageExistsWithKey:urlStr completion:^(BOOL isInCache) {
        if (isInCache) {
            NSString *path = [[SDImageCache sharedImageCache] defaultCachePathForKey:urlStr];
            put.uploadingFileURL = [NSURL URLWithString:path];
            OOLog(@"Compressed File size is : %.2f KB",(float)UIImageJPEGRepresentation(image, 1).length/1024.0f);
            
            OSSTask * putTask = [self.client putObject:put];
            [putTask continueWithBlock:^id(OSSTask *task) {
                if (!task.error) {
                    OOImageModel *model = [[OOImageModel alloc] init];
                    model.image = newImage;
                    model.fileName = fileName;
                    model.width = newImage.size.width;
                    model.height = newImage.size.height;
                    successBlock(model);
                } else {
                    if (task.error.code == -403) {
                        if ([self getOssConfig]) {
                            [self setOSSConfig];
                            [self uploadImageToAliyunWithImage:image success:successBlock failed:failedBlock];
                        }else{
                            failedBlock();
                        }
                    }else{
                        failedBlock();
                    }
                }
                [self.putDict removeObjectForKey:fileName];
                return nil;
            }];
        }
        
    }];
}

- (void)uploadImageToAliyunWithArrayImage:(NSArray *)arrayImage success:(void (^)(NSArray<OOImageModel*> *))successBlock failed:(void (^)())failedBlock{
    __block BOOL uploadSuccess = YES;
    __block NSMutableArray *imageModelArray = [NSMutableArray arrayWithCapacity:arrayImage.count];
    
    dispatch_group_t group = dispatch_group_create();
    for (NSInteger i = 0; i < arrayImage.count; i ++) {
        dispatch_group_enter(group);
        
        [self uploadImageToAliyunWithImage:arrayImage[i] success:^(OOImageModel *model) {
            [imageModelArray addObject:model];
            dispatch_group_leave(group);
        } failed:^{
            [self uploadImageToAliyunWithImage:arrayImage[i] success:^(OOImageModel *model) {
                [imageModelArray addObject:model];
                dispatch_group_leave(group);
            } failed:^{
                uploadSuccess = NO;
                dispatch_group_leave(group);
            }];
        }];
    }
    
    dispatch_group_notify(group,  dispatch_get_main_queue(), ^{
        if (uploadSuccess) {
            successBlock(imageModelArray.copy);
        }else{
            failedBlock();
        }
        
    });
}- (void)uploadMP3ToAliyunWithFileName:(NSString *)fileName success:(void (^)())successBlock failed:(void (^)())failedBlock{
    NSString *path = [NSString stringWithFormat:@"%@/%@", PATH_CACHE, fileName];
    [self uploadObjectToAliyunWithFileName:fileName filePath:path success:successBlock failed:failedBlock];
}

- (void)uploadMP4ToAliyunWithFileName:(NSString *)fileName success:(void (^)())successBlock failed:(void (^)())failedBlock{
    NSString *path = [NSString stringWithFormat:@"%@/%@", PATH_CACHE, fileName];
    [self uploadObjectToAliyunWithFileName:fileName filePath:path success:successBlock failed:failedBlock];
}



#pragma mark - Download
- (void)downloadObjectWithFileName:(NSString *)fileName filePath:(NSString *)filePath success:(void (^)())successBlock failed:(void (^)())failedBlock{
    OSSGetObjectRequest * request = [OSSGetObjectRequest new];
    request.bucketName = kBucketName;
    request.objectKey = fileName;
    request.downloadToFileURL = [NSURL fileURLWithPath:filePath];
    
#ifdef DEBUG
    request.downloadProgress = ^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        OOLog(@"%lld, %lld, %lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    };
#endif
    
    OSSTask * getTask = [self.client getObject:request];
    [getTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            
        } else {
            if (task.error.code == -403) {
                if ([self getOssConfig]) {
                    [self setOSSConfig];
                    [self downloadObjectWithFileName:fileName filePath:filePath success:successBlock failed:failedBlock];
                }else{
                    failedBlock();
                }
            }else{
                failedBlock();
            }
        }
        [self.putDict removeObjectForKey:fileName];
        return nil;
        
    }];
}

- (void)downloadMP3ToAliyunWithFileName:(NSString *)fileName success:(void (^)())successBlock failed:(void (^)())failedBlock{
    NSString *path = [NSString stringWithFormat:@"%@/%@", PATH_CACHE, fileName];
    [self downloadObjectWithFileName:fileName filePath:path success:successBlock failed:failedBlock];
}

- (void)downloadMP4ToAliyunWithFileName:(NSString *)fileName success:(void (^)())successBlock failed:(void (^)())failedBlock{
    NSString *path = [NSString stringWithFormat:@"%@/%@", PATH_CACHE, fileName];
    [self downloadObjectWithFileName:fileName filePath:path success:successBlock failed:failedBlock];
    
}

#pragma mark - Cancel Operation
- (void)cancelAndRemovePutOperationWithKey:(NSString *)key{
    OSSPutObjectRequest *put = [self.putDict objectForKey:key];
    [put cancel];
    [self.putDict removeObjectForKey:key];
}

- (void)removeAllPutOperation{
    NSArray *puts = [self.putDict allValues];
    for (OSSPutObjectRequest *put in puts) {
        [put cancel];
    }
    [self.putDict removeAllObjects];
}

#pragma mark - Get URL
- (NSString *)getDownloadURLStringWithObjectName:(NSString *)objectName{
    NSString * publicURL = nil;
    // sign public url
    OSSTask * task = [self.client presignPublicURLWithBucketName:kBucketName withObjectKey:objectName];
    if (!task.error) {
        publicURL = task.result;
        return publicURL;
    } else {
        return nil;
    }
}


#pragma mark - Getter
- (NSMutableDictionary *)putDict{
    if (!_putDict) {
        _putDict = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _putDict;
}
@end


@implementation OOImageModel
@end
