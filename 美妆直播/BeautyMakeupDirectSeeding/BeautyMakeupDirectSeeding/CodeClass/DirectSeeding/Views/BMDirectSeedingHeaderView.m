//
//  BMDirectSeedingHeaderView.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMDirectSeedingHeaderView.h"
#import "UIButton+WebCache.h"
#define IMAGEVIEW_TAG 2000
#import "BMDsLiveAndPreviewModel.h"
@interface BMDirectSeedingHeaderView ()<UIScrollViewDelegate>


@end

@implementation BMDirectSeedingHeaderView

// 放进一个图片网址的数组
- (void)setImageUrlArray:(NSMutableArray *)ImageUrlArray
{
    _ImageUrlArray = [NSMutableArray arrayWithArray:ImageUrlArray];
    if (_ImageUrlArray.count != 0) {
        
        [self addSubview];
    }
}

- (void)addSubview
{
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height)];
    bgScrollView.backgroundColor = [UIColor greenColor];
    bgScrollView.contentSize = CGSizeMake(kScreenWidth * (_ImageUrlArray.count + 1), self.frame.size.height);
    bgScrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    bgScrollView.bounces = YES;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.showsVerticalScrollIndicator = NO;
    bgScrollView.alwaysBounceHorizontal = YES;
    bgScrollView.alwaysBounceVertical = NO;
    bgScrollView.pagingEnabled = YES;
    bgScrollView.delegate = self;
    bgScrollView.tag = 99;
    [self addSubview:bgScrollView];
    
    for (int i = 0; i < _ImageUrlArray.count + 1; i++) {
        UIScrollView *smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0 + kScreenWidth * i, 0, kScreenWidth, self.frame.size.height)];
        smallScrollView.minimumZoomScale = 0.5;
        smallScrollView.maximumZoomScale = 2;
        [bgScrollView addSubview:smallScrollView];
        smallScrollView.delegate = self;
        smallScrollView.tag = i + IMAGEVIEW_TAG;
        
        
        UIButton *imageButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        imageButton.frame = CGRectMake(0, 0, kScreenWidth, self.frame.size.height);
        
        imageButton.tag = 200 + i;
        [imageButton addTarget:self action:@selector(imageButton:) forControlEvents:(UIControlEventTouchUpInside)];
        
        if (i == 0) {
            
            NSInteger x = _ImageUrlArray.count - 1;
            
            BMDsLiveAndPreviewModel *model = _ImageUrlArray[x];
            
            [imageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.image_url] forState:(UIControlStateNormal)];
            
        }else{
            NSInteger y = i - 1;
            BMDsLiveAndPreviewModel *model = _ImageUrlArray[y];
            [imageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.image_url] forState:(UIControlStateNormal)];
        }
        
        [smallScrollView addSubview:imageButton];
    }
    
    _pageControl = [[UIPageControl alloc] initWithFrame:(CGRectMake(0, self.frame.size.height - 30, kScreenWidth, 30))];
    _pageControl.numberOfPages = _ImageUrlArray.count;
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor magentaColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    // 添加方法
    [_pageControl addTarget:self action:@selector(changeValue:) forControlEvents:(UIControlEventValueChanged)];
    
    [self addSubview:_pageControl];
    
    [self makeTimer];
}

- (void)imageButton:(UIButton *)sender
{
    if (sender.tag == 200) {
        BMDsLiveAndPreviewModel *model = _ImageUrlArray[_ImageUrlArray.count - 1];
        
        if (_delegate && [_delegate respondsToSelector:@selector(transmitWithID:)]) {
            [_delegate transmitWithID:model.ID];
        }
        return;
        
    }
    
    BMDsLiveAndPreviewModel *model = _ImageUrlArray[sender.tag - 201];
    
    if (_delegate && [_delegate respondsToSelector:@selector(transmitWithID:)]) {
        [_delegate transmitWithID:model.ID];
    }
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //  取出scrollView宽度
    CGFloat width = scrollView.frame.size.width;
    //  取出偏移量
    CGFloat x = scrollView.contentOffset.x / kScreenWidth;
    
    
    if (x < 0) {
        //  说明滑动到第一张假图
        //  需要偏移到最后一张图
        [scrollView setContentOffset:CGPointMake(width * (_ImageUrlArray.count ), 0) animated:NO];
    }
    if (x > _ImageUrlArray.count) {
        //  说明滑动到最后一个图
        //  需要偏移到第一张图
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        
    }
    
}

// 结束减速 完全停止后， 改变pageControl 的page, 必须是手动拖动才会执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 获取偏移量
    CGFloat x = scrollView.contentOffset.x;
    CGFloat width = scrollView.frame.size.width;
    
    NSInteger page = x / width;
    
    if (page == 0) {
        
        _pageControl.currentPage = _ImageUrlArray.count - 1;
        
    } else {
        _pageControl.currentPage = page -  1;
    }
    
}


#pragma mark pageControl 方法
- (void)changeValue:(UIPageControl *)pageControl
{
    UIScrollView *bgScrollView = (UIScrollView *)[self viewWithTag:99];
    
    // 获取当前的 page
    NSInteger currentPage = pageControl.currentPage;
    
    
    CGFloat x = (currentPage + 1 ) * bgScrollView.frame.size.width;
    // 设置偏移量
    [bgScrollView setContentOffset:(CGPointMake(x, 0)) animated:YES];
    
}


//#pragma mark-- 自动轮播
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获取偏移量
    CGFloat x = scrollView.contentOffset.x;
    CGFloat width = scrollView.frame.size.width;
    
    NSInteger page = x / width;
    
    if (page == 0) {
        
        _pageControl.currentPage = _ImageUrlArray.count - 1;
    } else
    {
        _pageControl.currentPage = page - 1;
    }
    
}

// 创建定时器
- (void)makeTimer
{
    _isFirst = YES;
    _timer = [[NSTimer alloc] initWithFireDate:[NSDate distantPast] interval:2 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    
}


//关闭定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}
//开启定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self makeTimer];
}

- (void)timer:(NSTimer *)timer
{
    
    if (_isFirst == NO) {
        
        UIScrollView *bgScrollView = (UIScrollView *)[self viewWithTag:99];
        // 改变contentOffSet
        // 如果需要重新定位 先定位再动画， 否则直接动画
        CGFloat x = bgScrollView.contentOffset.x;
        CGFloat width = bgScrollView.frame.size.width;
        
        if (width + x >= bgScrollView.contentSize.width) {
            
            // 先定位
            [bgScrollView setContentOffset:(CGPointMake(0, 0)) animated:NO];
            // 再动画
            [bgScrollView setContentOffset:(CGPointMake(width, 0)) animated:YES];
            
        } else{
            
            [bgScrollView setContentOffset:(CGPointMake(x + width, 0)) animated:YES];
        }
        
    }else{
        _isFirst = NO;
    }
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
