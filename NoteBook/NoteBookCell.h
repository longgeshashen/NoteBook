//
//  NoteBookCell.h
//  NoteBook
//
//  Created by zx_06 on 15/4/30.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//  显示列表cell

#import <UIKit/UIKit.h>
#import "NoteBook.h"
@interface NoteBookCell : UICollectionViewCell

@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *styleLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)NoteBook *cellNotebook;
@end
