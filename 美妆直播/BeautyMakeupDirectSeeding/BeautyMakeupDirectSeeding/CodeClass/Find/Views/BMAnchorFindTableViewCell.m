//
//  BMAnchorFindTableViewCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMAnchorFindTableViewCell.h"
#import "BMAnchorFindCollectionViewCell.h"

@interface BMAnchorFindTableViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate>



@end

@implementation BMAnchorFindTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview];
    }
    return self;
}

- (void)addSubview
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((kScreenWidth - 10 * 2 - 10 * 2) / 3, (kScreenWidth - 10 * 2 - 10 * 2) / 3);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    _collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ((kScreenWidth - 10 * 2 - 10 * 2) / 3 * _index / 3 + 10 * (_index / 3 + 1))) collectionViewLayout:flowLayout];
    _collectionV.backgroundColor = [UIColor whiteColor];
    //  隐藏滑动栏
    _collectionV.showsVerticalScrollIndicator = NO;
    //  禁止滑动
    _collectionV.scrollEnabled = NO;
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    
    [self.contentView addSubview:_collectionV];
    [_collectionV registerClass:[BMAnchorFindCollectionViewCell class] forCellWithReuseIdentifier:@"BMAnchorFindCollectionViewCell"];
    
}

- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;

    //  记得改变frame
    _collectionV.frame = CGRectMake(0, 0, kScreenWidth, ((kScreenWidth - 10 * 2 - 10 * 2) / 3 * _index / 3 + 10 * (_index / 3 + 1)));
}


#pragma mark  实现collectionV的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BMAnchorFindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BMAnchorFindCollectionViewCell" forIndexPath:indexPath];
    cell.model = _dataArr[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BMAnchorFindModel *model = _dataArr[indexPath.row];
    if ([_delegate respondsToSelector:@selector(anchorFindTableViewCellWithModel:)]) {
        [_delegate anchorFindTableViewCellWithModel:model];
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
