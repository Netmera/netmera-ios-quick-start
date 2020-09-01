fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios beta
```
fastlane ios beta
```
Push a new beta build to TestFlight
### ios beta_enterprise
```
fastlane ios beta_enterprise
```

### ios prepare_development_credentials
```
fastlane ios prepare_development_credentials
```

### ios prepare_production_credentials
```
fastlane ios prepare_production_credentials
```

### ios prepare_enterprise_credentials
```
fastlane ios prepare_enterprise_credentials
```

### ios carthage_beta
```
fastlane ios carthage_beta
```

### ios deliver_internal_framework
```
fastlane ios deliver_internal_framework
```

### ios deliver_framework
```
fastlane ios deliver_framework
```

### ios release_framework
```
fastlane ios release_framework
```

### ios generate_internal_framework
```
fastlane ios generate_internal_framework
```

### ios generate_framework
```
fastlane ios generate_framework
```


----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
