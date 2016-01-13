//
//  BMBeautyMakeTabBarC.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/9.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMBeautyMakeTabBarC.h"
#import "BMDirectSedingMainVC.h"
#import "BMFindMainVC.h"
#import "BMVideoMainVC.h"
@interface BMBeautyMakeTabBarC ()

@end

@implementation BMBeautyMakeTabBarC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor magentaColor];
//    [self addViewControllerClass:[BMDirectSedingMainVC class] title:@"直播" imageName:@"DirectSeeding"];
    [self addViewControllerClass:[BMVideoMainVC class] title:@"视频" imageName:@"video"];
    [self addViewControllerClass:[BMFindMainVC class] title:@"发现" imageName:@"find"];
 //   [self addViewControllerClass:[BMMineMainVC class] title:@"我的" imageName:@"mine"];
    
}

-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

- (void)addViewControllerClass:(Class)class title:(NSString *)title imageName:(NSString *)imageName
{
    UIViewController *viewC = [[class alloc]init];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:viewC];
    navC.tabBarItem.title = title;
    
    UIImage *tempImage = [UIImage imageNamed:imageName];
    UIImage *image = [self OriginImage:tempImage scaleToSize:CGSizeMake(25, 25)];
    
    navC.tabBarItem.image = image;
    [self addChildViewController:navC];
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
