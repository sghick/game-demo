//
//  SMRDirector.m
//  gameDemo
//
//  Created by Tinswin on 2020/2/14.
//  Copyright © 2020 sumrise. All rights reserved.
//

#import "SMRDirector.h"
#import <SMRBaseCore/SMRDB.h>
#import "SMRDataBase+Role.h"

@implementation SMRDirector

@synthesize metaRoles = _metaRoles;

+ (instancetype)sharedInstance {
    static SMRDirector *_director = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _director = [[SMRDirector alloc] init];
        [_director loadMetaDatas];
    });
    return _director;
}

- (void)loadMetaDatas {
    if (![SMRMetaRole selectAll].count) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *path = [[NSBundle mainBundle] pathForResource:@"meta_datas" ofType:@"sql"];
            NSError *err = nil;
            NSString *sql = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&err];
            SMRDBSqlOption *option = [[SMRDBSqlOption alloc] init];
            option.sql = sql;
            [option excute];
        });
    }
}

- (void)addRoles:(NSArray<SMRRole *> *)role {
    if (!role.count) {
        return;
    }
    NSMutableArray *old = [self.roles mutableCopy];
    [old addObjectsFromArray:role];
    self.roles = [old copy];
}

- (void)removeRole:(SMRRole *)role {
    if (!role) {
        return;
    }
    NSMutableArray *old = [self.roles mutableCopy];
    [old removeObject:old];
    self.roles = [old copy];
}

- (NSArray<SMRMetaRole *> *)metaRoles {
    if (!_metaRoles) {
        _metaRoles = [SMRDataBase selectedAllMetaRoles];
    }
    return _metaRoles;
}

- (SMRRole *)mainRole {
    if (!_mainRole) {
        _mainRole = [SMRDataBase selectedMainRole];
        if (!_mainRole) {
            SMRMetaRole *metaRole = [SMRDataBase selectedMainMetaRole];
            _mainRole = [self buildRoleWithMetaRole:metaRole];
            if (_mainRole) {
                _mainRole.main_role = YES;	
                [SMRDataBase insertRoles:@[_mainRole]];
            }
        }
    }
    return _mainRole;
}

- (NSArray<SMRRole *> *)roles {
    if (!_roles) {
        _roles = [SMRDataBase selectedAllRoles];
    }
    return _roles;
}

- (NSArray<SMRRole *> *)purchRolesWithCount:(NSInteger)count {
    NSMutableArray<SMRRole *> *roles = [NSMutableArray array];
    int32_t base = self.metaRoles.count/0.5;
    for (int i = 0; i < count; i++) {
        int32_t idx = arc4random()%base;
        if (idx < self.metaRoles.count) {
            SMRMetaRole *metaRole = self.metaRoles[idx];
            SMRRole *role = [self buildRoleWithMetaRole:metaRole];
            [roles addObject:role];
            NSLog(@"恭喜抽中:%@", role.meta_role.name);
        } else {
            NSLog(@"遗憾未抽中");
        }
    }
    if (roles.count) {
        [SMRDataBase insertRoles:roles];
        [self addRoles:roles];
    }
    return [roles copy];
}

- (SMRRole *)buildRoleWithMetaRole:(SMRMetaRole *)metaRole {
    SMRRole *role = [[SMRRole alloc] init];
    role.u_id = [NSUUID UUID].UUIDString.lowercaseString;
    role.meta_role = metaRole;
    role.skills = [SMRDataBase selectedSkillsWithIds:metaRole.skill_ids];
    return role;
}

@end
