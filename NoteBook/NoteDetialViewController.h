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

@property (weak, nonatomic) IBOutlet UILabel *detialName;
@property (weak, nonatomic) IBOutlet UILabel *detialType;
@property (weak, nonatomic) IBOutlet UILabel *detialTime;
//@property (weak, nonatomic) IBOutlet UILabel *detialContent;
@property (weak, nonatomic) IBOutlet UITextView *detialContent;
@property (retain, nonatomic) NoteBook *detialNoteBook;

- (void)initDetialLabels;
@end
