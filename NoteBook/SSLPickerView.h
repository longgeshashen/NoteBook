//
//  SSLPickerView.h
//  NoteBook
//
//  Created by zx_06 on 15/5/22.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PickerTypeNormal = 0, //通用
    PickerTypeDate,       //日期
    PickerTypeSex,        //性别
    PickerTypeStyle       //类型
}PickerType;

//代理
@protocol SSLPickerViewDelegate <NSObject>

- (void)selectByType:(PickerType)type andTitle:(NSString *)title;
- (void)finishSelect:(PickerType)type;

@end

@interface SSLPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
{
    PickerType type;
    int currentIndex;
    NSArray *styleArray;
    
}
@property (weak, nonatomic) id<SSLPickerViewDelegate>parent;
@property (weak, nonatomic) IBOutlet UIPickerView *sslPickerView;
@property (weak, nonatomic) IBOutlet UIView *selectView;          //取消、完成示图
@property (copy, nonatomic) NSString *dateString;                 //日期字段
@property (copy, nonatomic) NSString *styleString;                //类型字段
@property (copy, nonatomic) NSString *sexString;                  //性别字段

//方法
- (IBAction)cancelButton:(id)sender;
- (IBAction)selectDone:(id)sender;

- (id)initWithType:(PickerType)pickerType delegate:(id<SSLPickerViewDelegate>)delegate;
- (void)showInView:(UIView*)view;
- (void)closePickerView;


@end
