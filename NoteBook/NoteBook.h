//
//  NoteBook.h
//  NoteBook
//
//  Created by zx_06 on 15/4/29.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteBook : NSObject
@property (nonatomic)NSInteger noteId;
@property (nonatomic,strong) NSString *noteName;    //日记名字
@property (nonatomic,strong) NSString *noteTime;    //日记时间
@property (nonatomic,strong) NSString *noteStyle;   //日记类型
@property (nonatomic,strong) NSString *noteContent; //日记内容

@end
