//
//  SMRGameMainController.m
//  gameDemo
//
//  Created by Tinswin on 2020/2/13.
//  Copyright © 2020 sumrise. All rights reserved.
//

#import "SMRGameMainController.h"
#import "SMRDirector.h"

@interface SMRGameMainController ()

@property (strong, nonatomic) UIButton *luckDrawBtn;    // 抽奖
@property (strong, nonatomic) UIButton *luckDrawBtn2;   // 抽奖
@property (strong, nonatomic) UIButton *attackBtn;

@end

@implementation SMRGameMainController

- (SMRNavigationView *)navigationViewInitialization {
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SMRDirector sharedInstance];
    
    [self.view addSubview:self.luckDrawBtn];
    [self.view addSubview:self.luckDrawBtn2];
    [self.view addSubview:self.attackBtn];
    
    self.luckDrawBtn.frame = CGRectMake(20, 100, 80, 80);
    self.luckDrawBtn2.frame = CGRectMake(110, 100, 80, 80);
    self.attackBtn.frame = CGRectMake(200, 100, 80, 80);
}

#pragma mark - Actions

- (void)luckDrawBtnAction:(UIButton *)sender {
    SMRDirector *director = [SMRDirector sharedInstance];
    [director purchRolesWithCount:1];
}

- (void)luckDrawBtn2Action:(UIButton *)sender {
    SMRDirector *director = [SMRDirector sharedInstance];
    [director purchRolesWithCount:10];
}

- (void)attackBtnAction:(UIButton *)sender {
    SMRDirector *director = [SMRDirector sharedInstance];
    [director.mainRole.meta_role attackToRole:director.roles.firstObject.meta_role
                              skill:director.mainRole.skills.firstObject];
}

#pragma mark - Getters

- (UIButton *)luckDrawBtn {
    if (!_luckDrawBtn) {
        _luckDrawBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_luckDrawBtn setTitle:@"抽一次" forState:UIControlStateNormal];
        [_luckDrawBtn addTarget:self action:@selector(luckDrawBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _luckDrawBtn;
}

- (UIButton *)luckDrawBtn2 {
    if (!_luckDrawBtn2) {
        _luckDrawBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_luckDrawBtn2 setTitle:@"抽十次" forState:UIControlStateNormal];
        [_luckDrawBtn2 addTarget:self action:@selector(luckDrawBtn2Action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _luckDrawBtn2;
}

- (UIButton *)attackBtn {
    if (!_attackBtn) {
        _attackBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_attackBtn setTitle:@"攻击测试" forState:UIControlStateNormal];
        [_attackBtn addTarget:self action:@selector(attackBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _attackBtn;
}

@end
