//
//  BMCommonMethod.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMCommonMethod.h"

@implementation BMCommonMethod
+ (void)autoAdjustHeightLabel:(UILabel *)label labelFontSize:(NSInteger)fontSize

{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize], NSFontAttributeName,nil];
    
    CGRect frame = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
  //  NSLog(@"%f", frame.size.height);
    CGRect temp = label.frame;
    temp.size.height = frame.size.height;
    label.frame = temp;
}


+ (void)autoAdjustLeftWidthLabel:(UILabel *)label labelFontSize:(NSInteger)fontSize
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize], NSFontAttributeName,nil];
    
    CGRect frame = [label.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, label.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
  //  NSLog(@"%f", frame.size.width);
    CGRect temp = label.frame;
    temp.size.width = frame.size.width;
    label.frame = temp;
}

// 靠右对其留10个间距
+ (void)autoAdjustRightWidthLabel:(UILabel *)label labelFontSize:(NSInteger)fontSize{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize], NSFontAttributeName,nil];
    
    CGRect frame = [label.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, label.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    label.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - frame.size.width - 10, label.frame.origin.y, frame.size.width, label.frame.size.height);
}
// 无网络
+ (void)NoNetWorkInVC:(UIViewController *)VC{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 70)];
    imageView.image = [UIImage imageNamed:@"NoNet.png"];
    [VC.view addSubview:imageView];
}
@end
