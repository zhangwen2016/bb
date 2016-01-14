//
//  BMRequestManager.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMRequestManager.h"



@implementation BMRequestManager

+ (void)requsetWithUrlString:(NSString *)urlString
                      parDic:(NSDictionary *)parDic
                      Method:(RequsetType)method
                      finish:(Finish)finish
                        erro:(Erro)erro
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if (method == POST) {
        [request setHTTPMethod:@"POST"];
        if (parDic.count != 0) {
            NSMutableArray *strArr = [NSMutableArray array];
            for (NSString *key in parDic) {
                NSString *str = [NSString stringWithFormat:@"%@=%@", key, parDic[key]];
                [strArr addObject:str];
            }
            NSString *parString = [strArr componentsJoinedByString:@"&"];
            [request setHTTPBody:[parString dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
    }
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError == nil) {
           // NSLog(@"请求成功");
            finish(data);
        }else{
            NSLog(@"请求失败");
            erro(connectionError);
        }
    }];
}


//  给一个String做HTTP的body
+ (void)requsetWithUrlString:(NSString *)urlString
                 httpBodyStr:(NSString *)httpBodyStr
                      Method:(RequsetType)method
                      finish:(Finish)finish
                        erro:(Erro)erro
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if (method == POST) {
        [request setHTTPMethod:@"POST"];
        if (httpBodyStr.length != 0) {
            [request setHTTPBody:[httpBodyStr dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError == nil) {
            NSLog(@"请求成功");
            finish(data);
        }else{
            NSLog(@"请求失败");
            erro(connectionError);
        }
    }];
}


//  异步加载图片
+ (void)downLoadImageView:(UIImageView *)imageView
                UrlString:(NSString *)urlStr
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"PlaceHoldingImage" ofType:@"png"];
    [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr]placeholderImage:[UIImage imageWithContentsOfFile:path]];
}

//  异步加载图片
+ (void)downLoadButton:(UIButton *)button
             UrlString:(NSString *)urlStr
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"PlaceHoldingImage" ofType:@"png"];
    [button sd_setBackgroundImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal placeholderImage:[UIImage imageWithContentsOfFile:path]];
}


@end
