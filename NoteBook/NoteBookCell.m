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

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 200, 30)];
        [self addSubview:nameLabel];
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, 200, 30)];
        [self addSubview:timeLabel];
        styleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 65, 200, 30)];
        [self addSubview:styleLabel];
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 95, 280, 80)];
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
    }
    return self;
}
@end
