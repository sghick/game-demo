//
//  SMRRole.h
//  gameDemo
//
//  Created by 丁治文 on 2019/8/20.
//  Copyright © 2019 sumrise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SMRBaseCore/SMRModel.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SMRAbnormalStatus) {
    SMRAbnormalStatusBleeding,  // 出血
    SMRAbnormalStatusVertigo,   // 眩晕
};

typedef NS_ENUM(NSInteger, SMRBuffStatus) {
    SMRBuffStatusBati,  // 霸体
};

@class SMRSkill;
@class SMRSAttackResult;
@interface SMRMetaRole : NSObject

@property (assign, nonatomic) BOOL main_role;               
@property (copy  , nonatomic) NSString *name;       // 名字
@property (copy  , nonatomic) NSString *role_id;    // ID
@property (assign, nonatomic) int32_t pa;           // 物攻
@property (assign, nonatomic) int32_t sa;           // 法攻
@property (assign, nonatomic) int32_t pd;           // 物防
@property (assign, nonatomic) int32_t sd;           // 法防
@property (assign, nonatomic) int32_t hp;           // 血量
@property (assign, nonatomic) int32_t mp;           // 蓝量
@property (strong, nonatomic) NSString *skill_ids;  // 自带技能ID

- (SMRSAttackResult *)attackToRole:(SMRMetaRole *)role skill:(SMRSkill *)skill;

@end

@class SMRSEquipments;
@interface SMRRole : NSObject

@property (copy  , nonatomic) NSString *u_id;               // ID
@property (assign, nonatomic) BOOL main_role;               
@property (strong, nonatomic) SMRMetaRole *meta_role;
@property (strong, nonatomic) NSArray<SMRSkill *> *skills;  // 技能
@property (strong, nonatomic) SMRSEquipments *equipments;   // 装备

@end

@interface SMRSkill : NSObject

@property (copy  , nonatomic) NSString *name;       // 名字
@property (copy  , nonatomic) NSString *skill_id;   // ID
@property (assign, nonatomic) int32_t pa;           // 物攻
@property (assign, nonatomic) int32_t sa;           // 法攻
@property (assign, nonatomic) int32_t pa_scale;     // 物理攻击百分比(n%)
@property (assign, nonatomic) int32_t sa_scale;     // 法术攻击百分比(n%)
@property (assign, nonatomic) int32_t pa_crit_rate; // 物理暴击率(n%)
@property (assign, nonatomic) int32_t sa_crit_rate; // 法术暴击率(n%)
@property (assign, nonatomic) int32_t pa_crit_percent;  // 物理暴击百分比(n%)
@property (assign, nonatomic) int32_t sa_crit_percent;  // 法术暴击百分比(n%)

- (BOOL)pa_crited;
- (BOOL)sa_crited;

@end

@class SMRSEquipment;
@interface SMRSEquipments : NSObject

@property (strong, nonatomic) SMRSEquipment *weapon;    // 武器
@property (strong, nonatomic) SMRSEquipment *garment;   // 上衣
@property (strong, nonatomic) SMRSEquipment *trousers;  // 裤子
@property (strong, nonatomic) SMRSEquipment *shoulder;  // 护肩
@property (strong, nonatomic) SMRSEquipment *wrister;   // 护腕
@property (strong, nonatomic) SMRSEquipment *kneelet;   // 护膝
@property (strong, nonatomic) SMRSEquipment *shoes;     // 鞋子

@end

@interface SMRSEquipment : NSObject

@property (copy  , nonatomic) NSString *name;           // 名字
@property (copy  , nonatomic) NSString *equipment_id;   // ID

@end

@interface SMRSAttackResult : NSObject

@property (assign, nonatomic) int32_t hp; // 血量
@property (assign, nonatomic) int32_t mp; // 蓝量
@property (assign, nonatomic) SMRAbnormalStatus abnormal_status;    // 异常状态
@property (assign, nonatomic) SMRBuffStatus buff_status;            // Buff状态

@end

NS_ASSUME_NONNULL_END
