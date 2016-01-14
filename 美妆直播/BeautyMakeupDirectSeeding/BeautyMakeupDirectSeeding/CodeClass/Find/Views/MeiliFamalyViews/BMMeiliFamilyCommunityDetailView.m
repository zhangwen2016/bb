//
//  BMMeiliFamilyCommunityDetailView.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMMeiliFamilyCommunityDetailView.h"
#import "BMMeiiFamilyCommentTableViewCell.h"
#define kCommentApiPart1 @"http://app.meilihuli.com/api/comment/list/count/10/type/3/source_id/"
#define kCommentApiPart2 @"/page/1/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"


@interface BMMeiliFamilyCommunityDetailView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *commentArr;

@end

@implementation BMMeiliFamilyCommunityDetailView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubView];
    }
    return self;
}

- (void)setActivity_id:(NSString *)activity_id
{
    _activity_id = activity_id;
    [self loadData];
}



- (void)loadData
{
    NSString *api = [[kCommentApiPart1 stringByAppendingString:_activity_id] stringByAppendingString:kCommentApiPart2];
    _commentArr = [NSMutableArray array];
    [BMRequestManager requsetWithUrlString:api parDic:nil Method:GET finish:^(NSData *data)  {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArr = dic[@"data"];
        //  解析数据
        for (NSDictionary *subDic in dataArr) {
            BMMeiliFamilyCmtModel *model = [[BMMeiliFamilyCmtModel alloc] init];
            [model setValuesForKeysWithDictionary:subDic];
            [_commentArr addObject:model];
        }
        [self.tableView reloadData];
    } erro:^(NSError *erro) {
        NSLog(@"erro");
    }];
}

- (void)addSubView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, self.width, self.height - 70) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.backgroundColor = [UIColor cyanColor];
    [self addSubview:_tableView];
    
    _tableView.tableHeaderView = [self headerViewForTableView];
    [_tableView registerClass:[BMMeiiFamilyCommentTableViewCell class] forCellReuseIdentifier:@"BMMeiiFamilyCommentTableViewCell"];
}

//  自定义headView
- (UIView *)headerViewForTableView
{
    _headerView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];//  先随意给个frame  后面会改
    _headerView.backgroundColor = [UIColor whiteColor];
    //  标题
    _activity_title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 20)];
    _activity_title.font = [UIFont systemFontOfSize:kLargeFont];
    _activity_title.numberOfLines = -1;
    [_headerView addSubview:_activity_title];
    
    
    //  头像那一行
    _avatarLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _activity_title.bottom + 10, kScreenWidth, 40)];
    [_headerView addSubview:_avatarLineView];
    
    //  头像
    _avatarImgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
    [_avatarLineView addSubview:_avatarImgV];
    
    //  昵称
    _nicknameLable = [[UILabel alloc] initWithFrame:CGRectMake(_avatarImgV.right + 5, 0, 200, 20)];
    _nicknameLable.font = [UIFont systemFontOfSize:kLargeFont];
    _nicknameLable.textAlignment = NSTextAlignmentLeft;
    [_avatarLineView addSubview:_nicknameLable];
    
    //  发布时间
    _add_time = [[UILabel alloc] initWithFrame:CGRectMake(_nicknameLable.left, _nicknameLable.bottom + 5, _nicknameLable.width, 15)];
    _add_time.font = [UIFont systemFontOfSize:kSmallFont];
    _add_time.textAlignment = NSTextAlignmentLeft;
    _add_time.textColor = [UIColor lightGrayColor];
    [_avatarLineView addSubview:_add_time];
    
    //  楼主
    _owner = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 110, 15, 100, 15)];
    _owner.font = [UIFont systemFontOfSize:kSmallFont];
    _owner.text = @"楼主";
    _owner.textAlignment = NSTextAlignmentRight;
    _owner.textColor = [UIColor magentaColor];
    [_avatarLineView addSubview:_owner];
    
    
    // 介绍
    _intro = [[UILabel alloc] initWithFrame:CGRectMake(10, _avatarLineView.bottom + 10, kScreenWidth - 20, 100)];
    _intro.numberOfLines = -1;
    _intro.font = [UIFont systemFontOfSize:kSmallFont];
    [_headerView addSubview:_intro];
    
    
    return _headerView;
}


#pragma mark  实现tableView的代理方法
- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _commentArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMMeiiFamilyCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMMeiiFamilyCommentTableViewCell" forIndexPath:indexPath];
    cell.model = _commentArr[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lightGrayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    lightGrayLabel.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:lightGrayLabel];
    
    
    UILabel *talkLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 80, 20)];
    talkLabel.text = @"讨论";
    talkLabel.textColor = [UIColor magentaColor];
    talkLabel.font = [UIFont systemFontOfSize:kLargeFont];
    [view addSubview:talkLabel];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [BMMeiiFamilyCommentTableViewCell heightForCellWithModel:_commentArr[indexPath.row]];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
