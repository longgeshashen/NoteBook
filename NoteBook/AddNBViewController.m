//
//  AddNBViewController.m
//  NoteBook
//
//  Created by zx_06 on 15/4/28.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "AddNBViewController.h"
#import "NoteBook.h"
#import "DatabaseOperation.h"
@interface AddNBViewController ()

@property (nonatomic,strong)UITextField *nameField;
@property (nonatomic,strong)UITextField *timeField;
@property (nonatomic,strong)UITextView *contentTextView;

@end

@implementation AddNBViewController
@synthesize editNBTableView,nameField,timeField,contentTextView;
- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.title = @"新建";
    editNBTableView.delegate = self;
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(comlpleteEdit)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
//    //查找,设置查找条件
//    DatabaseOperation *dbop = [[DatabaseOperation alloc] init];
//    NSArray *arr = [dbop findByCriteria:@" where noteId = 2"];//where前面要加一个空格，满足SQL格式
//    debugLog(@"%@",arr);
//    //查找第一个数据
//    NoteBook *nb = [dbop findFirstByCriteria:nil];
//    debugLog(@"%@",nb);
    //计数
//    int count = [dbop countByCriteria:nil];
//    debugLog(@"%d",count);
    //删除数据
//    BOOL delete = [dbop deleteAtIndex:2];
//    debugLog(@"%d",delete);
    
}
- (void)comlpleteEdit{
    NSLog(@"\n name:%@\n time:%@\n content:%@",nameField.text,timeField.text,contentTextView.text);
    //初始化notebook
    NoteBook *notebook = [[NoteBook alloc] init];
    notebook.noteName = nameField.text;
    notebook.noteTime = timeField.text;
    notebook.noteContent = contentTextView.text;
    notebook.noteId = -1;
    //保存
    DatabaseOperation *op = [DatabaseOperation sharedInstance];
    [op saveNoteBook:notebook];
    //返回首页
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 列表方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==2) {
        return 150.0f;
    }
    return 50.0f;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"noteBookCell%ld",indexPath.row] forIndexPath:indexPath];
    
    
    switch (indexPath.row) {
        case 0:
        {
            nameField = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 200, 30)];
            nameField.borderStyle = UITextBorderStyleRoundedRect;
            nameField.returnKeyType = UIReturnKeyDone;
            nameField.delegate = self;
            [Cell.contentView addSubview:nameField];
        }
            break;
        case 1:
        {
            timeField = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 200, 30)];
            timeField.borderStyle = UITextBorderStyleRoundedRect;
            timeField.returnKeyType = UIReturnKeyDone;
            timeField.delegate = self;
            [Cell.contentView addSubview:timeField];
        }
            break;
        case 2:
        {
            contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(100, 10, 200, 70)];
            contentTextView.returnKeyType = UIReturnKeyDone;
            contentTextView.delegate = self;
            [Cell.contentView addSubview:contentTextView];
        }
            break;
            
        default:
            break;
    }
    Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return Cell;
}
#pragma mark - UITextField方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - UITextView方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
