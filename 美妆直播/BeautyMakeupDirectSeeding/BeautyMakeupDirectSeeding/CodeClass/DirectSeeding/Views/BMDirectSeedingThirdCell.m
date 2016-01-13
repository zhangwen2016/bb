
//
//  BMDirectSeedingThirdCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMDirectSeedingThirdCell.h"
#import "BMDirectSeedingCollectionCell.h"
@interface BMDirectSeedingThirdCell ()<UICollectionViewDataSource,UICollectionViewDelegate>


@end


@implementation BMDirectSeedingThirdCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 创建网状视图
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        // 行间距
        layout.minimumLineSpacing = 20;
        
        // 列间距
        layout.minimumInteritemSpacing = 10;
        
        // 滚动方法
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        
        //item大小
        layout.itemSize = CGSizeMake(kScreenWidth/2 - 5, 150);
        
        // 创建collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 660) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        _collectionView.alwaysBounceHorizontal = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [self.contentView addSubview:_collectionView];
        
        // 注册Cell
        [_collectionView registerClass:[BMDirectSeedingCollectionCell class] forCellWithReuseIdentifier:@"BMDirectSeedingCollectionCell"];
        
        
    }
    return self;
}

// 设置行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BMDirectSeedingCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BMDirectSeedingCollectionCell" forIndexPath:indexPath];
    
    cell.model = _dataArray[indexPath.row];
    return cell;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    if (_dataArray.count != 0) {
        [_collectionView reloadData];
        
    }
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
