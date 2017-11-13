//
//  ZPBaseScrollView.h
//  MangoCityTravel
//
//  Created by linzhipei on 15-3-22.
//  Copyright (c) 2015年 mangocity. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OOBannerModel;
@interface OOBannerView : UIView

@property (nonatomic, copy) void(^clickImageBlock)(OOBannerModel *model);
@property (nonatomic,strong) NSArray *dataSource;

@end

@interface OOBannerModel : NSObject
@property (nonatomic, copy) NSString *imageName;
@end
