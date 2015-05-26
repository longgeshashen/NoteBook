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
@property (nonatomic,strong)UITextField *styleField;
@property (nonatomic,strong)UITextView *contentTextView;

@end

@implementation AddNBViewController
@synthesize editNBTableView,nameField,timeField,styleField,contentTextView;
@synthesize pickerView;

- (void)viewDidLoad {
    /*
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
     //    debugLog(@"%d",delete);*/
    [super viewDidLoad];
    //
    self.title = @"NEW";
    editNBTableView.delegate = self;
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(comlpleteEdit)];
    self.navigationItem.rightBarButtonItem = rightBarButton;

}
#pragma mark - 完成
- (void)comlpleteEdit{
    
    if ([nameField.text length] ==0||[timeField.text length]==0||[contentTextView.text length]==0||[styleField.text length]==0) {
        UIAlertView *alertNil = [[UIAlertView alloc] initWithTitle:@"创建失败"
                                                           message:@"请将信息补充完整"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
        [alertNil show];
        return;
    }
    
    //初始化notebook
    NoteBook *notebook = [[NoteBook alloc] init];
    notebook.noteName = nameField.text;
    notebook.noteTime = timeField.text;
    notebook.noteStyle = styleField.text;
    notebook.noteContent = contentTextView.text;
    notebook.noteId = -1;//noteId = -1表示保存，noteID>0表示更新对应数据
    
    //保存
    DatabaseOperation *op = [DatabaseOperation sharedInstance];
    [op saveNoteBook:notebook];
    
    //返回首页
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 列表方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==3) {
        return 240.0f;
    }
    return 60.0f;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *Identifier = @"noteBookCell";
    UITableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (Cell == nil) {
        Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        switch (indexPath.row) {
            case 0:
                
            {
                UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 15, 80, 30)];
                nameLabel.text = @"名字：";
                [Cell.contentView addSubview:nameLabel];
                
                nameField = [[UITextField alloc] initWithFrame:CGRectMake(80, 15, 220, 30)];
                nameField.borderStyle = UITextBorderStyleRoundedRect;
                nameField.returnKeyType = UIReturnKeyDone;
                nameField.delegate = self;
                [Cell.contentView addSubview:nameField];
            }
                break;
            case 1:
            {
                UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 15, 80, 30)];
                timeLabel.text = @"时间：";
                [Cell.contentView addSubview:timeLabel];
                
                timeField = [[UITextField alloc] initWithFrame:CGRectMake(80, 15, 220, 30)];
                timeField.borderStyle = UITextBorderStyleRoundedRect;
                timeField.returnKeyType = UIReturnKeyDone;
                timeField.userInteractionEnabled = NO;
                timeField.delegate = self;
                Cell.tag = 100;
                [Cell.contentView addSubview:timeField];
            }
                break;
            case 2:
            {
                UILabel *stykeLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 15, 80, 30)];
                stykeLabel.text = @"分类：";
                [Cell.contentView addSubview:stykeLabel];
                
                styleField = [[UITextField alloc] initWithFrame:CGRectMake(80, 15, 220, 30)];
                styleField.borderStyle = UITextBorderStyleRoundedRect;
                styleField.returnKeyType = UIReturnKeyDone;
                styleField.delegate = self;
                styleField.userInteractionEnabled = NO;
                Cell.tag = 100;
                [Cell.contentView addSubview:styleField];
            }
                break;
            case 3:
            {
                UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, 80, 30)];
                contentLabel.text = @"内容：";
                [Cell.contentView addSubview:contentLabel];
                
                contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(25, 45, kWidth-20*2, 190)];
                contentTextView.backgroundColor = [UIColor lightGrayColor];
                contentTextView.layer.borderColor = [[UIColor colorWithRed:150.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0]CGColor];
                contentTextView.layer.cornerRadius = 5.0;
                contentTextView.layer.borderWidth = 1.5;
                contentTextView.font = [UIFont systemFontOfSize:15];
                contentTextView.returnKeyType = UIReturnKeyDone;
                contentTextView.delegate = self;
                [Cell.contentView addSubview:contentTextView];
            }
                break;
            default:
                break;
        }
    }
    Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return Cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1||indexPath.row==2) {
        [nameField resignFirstResponder];
        [contentTextView resignFirstResponder];
        PickerType type;
        if (indexPath.row==1) {
            type = PickerTypeDate;
        }else if (indexPath.row==2){
            type = PickerTypeStyle;
        }
        if (pickerView) {
            [pickerView removeFromSuperview];
        }
        pickerView = [[SSLPickerView alloc] initWithType:type delegate:self];
        [pickerView showInView:self.view];
    }
    
}

#pragma mark - UITextField方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (pickerView) {
        [pickerView removeFromSuperview];
    }
    return YES;
}

#pragma mark - UITextView方法
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (pickerView) {
        [pickerView removeFromSuperview];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
#pragma mark - LocatePicker delegate
-(void)selectByType:(PickerType)type andTitle:(NSString *)title
{
    switch (type)
    {
        case PickerTypeDate:
            ;
            timeField.text = title;
            break;
        case PickerTypeStyle:
            styleField.text = title;
        default:
            break;
    }
}

-(void)finishSelect:(PickerType)type
{
    if ((type!=PickerTypeSex)&& !DEVICE_IS_IPHONE5)
    {
        CGRect frame = editNBTableView.frame;
        frame.origin.y = 0;
        [UIView animateWithDuration:0.3
                         animations:^{
                             editNBTableView.frame = frame;
                         }];
    }
}

@end
