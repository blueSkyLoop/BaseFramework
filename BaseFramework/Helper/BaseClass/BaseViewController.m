//
//  BaseTableViewController.m
//  EduChat
//
//  Created by Gatlin on 16/1/29.
//  Copyright © 2016年 dwd. All rights reserved.
//

#import "BaseViewController.h"

//#import <Masonry/Masonry.h>

@interface BaseViewController ()
@property (nonatomic, copy)  void(^callBlock)(void);
@end

@implementation BaseViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
}

#pragma mark - Setup
- (void)setupTableViewStyle:(UITableViewStyle )tableViewStyle{
    //对不同种风格进行设置
    if (tableViewStyle == UITableViewStylePlain) {
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    else if (tableViewStyle == UITableViewStyleGrouped){
        _tableView.backgroundColor = ColorBackgroud;
        _tableView.sectionFooterHeight = 0.000001f;
    }
}

#pragma mark - Getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - TOPBARHEIGHT)
                                                  style:_tableViewStyle ? _tableViewStyle : UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self setupTableViewStyle:_tableViewStyle ? _tableViewStyle : UITableViewStylePlain];
        _tableView.separatorColor = ColorSeparator;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UIImageView *)noDataImv
{
    if (!_noDataImv) {
        UIImageView *imv = [[UIImageView alloc] init];
        _noDataImv = imv;
         _noDataImv.size = CGSizeMake(218, 188);
//        _noDataImv. = self.tableView.cenX;
//        _noDataImv.cenY = self.tableView.cenY - 64;
    }
    return _noDataImv;
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000001;
}


#pragma mark - Public Method
- (UIView *)setupStateViewWithImageName:(NSString *)imageName describe:(NSString *)describe
{
    
    UIView *stateView = [[UIView alloc] init];
    stateView.frame = self.view.bounds;
    
    stateView.backgroundColor = [UIColor clearColor];
    
    UIImageView *imv = [[UIImageView alloc] init];
    imv.image = [UIImage imageNamed:imageName];
    imv.userInteractionEnabled = YES;
    [stateView addSubview:imv];
    
//    [imv mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(stateView.centerX);
//        make.centerY.mas_equalTo(stateView.centerY).mas_offset(-100);
//    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.text = describe;
    label.textColor = ColorSecondary;
    label.font = FontContent;
    label.textAlignment = NSTextAlignmentCenter;
    [stateView addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(stateView.centerX);
//        make.top.equalTo(imv.bottom).mas_offset(20);
//        make.width.mas_equalTo(stateView.width);
//    }];
    
    return stateView;
}
- (UIView *)setupStateViewWithImageName:(NSString *)imageName describe:(NSString *)describe reloadDataBtnEventBlock:(void(^)())block
{
       _callBlock = block;
    
    UIView *stateView = [self setupStateViewWithImageName:imageName describe:describe];
    UIButton *loadDataBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [loadDataBtn setTitle:@"刷新重试" forState:UIControlStateNormal];
    [loadDataBtn setTitleColor:ColorMain forState:UIControlStateNormal];
    loadDataBtn.titleLabel.font = FontBody;
    [loadDataBtn addTarget:self action:@selector(tapImageEvent) forControlEvents:UIControlEventTouchUpInside];
    [stateView addSubview:loadDataBtn];
//    [loadDataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(stateView.centerX);
//         make.centerY.mas_equalTo(stateView.centerY).mas_offset(20);
////        make.top.equalTo(stateView.centerY).mas_offset(150);
//        make.width.mas_equalTo(80);
//    }];
    return stateView;
}
#pragma mark - Private Method
- (void)tapImageEvent
{
    self.callBlock ? self.callBlock() : nil;
}
@end
