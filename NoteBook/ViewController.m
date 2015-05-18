//
//  ViewController.m
//  NoteBook
//
//  Created by zx_06 on 15/4/28.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"
#import "DatabaseOperation.h"
#import "NoteBookCell.h"
#import "NoteBook.h"
#import "MJRefresh.h"
@interface ViewController ()<MJRefreshBaseViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.title = @"NoteBook";
    //导航栏背景
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:155/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    //设置标题字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self initCollectionView];
    [self updatedata];

}
#pragma mark - 初始化集合视图
- (void)initCollectionView{
    //加载集合视图
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight-64) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //注册cell
    [self.collectionView registerClass:[NoteBookCell class] forCellWithReuseIdentifier:@"noteCell"];
    
    [self.view addSubview:self.collectionView];
}
#pragma mark - 更新数据
- (void)updatedata{
    //数据
    DatabaseOperation *op = [DatabaseOperation sharedInstance];
    dataArray = [op findByCriteria:nil];
    dataCount = [op countByCriteria:nil];
    [self.collectionView reloadData];
    NSLog(@"数据个数是：%ld",dataCount);
}
- (void)viewWillAppear:(BOOL)animated{
    [self updatedata];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return dataCount;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NoteBook *notebook = [dataArray objectAtIndex:indexPath.section];//获取数组里的数据

    static NSString *Identifier = @"noteCell";
    NoteBookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    //自定义cell赋值
    cell.nameLabel.text = notebook.noteName;
    cell.timeLabel.text = notebook.noteTime;
    cell.contentLabel.text = notebook.noteContent;
    
    return cell;
}
#pragma mark - 流线布局协议
#pragma mark -- 项的大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize = CGSizeMake(kWidth-20.0f, 130.0f);
    return itemSize;
}
#pragma mark -- 段的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 10, 20, 10);
}

#pragma mark -- 选择某一项
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    debugLog(@"%ld",indexPath.section);
    
}
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([segue.identifier isEqualToString:@"ShowImage"]) {
//        ImageShowViewController *imageShowVC = segue.destinationViewController;
//        imageShowVC.image = (UIImage*)sender;
//    }
//}

@end
