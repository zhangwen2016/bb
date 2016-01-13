//
//  BMRequestManager.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+WebCache.h"
#import "UIImage+MultiFormat.h"
#import "UIButton+WebCache.h"

typedef void(^Finish) (NSData *data);
typedef void(^Erro) (NSError *erro);

typedef NS_ENUM(NSInteger, RequsetType)  {
    POST,
    GET
};


@interface BMRequestManager : NSObject

//  给一个字典做HTTP的body
+ (void)requsetWithUrlString:(NSString *)urlString
                      parDic:(NSDictionary *)parDic
                      Method:(RequsetType)method
                      finish:(Finish)finish
                        erro:(Erro)erro;

//  给一个String做HTTP的body
+ (void)requsetWithUrlString:(NSString *)urlString
                 httpBodyStr:(NSString *)httpBodyStr
                      Method:(RequsetType)method
                      finish:(Finish)finish
                        erro:(Erro)erro;

//  异步加载图片
+ (void)downLoadImageView:(UIImageView *)imageView
                UrlString:(NSString *)urlStr;


//  异步加载图片
+ (void)downLoadButton:(UIButton *)button
             UrlString:(NSString *)urlStr;

@end
