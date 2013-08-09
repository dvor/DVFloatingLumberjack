//
//  DVLumberjackLogger.m
//  DVLumberjackLogger
//
//  Created by Dmitry Vorobjov on 8/9/13.
//  Copyright (c) 2013 Dmitry Vorobyov. All rights reserved.
//

#import "DVLumberjackLogger.h"
#import "DVFloatingWindow.h"

@implementation DVLumberjackLogger

- (void)logMessage:(DDLogMessage *)logMessage 
{
    NSString *logMsg;
    
    if (formatter) {
        logMsg = [formatter formatLogMessage:logMessage];
    }
    else {
        logMsg = logMessage->logMsg;
    }

    if (logMsg) {
        DVLog(logMsg);
    }
}

@end
