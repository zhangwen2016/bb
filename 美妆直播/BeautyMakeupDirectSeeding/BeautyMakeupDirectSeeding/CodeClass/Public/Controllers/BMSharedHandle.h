//
//  BMSharedHandle.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMSharedHandle : NSObject
@property (nonatomic, strong) BMSharedHandle *handle;
- (void)autoAdjustHeightLabel:(UILabel *)label labelFontSize:(NSInteger)fontSize;
- (void)autoAdjustWidthLabel:(UILabel *)label labelFontSize:(NSInteger)fontSize;
@end
