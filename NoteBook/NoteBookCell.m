//
//  NoteBookCell.m
//  NoteBook
//
//  Created by zx_06 on 15/4/30.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "NoteBookCell.h"

@implementation NoteBookCell
@synthesize nameLabel;
@synthesize timeLabel;
@synthesize styleLabel;
@synthesize contentLabel;
@synthesize cellNotebook;
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.layer.cornerRadius = 5.0;
        self.layer.borderWidth = 1.5;
        self.layer.borderColor = [[UIColor colorWithRed:150.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0]CGColor];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 200, 30)];
        nameLabel.textColor = [UIColor greenColor];
        [self addSubview:nameLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, 200, 30)];
        timeLabel.textColor = [UIColor whiteColor];
        [self addSubview:timeLabel];
        
        styleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 65, 200, 30)];
        styleLabel.textColor = [UIColor whiteColor];
        [self addSubview:styleLabel];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 80)];
        contentLabel.textColor = [UIColor purpleColor];
        contentLabel.numberOfLines = 0;
        
        [self addSubview:contentLabel];
    }
    return self;
}

@end
