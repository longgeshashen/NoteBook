//
//  AddNBViewController.h
//  NoteBook
//
//  Created by zx_06 on 15/4/28.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSLPickerView.h"

@interface AddNBViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,SSLPickerViewDelegate>
@property (strong, nonatomic) SSLPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UITableView *editNBTableView;


@end
