//
//  BMSharedHandle.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMSharedHandle.h"

@implementation BMSharedHandle
+ (BMSharedHandle *)sharedHandle
{
    static BMSharedHandle *handle = nil;
    static dispatch_once_t onceToke;
    dispatch_once(&onceToke, ^{
        if ( handle == nil) {
            handle = [[BMSharedHandle alloc] init];
        }
    });
    return handle;
}

- (void)autoAdjustHeightLabel:(UILabel *)label labelFontSize:(NSInteger)fontSize

{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize], NSFontAttributeName,nil];
    CGRect frame = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
  //  NSLog(@"%f", frame.size.height);
    CGRect temp = label.frame;
    temp.size.height = frame.size.height;
    label.frame = temp;
}

- (void)autoAdjustWidthLabel:(UILabel *)label labelFontSize:(NSInteger)fontSize
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize], NSFontAttributeName,nil];
    
    CGRect frame = [label.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, label.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
   // NSLog(@"%f", frame.size.width);
    CGRect temp = label.frame;
    temp.size.width = frame.size.width;
    label.frame = temp;
}
@end
