//
//  DWDDataBaseHelper.m
//  EduChat
//
//  Created by KKK on 16/3/28.
//  Copyright © 2016年 dwd. All rights reserved.
//

#import "OODataBaseManager.h"
#import <FMDB.h>

@implementation OODataBaseManager
{
    FMDatabaseQueue* queue;
}


SingletonM(DataBaseManager);

- (instancetype)init {
    self = [super init];
    if(self){
        //数据库路径
//        queue = [FMDatabaseQueue databaseQueueWithPath:];
    }
    return self;
}


-(void) inDatabase:(void(^)(FMDatabase *db))block
{
    [queue inDatabase:^(FMDatabase *db){
        block(db);
    }];
}

- (void)beginTransactionInDatabase:(void (^)(FMDatabase *, BOOL *))block {
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        block(db, rollback);
    }];
}
/*
 FMDB多线程操作事务
-(void)shiwu
{
    [_dataBase inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (int i = 0; i<500; i++) {
            NSString *nId = [NSString stringWithFormat:@"%d",i];
            NSString *strName = [[NSString alloc] initWithFormat:@"student_%d",i];
            NSString *sql = @"INSERT INTO Student (id,student_name) VALUES (?,?)";
            BOOL a = [db executeUpdate:sql,nId,strName];
            if (!a) {
                *rollback = YES;
                return;
            }
        }
    }];
    
}
*/
-(void)resetDB {
    //数据库路径
//    queue = [FMDatabaseQueue databaseQueueWithPath:DWDDatabasePath];
}

@end
