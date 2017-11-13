//
//  OOCaptureView.h
//  BaseFramework
//
//  Created by Beelin on 17/2/21.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OOVideoRecordView;
@protocol OOVideoRecordViewDelegate <NSObject>

@required
/** 
 完成录制
 */
- (void)videoRecordView:(OOVideoRecordView *)videoRecordView didStopRecorderWithVideoUrl:(NSURL *)videoUrl;

/** 
 完成拍照
 */
- (void)videoRecordView:(OOVideoRecordView *)videoRecordView didPlayWithImageData:(NSData *)imageData;
@end


@interface OOVideoRecordView : UIView

@property (nonatomic, weak) id<OOVideoRecordViewDelegate> delegate;

- (void)startSession;

- (void)stopSession;


@end
