DVFloatingLumberjack is a bridge between [DVFloatingWindow](https://github.com/dvor/DVFloatingWindow) and [CocoaLumberjack](https://github.com/robbiehanson/CocoaLumberjack).

# Installation

To use DVFloatingLumberjack you have to install [DVFloatingWindow](https://github.com/dvor/DVFloatingWindow) and [CocoaLumberjack](https://github.com/robbiehanson/CocoaLumberjack) first.

There are two possible methods to include DVFloatingWindow in your project:

1. Using [CocoaPods](http://cocoapods.org):
    * Add pod entry for DVFloatingLumberjack to your Podfile `pod 'DVFloatingLumberjack'`
    * Install the pod by running `pod install`

2. Manually: 
    * Get the [latest version](https://github.com/dvor/DVFloatingLumberjack/archive/0.1.1.zip)     
    * Drag files from DVFLoatingLumberjack folder to your project (Check **Add to target** and **Copy items into destination group's folder** checkboxes)

Initialize DVLumberjackLogger (perhaps in your AppDelegate file).

```objc
#import "DVLumberjackLogger.h"

...

DVLumberjackLogger *dvLumberjackLogger = [DVLumberjackLogger new];

// set custom log formatter and other settings
//dvLumberjackLogger.logFormatter = yourCustomLogFormatter;
//dvLumberjackLogger.rollingFrequency = 60 * 60 * 24;
//dvLumberjackLogger.logFileManager.maximumNumberOfLogFiles = 7;

[DDLog addLogger:dvLumberjackLogger];
```

# License

DVFloatingLumberjack is available under the MIT license. See the [LICENSE](LICENSE.txt) file for more info.


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/dvor/dvfloatinglumberjack/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

