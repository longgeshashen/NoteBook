//
//  ViewController.h
//  NoteBook
//
//  Created by zx_06 on 15/4/28.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate>
{
    NSMutableArray *dataArray; //数据数组，可变，方便增删
}
@property (nonatomic,strong)UICollectionView *collectionView;   //列表
@property (nonatomic,strong)UIGestureRecognizer *longP;         //转存手势
@end

