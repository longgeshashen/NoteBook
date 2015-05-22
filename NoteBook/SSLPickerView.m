//
//  SSLPickerView.m
//  NoteBook
//
//  Created by zx_06 on 15/5/22.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#define kDuration 0.3
#import "SSLPickerView.h"
#import <QuartzCore/CALayer.h>

@implementation SSLPickerView
@synthesize parent;
@synthesize dateString,sexString,styleString;
@synthesize sslPickerView;
@synthesize selectView;

- (id)initWithType:(PickerType)pickerType delegate:(id<SSLPickerViewDelegate>)delegate{
    self = [[[NSBundle mainBundle]loadNibNamed:@"SSLPickerView" owner:self options:nil] objectAtIndex:0];
    if (self) {
        parent = delegate;
        self.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:241.0/255.0 alpha:1.0];
        sslPickerView.delegate = self;
        sslPickerView.dataSource = self;
        
        //取消、完成示图
        CGRect frame = selectView.frame;
        frame.size.width = kWidth;
        selectView.frame = frame;
        selectView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        selectView.layer.borderWidth = 0.5f;
        
        //button
        UIButton *finishButton = (UIButton*)[selectView viewWithTag:6];
        if (finishButton) {
            frame = finishButton.frame;
            frame.origin.x = frame.origin.x/320*kWidth;
            finishButton.frame = frame;
        }
        UIButton *cancelButton = (UIButton*)[selectView viewWithTag:5];
        if (cancelButton) {
            frame = cancelButton.frame;
            frame.origin.x = frame.origin.x/320*kWidth;
            cancelButton.frame = frame;
        }
        //
        type = pickerType;
        switch (type) {
            case PickerTypeDate:
            {
                [sslPickerView removeFromSuperview];
                UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 75, kWidth, 205)];
                datePicker.datePickerMode = UIDatePickerModeDate;
                datePicker.maximumDate = [NSDate date];
                datePicker.backgroundColor = [UIColor clearColor];
                [datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
                [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
                [self addSubview:datePicker];
                

            }
                break;
            case PickerTypeStyle:
            {
                styleArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PickerStyle" ofType:@"plist"]];
                [sslPickerView selectRow:currentIndex inComponent:0 animated:YES];
                
            }
                break;
                
            default:
                break;
        }
        
    }
    return self;
}
#pragma mark - 日期
- (void)dateChanged:(id)sender{
    UIDatePicker *dateP = (UIDatePicker*)sender;
    [dateP setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSString *theTime = [NSString stringWithFormat:@"%@",[dateP date]];
    [parent selectByType:type andTitle:[theTime substringToIndex:10]];//回调代理
}
- (void)showInView:(UIView *)view
{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"LocatePickerView"];
    
    self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, kWidth, self.frame.size.height);
    [view addSubview:self];
}
#pragma mark - PickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger number = 0;
    if (type==PickerTypeSex) {
        number = 2;
    }else if (type==PickerTypeStyle){
        number = [styleArray count];
    }
    return number;
    
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = @"";
    switch (type) {
        case PickerTypeSex:
        {
            title = (row==0)?@"男":@"女";
        }
            break;
        case PickerTypeStyle:
        {
            title = [styleArray objectAtIndex:row];
        }
            break;
        default:
            break;
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (type) {
        case PickerTypeSex:
            [parent selectByType:type andTitle:(row==0)?@"男":@"女"];
            break;
        case PickerTypeStyle:
            [parent selectByType:type andTitle:[styleArray objectAtIndex:row]];
            break;
            
        default:
            break;
    }
}


#pragma mark - 取消，完成动作
- (IBAction)cancelButton:(id)sender {
    switch (type) {
        case PickerTypeSex:
            [parent selectByType:type andTitle:sexString];
            break;
        case PickerTypeDate:
            [parent selectByType:type andTitle:dateString];
            break;
        case PickerTypeStyle:
            [parent selectByType:type andTitle:styleString];
            break;
            
        default:
            break;
    }
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"sslPickerView"];
    [parent finishSelect:type];
    
}

- (IBAction)selectDone:(id)sender {
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"sslPickerView"];
    [parent finishSelect:type];
}
@end
