//
//  ViewController.h
//  NoteBook
//
//  Created by zx_06 on 15/4/28.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSInteger dataCount;
    NSArray *dataArray;
}
@property (nonatomic,strong)UICollectionView *collectionView;
@end

