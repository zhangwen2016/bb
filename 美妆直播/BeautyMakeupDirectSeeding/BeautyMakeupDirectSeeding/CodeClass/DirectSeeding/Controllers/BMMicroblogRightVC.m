//
//  BMMicroblogRightVC.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/14.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMMicroblogRightVC.h"
#import "BMMicroblogCollectionCell.h"

@interface BMMicroblogRightVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>



@end

@implementation BMMicroblogRightVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addCollectionView];
    
}


// 创建视图
- (void)addCollectionView
{
    // 创建一个网状结构
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 行间距
    layout.minimumLineSpacing = 10;
    
    // 列间距
    layout.minimumInteritemSpacing = 10;
    
    // 分区内边距 分区上下左右的缩进距离 （内边距）
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    // 滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // item大小
    layout.itemSize = CGSizeMake(kScreenWidth/3 - 14, kScreenWidth/3 - 14);
    
      // 创建
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    // 设置代理
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_collectionView];
    
    
    
    // 注册cell
    [_collectionView registerClass:[BMMicroblogCollectionCell class] forCellWithReuseIdentifier:@"MyCell"];
    
   
    
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = [NSArray arrayWithArray:dataArray];
    if (_dataArray != nil) {
        [_collectionView reloadData];

    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BMMicroblogCollectionCell *girlCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    
    // 取出对应的model
    girlCell.model = _dataArray[indexPath.row];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [girlCell addGestureRecognizer:tap];
    
    return girlCell;
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    NSLog(@"haha");
}


//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    NSLog(@"haha");
//    
//}


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
