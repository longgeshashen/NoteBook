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

@property (nonatomic,strong)UILabel *nameLabel;    //名字
@property (nonatomic,strong)UILabel *timeLabel;    //时间
@property (nonatomic,strong)UILabel *styleLabel;   //类型
@property (nonatomic,strong)UILabel *contentLabel; //内容
@property (nonatomic,strong)NoteBook *cellNotebook;//转存notebook

@end
