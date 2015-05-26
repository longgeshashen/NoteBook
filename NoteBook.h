//
//  NoteBook.h
//  NoteBook
//
//  Created by zx_06 on 15/5/26.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteBook : NSObject
@property (nonatomic,retain) NSString *noteName;   //名字
@property (nonatomic,retain) NSString *noteTime;   //时间
@property (nonatomic,retain) NSString *noteStyle;  //类型
@property (nonatomic,retain) NSString *noteContent;//内容
@property (nonatomic) NSInteger noteId;            //id

@end
