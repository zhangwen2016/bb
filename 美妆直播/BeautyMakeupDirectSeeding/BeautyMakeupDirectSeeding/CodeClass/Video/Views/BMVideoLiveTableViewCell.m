//
//  BMVideoLiveTableViewCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMVideoLiveTableViewCell.h"
#import "BMSearchLiveCollectionViewCell.h"
#import "BMVideoShowViewController.h"
#import "BMSearchViewController.h"
@implementation BMVideoLiveTableViewCell

- (void)setLiveArray:(NSArray *)liveArray{
//    self.contentView.backgroundColor = [UIColor orangeColor];
    _liveArray = liveArray;
    [self loadLiveCollectionView];
}


#pragma mark --- 实现直播分区的collectionView的初始化
- (void)loadLiveCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / 2 - 10, 150);
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 10);
    CGFloat height = 0;
    if (_liveArray.count % 2 == 1) {
        height = (_liveArray.count + 1) / 2 * 150 + 20;
    }else{
        height = _liveArray.count / 2 * 150 + 20;;
    }

 
    _liveCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height) collectionViewLayout:layout];
    _liveCollectionView.delegate = self;
    _liveCollectionView.dataSource = self;
    _liveCollectionView.backgroundColor = [UIColor whiteColor];
    _liveCollectionView.scrollEnabled = NO;
    [_liveCollectionView registerClass:[BMSearchLiveCollectionViewCell class] forCellWithReuseIdentifier:@"BMSearchLiveCollectionViewCell"];
    [self.contentView addSubview:_liveCollectionView];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _liveArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BMSearchLiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BMSearchLiveCollectionViewCell" forIndexPath:indexPath];
    BMSearchTeacherModel *model = _liveArray[indexPath.row];
    cell.teacherModel = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
    
    BMSearchTeacherModel *model = _liveArray[indexPath.row];
   
    if ([_currentVC isMemberOfClass:[BMSearchViewController class]]) {
        BMVideoShowViewController *showVC =[[BMVideoShowViewController alloc] init];
        
        
        showVC.live_id = model.live_id;
        NSLog(@"%@", model.start_time);
        long long int date1 = (long long int)[@1453289400 intValue];
        
        NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM:DD:HH:mm"];
        NSString *str = [formatter stringFromDate:date2];
        
        
        
        BMSearchViewController *searchVC = (BMSearchViewController *)_currentVC;
        searchVC.searchController.searchBar.hidden = YES;
        [_currentVC.navigationController pushViewController:showVC animated:YES];
    }else if ([_currentVC isMemberOfClass:[BMVideoShowViewController class]]){
        BMVideoShowViewController *showVC = (BMVideoShowViewController *)_currentVC;
        showVC.source_id = model.live_id;
    
        [showVC reloadData];
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
