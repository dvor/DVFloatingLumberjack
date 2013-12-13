## 0.2.1

###### Bugfixes

- Fixed usage of dispatch_queue_t on iOS 5.

## 0.2

###### Enhancements

- Added ability to attach different loggers to CocoaLumberjack's logLevel.

#### Note

After update DVFloatingLumberjack will stop working because of introducing attachment to logLevels. By default it isn't attached to any loggers. To attach DVFloatingLumberjack to default logger (as it was before) please add following code:

```obj-c

[dvLogger attachFloatingLogger:@"Default" toLumberjackLogLevel:LOG_LEVEL_VERBOSE];
```

Please see [README](https://github.com/dvor/DVFloatingLumberjack) for more information.

## 0.1.1

Actually log was broken in 0.1 version

## 0.1

Simple version of bridge ready

