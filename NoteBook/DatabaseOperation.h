//
//  DatabaseOperation.h
//  NoteBook
//
//  Created by zx_06 on 15/4/29.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "Database.h"
#import "NoteBook.h"

#define TABLE_NAME_NOTEBOOK @"NOTEBOOK"


@interface DatabaseOperation : Database

+ (id)sharedInstance;                                    //单例

// SELECT
- (NSMutableArray *) findByCriteria:(NSString *)criteria;//按条件查找
- (NoteBook *) findFirstByCriteria:(NSString *)criteria; //查找第一个
- (NSInteger) countByCriteria:(NSString *)criteria;      //计数，满足条件的个数

// INSERT
- (void) saveNoteBook:(NoteBook *)noteBook;              //保存，插入
//- (void) saveNoteBooks:(NSArray *)noteBooks;           //保存多个数据，对于多参数数据存数不对，需要调整

// UPDATE
- (BOOL) updateAtIndex:(NSInteger)index withNoteBook:(NoteBook *)noteBook;//更新

// DELETE
- (BOOL) deleteAtIndex:(int)index;                       //删除

@end
