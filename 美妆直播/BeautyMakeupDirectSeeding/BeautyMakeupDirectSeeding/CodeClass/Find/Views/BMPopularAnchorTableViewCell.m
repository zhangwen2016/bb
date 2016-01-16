//
//  BMPopularAnchorTableViewCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMPopularAnchorTableViewCell.h"
#import "BMAnchorPopularAnchorCollectionViewCell.h"

@interface BMPopularAnchorTableViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionV;

@end

@implementation BMPopularAnchorTableViewCell

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
    flowLayout.itemSize = CGSizeMake(100, 130);
    flowLayout.minimumLineSpacing = 20;
    flowLayout.minimumInteritemSpacing = 20;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 20, 20);
    
    _collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth, 150) collectionViewLayout:flowLayout];
    _collectionV.backgroundColor = [UIColor whiteColor];
    //  隐藏滑动栏
    _collectionV.showsHorizontalScrollIndicator = NO;
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    
    [self.contentView addSubview:_collectionV];
    [_collectionV registerClass:[BMAnchorPopularAnchorCollectionViewCell class] forCellWithReuseIdentifier:@"BMAnchorPopularAnchorCollectionViewCell"];
    
    
    _applyAnchor = [UIButton buttonWithType:UIButtonTypeCustom];
    _applyAnchor.frame = CGRectMake(0.25 * kScreenWidth, _collectionV.bottom, 0.5 * kScreenWidth, 30);
    
    NSString *applyPath = [[NSBundle mainBundle] pathForResource:@"applyAnchor" ofType:@"png"];
    [_applyAnchor setBackgroundImage:[UIImage imageWithContentsOfFile:applyPath] forState:UIControlStateNormal];

  //  [_applyAnchor addTarget:self action:@selector(applyTobeAnchorAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_applyAnchor];
    
}


#pragma mark  实现collectionV的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BMAnchorPopularAnchorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BMAnchorPopularAnchorCollectionViewCell" forIndexPath:indexPath];
    cell.model = _dataArr[indexPath.row];
    cell.avatarBtn.tag = indexPath.row + 10200;
    [cell.avatarBtn addTarget:self action:@selector(didSelectAvBtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark  点击了我想当主播 所触发的方法
- (void)didSelectAvBtn:(UIButton *)sender
{
    BMAnchorRecommendModel *model = _dataArr[sender.tag - 10200];
    
    if (_delegate != nil && [_delegate respondsToSelector:@selector(popularAnchorTableViewCellBringModel:)]) {
        [_delegate popularAnchorTableViewCellBringModel:model];
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
