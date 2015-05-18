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
@property (nonatomic,strong) NSString *noteName;
@property (nonatomic,strong) NSString *noteTime;
@property (nonatomic,strong) NSString *noteContent;
@end
