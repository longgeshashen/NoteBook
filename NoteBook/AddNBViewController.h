//
//  AddNBViewController.h
//  NoteBook
//
//  Created by zx_06 on 15/4/28.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNBViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *editNBTableView;



@end
