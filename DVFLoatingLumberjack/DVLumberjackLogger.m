//
//  DVLumberjackLogger.m
//  DVLumberjackLogger
//
//  Created by Dmitry Vorobjov on 8/9/13.
//  Copyright (c) 2013 Dmitry Vorobyov. All rights reserved.
//

#import "DVLumberjackLogger.h"
#import <DVFloatingWindow/DVFloatingWindow.h>

@interface DVLumberjackLogger()

@property (strong, nonatomic) dispatch_queue_t queue;

/**
 * Dictionary with NSMutableSets with DVFloatingWindow's logger keys. CocoaLumberjack's
 * flags wrapped in NSNumbers are used as keys.
 */
@property (strong, nonatomic) NSMutableDictionary *dictionaryWithLoggersForFlags;

@end

@implementation DVLumberjackLogger

#pragma mark -  Lifecycle

- (id)init
{
    if (self = [super init]) {
        self.queue = dispatch_queue_create("DVLumberjackLogger", NULL);
        self.dictionaryWithLoggersForFlags = [NSMutableDictionary new];
    }

    return self;
}

#pragma mark -  Methods

- (void)attachFloatingLogger:(NSString *)loggerKey
        toLumberjackLogLevel:(int)logLevel
{
    if (! loggerKey) {
        return;
    }

    dispatch_async(self.queue, ^{
        NSDictionary *dictionary = [self subdictionaryWithLoggersForLogLevel:logLevel
                                                               createMissing:YES];

        for (NSNumber *key in dictionary) {
            NSMutableSet *loggers = dictionary[key];
            [loggers addObject:loggerKey];
        }
    });
}

- (void)removeFloatingLogger:(NSString *)loggerKey fromLumberjackLogLevel:(int)logLevel
{
    dispatch_async(self.queue, ^{
        NSDictionary *dictionary = [self subdictionaryWithLoggersForLogLevel:logLevel
                                                               createMissing:YES];

        for (NSNumber *key in [dictionary allKeys]) {
            NSMutableSet *loggers = dictionary[key];
            [loggers removeObject:loggerKey];

            if (! loggers.count) {
                [self.dictionaryWithLoggersForFlags removeObjectForKey:key];
            }
        }
    });
}

- (void)logMessage:(DDLogMessage *)logMessage
{
    dispatch_async(self.queue, ^{
        NSString *logMsg;

        if (formatter) {
            logMsg = [formatter formatLogMessage:logMessage];
        }
        else {
            logMsg = logMessage->logMsg;
        }

        if (logMsg) {
            for (NSNumber *key in self.dictionaryWithLoggersForFlags) {

                if (logMessage->logFlag & key.intValue) {
                    NSSet *loggers = self.dictionaryWithLoggersForFlags[key];

                    for (NSString *loggerKey in loggers) {
                        [[DVFloatingWindow sharedInstance] loggerLogToLogger:loggerKey
                                                                         log:logMsg];
                    }
                }
            }

        }
    });
}

#pragma mark -  Supporting methods

/**
 * logLevel is bitmask, each bit is representing one log flag. Each bit is used as key in
 * dictionaryWithLoggersForFlags. We are looping through all bits and getting loggers
 * from dictionary.
 *
 * It logger doesn't exist and createMissing = YES, then we create new logger and add it
 * to dictionaryWithLoggersForFlags.
 */
- (NSDictionary *)subdictionaryWithLoggersForLogLevel:(int)logLevel
                                        createMissing:(BOOL)createMissing
{
    NSMutableDictionary *dictionaryWithLoggers = [NSMutableDictionary new];

    int pow = 1;

    while (logLevel) {
        if (logLevel & 1) {
            NSNumber *key = @(pow);

            NSMutableSet *loggers = self.dictionaryWithLoggersForFlags[key];

            if (! loggers && createMissing) {
                self.dictionaryWithLoggersForFlags[key] = loggers = [NSMutableSet new];
            }

            dictionaryWithLoggers[key] = loggers;
        }

        logLevel >>= 1;
        pow *= 2;
    }

    return dictionaryWithLoggers;
}

@end
