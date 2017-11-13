//
//  IDMPhoto.h
//  IDMPhotoBrowser
//
//  Created by Michael Waterfall on 17/10/2010.
//  Copyright 2010 d3i. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDMPhotoProtocol.h"
#import <SDWebImage/SDWebImageManager.h>

// This class models a photo/image and it's caption
// If you want to handle photos, caching, decompression
// yourself then you can simply ensure your custom data model
// conforms to IDMPhotoProtocol
@interface IDMPhoto : NSObject <IDMPhoto>

// Progress download block, used to update the circularView
typedef void (^IDMProgressUpdateBlock)(CGFloat progress);

// Properties
@property (nonatomic, strong) IDMProgressUpdateBlock progressUpdateBlock;

@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSURL *photoURL;
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, strong) UIImageView *placeholderImageView;
@property (nonatomic, assign, readonly) CGRect placeholderFrame;
@property (nonatomic, assign, readonly) BOOL loadingInProgress;

// Class
+ (IDMPhoto *)photoWithImage:(UIImage *)image;
+ (IDMPhoto *)photoWithFilePath:(NSString *)path;
+ (IDMPhoto *)photoWithURL:(NSURL *)url;

+ (NSArray *)photosWithImages:(NSArray *)imagesArray;
+ (NSArray *)photosWithFilePaths:(NSArray *)pathsArray;
+ (NSArray *)photosWithURLs:(NSArray *)urlsArray;

//+ (NSArray *)photosWithImages:(NSArray *)imagesArray placeholderImageViews:(NSArray *)placeholderImageViews;
//+ (NSArray *)photosWithFilePaths:(NSArray *)pathsArray placeholderImageViews:(NSArray *)placeholderImageViews;
//+ (NSArray *)photosWithURLs:(NSArray *)urlsArray placeholderImageViews:(NSArray *)placeholderImageViews;

// Init
- (id)initWithImage:(UIImage *)image;
- (id)initWithFilePath:(NSString *)path;
- (id)initWithURL:(NSURL *)url;

@end

