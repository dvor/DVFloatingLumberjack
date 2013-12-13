//
//  DVLumberjackLogger.h
//  DVLumberjackLogger
//
//  Created by Dmitry Vorobjov on 8/9/13.
//  Copyright (c) 2013 Dmitry Vorobyov. All rights reserved.
//

#import "DDLog.h"

@interface DVLumberjackLogger : DDAbstractLogger <DDLogger>

- (id)init;

/**
 * Attach DVFloatingWindow's logger for loggerKey to CocoaLumberjack's logLevel.
 * All messages with appropriate logLevel will be logged to that logger.
 *
 * Note: logLevel is bitmask of log flags:
 * #define LOG_LEVEL_INFO    (LOG_FLAG_ERROR | LOG_FLAG_WARN | LOG_FLAG_INFO)
 *
 * So you can pass any combination of those flags, e.g.
 * [dvLogger attachFloatingLogger:key
 *           toLumberjackLogLevel:LOG_LEVEL_ERROR | LOG_FLAG_INFO];
 */
- (void)attachFloatingLogger:(NSString *)loggerKey toLumberjackLogLevel:(int)logLevel;

- (void)removeFloatingLogger:(NSString *)loggerKey fromLumberjackLogLevel:(int)logLevel;

@end
