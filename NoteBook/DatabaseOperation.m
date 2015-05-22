//
//  DatabaseOperation.m
//  NoteBook
//
//  Created by zx_06 on 15/4/29.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DatabaseOperation.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
@implementation DatabaseOperation

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
#pragma mark - 建表
- (id)init{
    self = [super init];
    if (self) {
        if (![db tableExists:TABLE_NAME_NOTEBOOK]) {
            NSString *sql = [self SQL:@"create table if not exists '%@'('noteId' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'noteName' text,'noteTime' text,'noteStyle' text,'noteContent' text);" inTable:TABLE_NAME_NOTEBOOK];
            BOOL result = [db executeUpdate:sql];
            if (result) {
                debugLog(@"create table success");
            }else{
                debugLog(@"Fialed to create table");
            }
        }
        debugLog(@"table exists");
        [db close];
    }
    return self;
}
#pragma mark - 查找
#pragma mark - 查找所有满足条件的数据
- (NSMutableArray*)findByCriteria:(NSString *)criteria{
    NSMutableArray *resultArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableString *sql = [NSMutableString stringWithString:[self SQL:@"select * from %@" inTable:TABLE_NAME_NOTEBOOK]];
    if (criteria!=nil) {
        [sql appendString:criteria];
    }
    if ([db open]) {
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            //提取赋值
            NoteBook *nb = [[NoteBook alloc] init];
            nb.noteId = [resultSet intForColumn:@"noteId"];
            nb.noteName = [resultSet stringForColumn:@"noteName"];
            nb.noteTime = [resultSet stringForColumn:@"noteTime"];
            nb.noteStyle = [resultSet stringForColumn:@"noteStyle"];
            nb.noteContent = [resultSet stringForColumn:@"noteContent"];
            [resultArr addObject:nb];
        }
        [db close];
    }
    return resultArr;
    
}
#pragma mark - 查找第一个数据
- (NoteBook*)findFirstByCriteria:(NSString *)criteria{
    NSMutableArray *resultArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableString *sql = [NSMutableString stringWithString:[self SQL:@"select * from %@" inTable:TABLE_NAME_NOTEBOOK]];
    if (criteria!=nil) {
        [sql appendString:criteria];
    }
    if ([db open]) {
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            NoteBook *nb = [[NoteBook alloc] init];
            nb.noteId = [result intForColumn:@"noteId"];
            nb.noteName = [result stringForColumn:@"noteName"];
            nb.noteTime = [result stringForColumn:@"noteTime"];
            nb.noteStyle = [result stringForColumn:@"noteStyle"];
            nb.noteContent = [result stringForColumn:@"noteContent"];
            [resultArr addObject:nb];
        }
        [db close];
    }
    if ([resultArr count]>0) {
        return [resultArr objectAtIndex:0];
    }else{
        return nil;
    }
    
}
#pragma mark - 计数
- (NSInteger)countByCriteria:(NSString *)criteria{
    NSInteger count = 0;
    NSMutableString *sql = [NSMutableString stringWithString:[self SQL:@"select count(*) from %@" inTable:TABLE_NAME_NOTEBOOK]];
    if (criteria!=nil) {
        [sql appendString:criteria];
    }
    if ([db open]) {
        FMResultSet *res = [db executeQuery:sql];
        while ([res next]) {
            count = [res intForColumnIndex:0];
        }
        [db close];
    }
    return count;
}
#pragma mark -保存
#pragma mark -- 保存单个数据
- (void)saveNoteBook:(NoteBook *)noteBook{
    NSInteger index = noteBook.noteId;
    if (index >= 0) {
        [self updateAtIndex:index withNoteBook:noteBook];
    }else {
        //
        NSString *noteNamestr = [[NSString alloc] initWithString:noteBook.noteName];
        NSString *noteTimestr = [[NSString alloc] initWithString:noteBook.noteTime];
        NSString *noteStylestr = [[NSString alloc] initWithString:noteBook.noteStyle];
        NSString *noteContentstr = [[NSString alloc] initWithString:noteBook.noteContent];
        //db
        if ([db open]) {
            [db beginTransaction];
            NSString *sql = [self SQL:@"insert into %@ ('noteName','noteTime','noteStyle','noteContent')values(?,?,?,?);" inTable:TABLE_NAME_NOTEBOOK];
            BOOL res = [db executeUpdate:sql,noteNamestr,noteTimestr,noteStylestr,noteContentstr];
            if (res) {
                debugLog(@"插入数据成功");
            }else{
                debugLog(@"插入数据失败");
            }
            [db commit];
            [db close];
        }
    }
}
#pragma mark --存储 多个数据
//存储多个数据，对于多参数数据，不对，需要调整
- (void)saveNoteBooks:(NSArray *)noteBooks{
    NSMutableArray *values = [[NSMutableArray alloc] initWithCapacity:0];
    for (NoteBook *nb in noteBooks) {
        NSString *noteName = [NSString stringWithString:nb.noteName];
        NSMutableString *value = [[NSMutableString alloc]initWithFormat:@"%@",noteName];
        [values addObject:value];
    }
    if ([values count]>0) {
        if ([db open]) {
            [db beginTransaction];
            NSString *compinentStr = [values componentsJoinedByString:@","];
            NSString *sql = [self SQL:@"insert or ignore into %@ ('noteName') values ?" inTable:TABLE_NAME_NOTEBOOK];
            BOOL res = [db executeUpdate:sql,compinentStr];
            if (res) {
                debugLog(@"save data success");
            }else{
                debugLog(@"Failed to save data");
            }
            [db commit];
            [db close];
        }
    }
}
#pragma mark - 更新
- (BOOL)updateAtIndex:(NSInteger)index withNoteBook:(NoteBook *)noteBook{
    //
    NSNumber *indexID = [[NSNumber alloc]initWithInteger:noteBook.noteId];
    BOOL success = YES;
    NSString *noteNamestr = [[NSString alloc] initWithString:noteBook.noteName];
    NSString *noteTimestr = [[NSString alloc] initWithString:noteBook.noteTime];
    NSString *noteStylestr = [[NSString alloc] initWithString:noteBook.noteStyle];
    NSString *noteContentstr = [[NSString alloc] initWithString:noteBook.noteContent];
    if ([db open]) {
        [db beginTransaction];
        BOOL res = [db executeUpdate:[self SQL:@"update %@ set noteName = ?,noteTime = ?,noteStyle = ?,noteContent = ? where noteId = ?" inTable:TABLE_NAME_NOTEBOOK],noteNamestr,noteTimestr,noteStylestr,noteContentstr,indexID];
        if (res) {
            debugLog(@"更新成功");
        }else{
            debugLog(@"更新失败");
        }
        [db commit];
        [db close];
    }
    if ([db hadError]) {
        debugLog(@"err %d:%@",[db lastErrorCode],[db lastErrorMessage]);
        success = NO;
    }
    return success;
    
}
#pragma mark - 删除
- (BOOL)deleteAtIndex:(int)index{
    BOOL success = YES;
    if ([db open]) {
        BOOL res = [db executeUpdate:[self SQL:@"delete from %@ where noteId = ? " inTable:TABLE_NAME_NOTEBOOK],[NSNumber numberWithInt:index]];
        if (res) {
            debugLog(@"delete success");
        }else{
            debugLog(@"Failed to delete");
        }
        [db close];
        if ([db hadError]) {
            debugLog(@"err %d:%@",[db lastErrorCode],[db lastErrorMessage]);
            success = NO;
        }else{
            [db clearCachedStatements];
        }
    }
    return success;
}

@end
