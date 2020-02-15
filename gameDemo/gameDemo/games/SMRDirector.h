//
//  SMRDirector.h
//  gameDemo
//
//  Created by Tinswin on 2020/2/14.
//  Copyright © 2020 sumrise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMRRole.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMRDirector : NSObject

@property (strong, nonatomic, readonly) NSArray<SMRMetaRole *> *metaRoles;

@property (strong, nonatomic) SMRRole *mainRole;
@property (strong, nonatomic) NSArray<SMRRole *> *roles;

+ (instancetype)sharedInstance;

- (void)addRoles:(NSArray<SMRRole *> *)role;
- (void)removeRole:(SMRRole *)role;

/** 购买 */
- (NSArray<SMRRole *> *)purchRolesWithCount:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
