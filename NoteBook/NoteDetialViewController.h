//
//  NoteDetialViewController.h
//  NoteBook
//
//  Created by zx_06 on 15/5/26.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteBook.h"
@interface NoteDetialViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel    *detialName;    //详情名字
@property (weak, nonatomic) IBOutlet UILabel    *detialType;    //详情类型
@property (weak, nonatomic) IBOutlet UILabel    *detialTime;    //详情时间
@property (weak, nonatomic) IBOutlet UITextView *detialContent; //详情内容
@property (retain, nonatomic) NoteBook          *detialNoteBook;//转存notebook

- (void)initDetialLabels;

@end
