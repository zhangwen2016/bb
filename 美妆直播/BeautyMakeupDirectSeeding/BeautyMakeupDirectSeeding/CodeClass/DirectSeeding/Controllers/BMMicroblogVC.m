//
//  BMMicroblogVC.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMMicroblogVC.h"
#import "BMMicroblogSectionHeaderView.h"
#import "UINavigationBar+Awesome.h"

#define NAVBAR_CHANGE_POINT (-190)


@interface BMMicroblogVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) BMMicroblogSectionHeaderView *headerView;


@end

@implementation BMMicroblogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"all_topback@2x"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftButtonAction:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightButtonAction:)];
    self.navigationItem.rightBarButtonItem = rightButton;
//    self.navigationController.navigationBar.translucent = YES;
    
    self.navigationItem.title = @"美甲师";
    
    [self addTableView];
    
}

- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight + 64) style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    
    
//    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -220, kScreenWidth, 240)];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, _imageView.width, 120)];
//    view.tag = 20;
//    view.backgroundColor = [UIColor yellowColor];
//    [_imageView addSubview:view];
//
//    _imageView.backgroundColor = [UIColor redColor];
//    
//    [_tableView addSubview:_imageView];
//
//    UIView *twoView = [[UIView alloc] initWithFrame:CGRectMake(25, 100, 50, 50)];
//    twoView.backgroundColor = [UIColor greenColor];
//    
//    
//    [_imageView addSubview:twoView];
    
    
    
//    view.autoresizesSubviews = YES;
//    twoView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
//    _imageView.image = [UIImage imageNamed:@"zbar-samples"];
    
    
    _headerView = [[BMMicroblogSectionHeaderView alloc] initWithFrame:CGRectMake(0, -240, kScreenWidth, 240)];
    
    _headerView.backgroundColor = [UIColor redColor];
    
    [_tableView addSubview:_headerView];
    
    _tableView.contentInset =UIEdgeInsetsMake(240,0, 0,0);

    [self.view addSubview:_tableView];
    
    
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    
    UIColor * color = [UIColor magentaColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
    
    
    CGFloat yOffset  = scrollView.contentOffset.y;
    
    

    CGRect f = _headerView.background_imageView.frame;
// 当偏移量<图片的高度
    if (yOffset < -240) {
       
        CGFloat s = f.size.height + yOffset + 64;
        
        // 改变frame
        f.origin.y = f.origin.y + s;
        f.size.height =  f.size.height - s;
        
        f.origin.x =  f.origin.x + s/2;
        f.size.width = f.size.width - s;
        
        if (f.size.width < kScreenWidth) {
            f.origin.x =  f.origin.x - s/2;
            f.size.width = f.size.width + s;
        }
        _headerView.visualEffv.frame = f;
        _headerView.background_imageView.frame = f;
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    _imageView.frame =CGRectMake(0, -240,self.tableView.frame.size.width,240);
    
    [super viewWillAppear:YES];
    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}

#pragma mark UITableViewDatasource

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"header";
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = @"text";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}



#pragma mark ---- 分享按钮
- (void)rightButtonAction:(UIBarButtonItem *)rightButton
{
    
}

#pragma mark ---- 返回按钮

- (void)leftButtonAction:(UIBarButtonItem *)leftButton
{
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
    
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
