//
//  BMGoodsListTableViewCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMGoodsListTableViewCell.h"

@interface BMGoodsListTableViewCell ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *keyArray;

@end

@implementation BMGoodsListTableViewCell

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//    }
//    return self;
//}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    _keyArray = [_dataDic allKeys];
    [self loadSubView];
}


- (void)loadSubView{
    _tableView = [[UITableView alloc] initWithFrame:self.contentView.frame style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.contentView addSubview:_tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _keyArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *value = _dataDic[_keyArray[section]];
    return value.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
     NSArray *value = _dataDic[_keyArray[indexPath.section]];
    BMGoodsListModel *model = value[indexPath.row];
    NSString *textValue = [[model.brand_name stringByAppendingString:model.product_name] stringByAppendingString:model.color_name];
    cell.textLabel.text = textValue;
    cell.textLabel.font = [UIFont systemFontOfSize:10];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text = [NSString stringWithFormat:@"      %@",_keyArray[section]];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:10];
    return titleLabel;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
