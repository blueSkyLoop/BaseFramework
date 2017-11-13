//
//  DWDPickUpCenterDataBaseHelper.h
//  EduChat
//
//  Created by KKK on 16/3/28.
//  Copyright © 2016年 dwd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;
@interface OODataBaseManager : NSObject

SingletonH(DataBaseManager);


-(void) inDatabase:(void(^)(FMDatabase *db))block;

-(void) beginTransactionInDatabase:(void(^)(FMDatabase *db, BOOL *rollback))block;

/** 刷新数据库 */
- (void)resetDB;

@end
