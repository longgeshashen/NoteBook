//
//  NoteDetialViewController.m
//  NoteBook
//
//  Created by zx_06 on 15/5/26.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "NoteDetialViewController.h"

@interface NoteDetialViewController ()

@end

@implementation NoteDetialViewController
@synthesize detialContent,detialName,detialTime,detialType;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDetialLabels];
}
- (void)initDetialLabels{
    //名字
    NSDictionary *attributesName = @{NSForegroundColorAttributeName:[UIColor greenColor],
                                  NSFontAttributeName:[UIFont fontWithName:@"Zapfino" size:18.0]};
    NSAttributedString *attributedTextName = [[NSAttributedString alloc] initWithString:self.detialNoteBook.noteName attributes:attributesName];
    detialName.attributedText = attributedTextName;
    
    //类型
    NSDictionary *attributeStyle = @{NSForegroundColorAttributeName:[UIColor redColor],
                                     NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:14.0]};
    NSAttributedString *attributeTextStyle = [[NSAttributedString alloc] initWithString:self.detialNoteBook.noteStyle attributes:attributeStyle];
    detialType.attributedText = attributeTextStyle;
    
    //时间
    NSDictionary *attributeTime = @{NSForegroundColorAttributeName:[UIColor redColor],
                                     NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:14.0]};
    NSAttributedString *attributeTextTime = [[NSAttributedString alloc] initWithString:self.detialNoteBook.noteTime attributes:attributeTime];
    detialTime.attributedText = attributeTextTime;
    
    //内容
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentJustified;
    paragraph.firstLineHeadIndent = 20.0;
    paragraph.paragraphSpacingBefore = 10.0;
    paragraph.lineSpacing = 10;
    paragraph.hyphenationFactor = 5.0;
    
    NSDictionary *attributeNoteContent = @{NSForegroundColorAttributeName:[UIColor blackColor],
                                           NSBackgroundColorAttributeName:[UIColor magentaColor],
                                           NSParagraphStyleAttributeName:paragraph,
                                           NSFontAttributeName:[UIFont fontWithName:@"TrebuchetMS-Bold" size:13.0]
                                           };
    
    NSAttributedString *attributeText = [[NSAttributedString alloc] initWithString:self.detialNoteBook.noteContent attributes:attributeNoteContent];
    detialContent.attributedText = attributeText;
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

@end
