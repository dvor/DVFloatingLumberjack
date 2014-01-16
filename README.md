DVFloatingLumberjack is a bridge between [DVFloatingWindow](https://github.com/dvor/DVFloatingWindow) and [CocoaLumberjack](https://github.com/robbiehanson/CocoaLumberjack).

# Installation

To use DVFloatingLumberjack you have to install [DVFloatingWindow](https://github.com/dvor/DVFloatingWindow) and [CocoaLumberjack](https://github.com/robbiehanson/CocoaLumberjack) first.

There are two possible methods to include DVFloatingWindow in your project:

1. Using [CocoaPods](http://cocoapods.org):
    * Add pod entry for DVFloatingLumberjack to your Podfile `pod 'DVFloatingLumberjack'`
    * Install the pod by running `pod install`

2. Manually: 
    * Get the [latest version](https://github.com/dvor/DVFloatingLumberjack/archive/0.2.1.zip)
    * Drag files from DVFLoatingLumberjack folder to your project (Check **Add to target** and **Copy items into destination group's folder** checkboxes)

Initialize DVLumberjackLogger (perhaps in your AppDelegate file).

```objc
#import "DVLumberjackLogger.h"

...

DVLumberjackLogger *dvLogger = [DVLumberjackLogger new];

// logging all logs to Default logger
[dvLogger attachFloatingLogger:@"Default" toLumberjackLogLevel:LOG_LEVEL_VERBOSE];

[DDLog addLogger:dvLogger];
```

# Usage

You can log all errors to separate logger.

```objc

// logging all errors to Errors logger
[dvLogger attachFloatingLogger:@"Errors" toLumberjackLogLevel:LOG_LEVEL_ERROR];

```

CocoaLumberjack's logLevel is a bitmask, created from log flags (there are five of them by default):

- LOG_FLAG_ERROR
- LOG_FLAG_WARN
- LOG_FLAG_INFO
- LOG_FLAG_DEBUG
- LOG_FLAG_VERBOSE

You can add any combination of flags and attach log to it.

```objc

// only warn logs go here
[dvLogger attachFloatingLogger:@"Warn" toLumberjackLogLevel:LOG_FLAG_WARN];

// this is non-errors logger
[dvLogger attachFloatingLogger:@"Non errors"
          toLumberjackLogLevel:LOG_FLAG_INFO | LOG_FLAG_DEBUG | LOG_FLAG_VERBOSE];

```

If you want you can dynamically attach and remove log levels to DVFloatingWindow.

```objc

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // all logs are related to GalleryController while it's visible
    [dvLogger attachFloatingLogger:@"GalleryController" toLumberjackLogLevel:LOG_LEVEL_INFO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [dvLogger removeFloatingLogger:@"GalleryController" fromLumberjackLogLevel:LOG_LEVEL_INFO];
}

```

Or even attach/remove logs directly from window.

```objc

DVButtonAdd(@"Start showing logs", ^{
    [dvLogger attachFloatingLogger:@"Default" toLumberjackLogLevel:LOG_FLAG_VERBOSE];
});

DVButtonAdd(@"Stop showing logs", ^{
    [dvLogger removeFloatingLogger:@"Default" fromLumberjackLogLevel:LOG_FLAG_VERBOSE];
});

```

# License

DVFloatingLumberjack is available under the MIT license. See the [LICENSE](LICENSE.txt) file for more info.

