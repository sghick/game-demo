//
//  SMRDataBase+Role.m
//  gameDemo
//
//  Created by Tinswin on 2020/2/13.
//  Copyright © 2020 sumrise. All rights reserved.
//

#import "SMRDataBase+Role.h"
#import "SMRRole.h"
#import "SMRDB.h"

@implementation SMRDataBase (Role)

+ (SMRMetaRole *)selectedMainMetaRole {
    NSString *where = @"WHERE rowid=1";
    return [SMRMetaRole selectWhere:where].firstObject;
}
+ (NSArray<SMRMetaRole *> *)selectedAllMetaRoles {
    NSString *where = @"WHERE rowid<>1";
    return [SMRMetaRole selectWhere:where];
}

+ (NSArray<SMRSkill *> *)selectedSkillsWithIds:(NSString *)ids {
    if (!ids.length) {
        return nil;
    }
    NSString *sids = [[ids componentsSeparatedByString:@","] componentsJoinedByString:@"','"];
    NSString *pids = [NSString stringWithFormat:@"'%@'", sids];
    NSString *where = [NSString stringWithFormat:@"WHERE skill_id IN (%@)", pids];
    return [SMRSkill selectWhere:where];
}

+ (SMRRole *)selectedMainRole {
    NSString *where = @"WHERE main_role=(?)";
    return [SMRRole selectWhere:where paramsArray:@[@(YES)]].firstObject;
}
+ (NSArray<SMRRole *> *)selectedAllRoles {
    NSString *where = @"WHERE main_role<>(?)";
    return [SMRRole selectWhere:where paramsArray:@[@(YES)]];
}
+ (void)insertRoles:(NSArray<SMRRole *> *)roles {
    [SMRRole insertOrReplace:roles];
}

@end
