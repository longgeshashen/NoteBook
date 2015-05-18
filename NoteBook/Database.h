//
//  Database.h
//  NoteBook
//
//  Created by zx_06 on 15/4/29.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabase;

#define DB_NAME @"long.sqlite"

@interface Database : NSObject
{
    FMDatabase *db;
}
- (NSString*)SQL:(NSString*)sql inTable:(NSString*)table;

@end
