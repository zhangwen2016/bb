
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
    
    cell.live_coverButton.tag = 20 + indexPath.row;
    [cell.live_coverButton addTarget:self action:@selector(live_coverButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    if (_dataArray.count != 0) {
        [_collectionView reloadData];
        
        CGRect newFrame = _collectionView.frame;
        
        if (dataArray.count % 2 == 0) {
            
            newFrame.size.height = (dataArray.count/2 * 150 ) + ((dataArray.count/2 - 1) * 20);
            
        }
        
        if (dataArray.count % 2 == 1) {
            
            newFrame.size.height = (dataArray.count/2 * 150 ) + ((dataArray.count/2 - 1) * 20) + 170;
        
        }

        _collectionView.frame = newFrame;
        
    }
    
}

// 点击item的方法
- (void)live_coverButtonAction:(UIButton *)sender
{
    BMDsLiveAndPreviewModel *model = _dataArray[sender.tag - 20];
    if (_delegate && [_delegate respondsToSelector:@selector(popupTimeViewWithModel:)]) {
        [_delegate popupTimeViewWithModel:model];
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
