# circleci-demo-ios

[![CircleCI](https://circleci.com/gh/tadashi0713/circleci-demo-ios/tree/master.svg?style=svg)](https://circleci.com/gh/tadashi0713/circleci-demo-ios/tree/master)

Demo for CI/CD pipeline for iOS Native app(SwiftUI) using CircleCI.

You can see [config file here](https://github.com/tadashi0713/circleci-demo-ios/blob/master/.circleci/config.yml).

* Use [macOS large resource class(8CPU, 16GB RAM)](https://support.circleci.com/hc/en-us/articles/360009144794-macOS-resources) to optimise build speed
* Use [Ruby Orb](https://circleci.com/developer/ja/orbs/orb/circleci/ruby) to install [Fastlane](https://fastlane.tools/) with cache easily.
  * Fastlane is used to
    * [Code signing with fastlane match](https://circleci.com/docs/2.0/ios-codesigning/)
    * Upload to Firebase app distribution
* Use [macOS Orb](https://circleci.com/developer/ja/orbs/orb/circleci/macos) to [preboot iOS Simulator for UITests](https://circleci.com/docs/2.0/testing-ios/#pre-starting-the-simulator).
* Use Context for storing secrets(this time token for Firebase) for across projects.
* Upload test results & visualize in [Test Insights](https://circleci.com/docs/2.0/insights-tests/).
