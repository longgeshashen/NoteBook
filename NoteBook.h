//
//  NoteBook.h
//  NoteBook
//
//  Created by zx_06 on 15/5/26.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteBook : NSObject
@property (nonatomic,retain) NSString *noteName;
@property (nonatomic,retain) NSString *noteTime;
@property (nonatomic,retain) NSString *noteStyle;
@property (nonatomic,retain) NSString *noteContent;
@property (nonatomic) NSInteger noteId;

@end
