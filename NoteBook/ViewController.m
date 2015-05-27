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
#import "NoteDetialViewController.h"


@interface ViewController ()<MJRefreshBaseViewDelegate>

@end

@implementation ViewController
@synthesize longP;
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, topBarheight, kWidth, kHeight-topBarheight) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor brownColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    //注册cell
    [self.collectionView registerClass:[NoteBookCell class] forCellWithReuseIdentifier:@"noteCell"];
    [self.view addSubview:self.collectionView];
}
#pragma mark - 更新数据
- (void)updatedata{
    
    //数据库查询数据
    DatabaseOperation *op = [DatabaseOperation sharedInstance];
    
    dataArray = [op findByCriteria:nil];

    [self.collectionView reloadData];
   
}
- (void)viewWillAppear:(BOOL)animated{
    
    [self updatedata];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [dataArray count];
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取数组里的数据
    NoteBook *notebook = [dataArray objectAtIndex:indexPath.row];

    static NSString *Identifier = @"noteCell";
    NoteBookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    
    //自定义cell赋值
    cell.cellNotebook = notebook;
    cell.nameLabel.text = notebook.noteName;
    cell.timeLabel.text = notebook.noteTime;
    cell.styleLabel.text = notebook.noteStyle;
    cell.contentLabel.text = [notebook.noteContent length]>28?[NSString stringWithFormat:@"%@...", [notebook.noteContent substringToIndex:28]]:notebook.noteContent;
    
    //长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(handleLongPress:)];
    cell.tag = indexPath.row;
    longPress.delegate = self;
    longPress.minimumPressDuration = 1.0;
    [cell addGestureRecognizer:longPress];
    
    return cell;
}
#pragma mark - 流线布局协议
#pragma mark -- 项的大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize = CGSizeMake(kWidth-20.0f, 150.0f);
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
    
    NoteBook *notebook = [dataArray objectAtIndex:indexPath.row];//获取数组里的数据
 
    [self performSegueWithIdentifier:@"noteBookDetial" sender:notebook];
}
#pragma mark-- 查看详情
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"noteBookDetial"]) {
        
        NoteDetialViewController *noteDetial = segue.destinationViewController;
        
        noteDetial.detialNoteBook = (NoteBook*)sender;
        
    }
}
#pragma mark - 长按手势
- (void)handleLongPress:(UILongPressGestureRecognizer*)longPress{
    
    longP = longPress;
    
    if (longPress.state==UIGestureRecognizerStateBegan) {
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"真的要删除了吗😢"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                             destructiveButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        
        sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [sheet showInView:self.view];
        
    }else if (longPress.state==UIGestureRecognizerStateEnded){
        
        return;
        
    }
    
}
#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        
        [self deleteCell:longP];
        
    }else if(buttonIndex==1){
        
        return;
        
    }
}
#pragma mark--删除
- (void)deleteCell:(UIGestureRecognizer*)longPress{

    DatabaseOperation *dbo = [[DatabaseOperation alloc] init];
    if ([dataArray count]>1) {
        
        NoteBookCell *cell = (NoteBookCell*)longPress.view;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        NSMutableArray *temp = [NSMutableArray arrayWithArray:dataArray];
        [temp removeObjectAtIndex:indexPath.row];
        dataArray = temp;
        
        NSArray *deleteItems = @[indexPath];
        [self.collectionView deleteItemsAtIndexPaths:deleteItems];
        
        BOOL delete = [dbo deleteAtIndex:cell.cellNotebook.noteId];
        if (delete) {
            debugLog(@"删除成功");
        }else{
            debugLog(@"删除失败");
        }
    }else{
        
        [dataArray removeAllObjects];
        [dbo cleanTable:TABLE_NAME_NOTEBOOK];
        [self.collectionView reloadData];
    }
    
}


@end
