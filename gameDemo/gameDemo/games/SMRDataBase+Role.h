//
//  SMRDataBase+Role.h
//  gameDemo
//
//  Created by Tinswin on 2020/2/13.
//  Copyright © 2020 sumrise. All rights reserved.
//

#import <SMRBaseCore/SMRDataBase.h>

NS_ASSUME_NONNULL_BEGIN

@class SMRMetaRole;
@class SMRRole;
@class SMRSkill;
@interface SMRDataBase (Role)

+ (SMRMetaRole *)selectedMainMetaRole;
+ (NSArray<SMRMetaRole *> *)selectedAllMetaRoles;

+ (NSArray<SMRSkill *> *)selectedSkillsWithIds:(NSString *)ids;

+ (SMRRole *)selectedMainRole;
+ (NSArray<SMRRole *> *)selectedAllRoles;
+ (void)insertRoles:(NSArray<SMRRole *> *)roles;

@end

NS_ASSUME_NONNULL_END
