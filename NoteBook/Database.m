//
//  Database.m
//  NoteBook
//
//  Created by zx_06 on 15/4/29.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "Database.h"
#import "FMDatabase.h"
@implementation Database

- (id)init{
    self = [super init];
    if (self) {
        NSString *dbPath = [documentPath stringByAppendingPathComponent:DB_NAME];
        db = [FMDatabase databaseWithPath:dbPath];
        if ([db open]) {
            [db setShouldCacheStatements:YES];
            debugLog(@"open db success");
        }else
        {
            debugLog(@"failed to open db");
        }
    }
    return self;
}
#pragma mark - 执行SQL语句
- (NSString*)SQL:(NSString *)sql inTable:(NSString *)table{
    return [NSString stringWithFormat:sql,table];
}
@end
