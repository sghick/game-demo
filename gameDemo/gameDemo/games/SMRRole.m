//
//  SMRRole.m
//  gameDemo
//
//  Created by 丁治文 on 2019/8/20.
//  Copyright © 2019 sumrise. All rights reserved.
//

#import "SMRRole.h"

@implementation SMRMetaRole

- (SMRSAttackResult *)attackToRole:(SMRMetaRole *)role skill:(nonnull SMRSkill *)skill {
    NSLog(@"%@ 使用 %@技能,攻击了 %@", self.name, skill.name, role.name);
    BOOL pa_crit = [skill pa_crited];
    BOOL sa_crit = [skill sa_crited];
    NSLog(@"物理暴击:%@", pa_crit ? @"是" : @"否");
    NSLog(@"魔法暴击:%@", sa_crit ? @"是" : @"否");
    
    int32_t pa_hp = (self.pa + skill.pa)*(pa_crit?(skill.pa_crit_percent/100.0):1);
    int32_t sa_hp = (self.sa + skill.sa)*(sa_crit?(skill.sa_crit_percent/100.0):1);
    pa_hp -= role.pd;
    sa_hp -= role.sd;
    NSLog(@"物理伤害:%@", @(pa_hp));
    NSLog(@"魔法伤害:%@", @(sa_hp));
    
    SMRSAttackResult *result = [[SMRSAttackResult alloc] init];
    result.hp = pa_hp + sa_hp;
    NSLog(@"造成 %@ %@", role.name, result);
    
    return result;
}

@end

@implementation SMRRole

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"skills":SMRSkill.class};
}

@end

@implementation SMRSkill

- (BOOL)pa_crited {
    return arc4random()%100 < self.pa_crit_rate;
}
- (BOOL)sa_crited {
    return arc4random()%100 < self.sa_crit_rate;
}

@end

@implementation SMRSEquipments

@end

@implementation SMRSEquipment

@end

@implementation SMRSAttackResult

- (NSString *)description {
    NSString *hp = [NSString stringWithFormat:@"%@ %@ 血量", (self.hp > 0)?@"减少":@"增加", @(self.hp)];
    NSString *mp = [NSString stringWithFormat:@"%@ %@ 蓝量", (self.hp > 0)?@"减少":@"增加", @(self.mp)];
    if (self.hp && self.mp) {
        return [NSString stringWithFormat:@"%@ %@", hp, mp];
    } else if (self.hp) {
        return hp;
    } else if (self.mp) {
        return mp;
    }
    return @"无影响";
}

@end
