//
//  BMCommentListModel.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMCommentListModel.h"

@implementation BMCommentListModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (void)setParent_comment:(NSDictionary *)parent_comment{
    [_parentModel setValuesForKeysWithDictionary:parent_comment];
}





@end
