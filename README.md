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

# Test splitting for Xcode UITests using CircleCI × Fastlane

If you just want to run Xcode UITests(XCUITests), below fastlane is enough.

```ruby
desc "Run all UITests"
lane :ui_test_all do
  run_tests(
    scheme: "CircleCIDemoUITests",
    devices: ["iPhone 13 (15.4)"]
  )
end
```

However, since UITests takes time, you want to split these tests and run them in multiple macOS VMs and iOS Simulators.

Here's how to create that pipeline.

<br/>
First, you have to build iOS application, including test files.

Fastlane's `run_test` provides `build_for_testing` and enables just for building the app and tests, not runnning tests.

You can specify output path in `derived_data_path`

```ruby
desc "Run all UITests"
lane :build_for_ui_test do
  run_tests(
    scheme: "CircleCIDemoUITests",
    devices: ["iPhone 13 (15.4)"],
    derived_data_path: "dist",
    build_for_testing: true
  )
end
```

Then you can upload this path to workspace.

```yaml
build_for_ui_test:
  macos:
    xcode: 13.3.1
  resource_class: macos.x86.medium.gen2
  steps:
    - checkout
    - ruby/install-deps
    - run: bundle exec fastlane build_for_ui_test
    - persist_to_workspace:
        root: .
        paths:
          - dist
```

Next step, we will split tests and run them in multiple macOS VMs and iOS Simulators

Since we alredy built the app and tests in previous step, we can download them from workspace and use.

You should specify `derived_data_path` and `test_without_building` in fastlane's `run_tests`.

```ruby
desc "Run specific UITests"
lane :ui_test_without_building do |options|
  run_tests(
    scheme: "CircleCIDemoUITests",
    devices: ["iPhone 13 (15.4)"],
    only_testing: options[:tests],
    derived_data_path: "dist",
    test_without_building: true
  )
end
```

`run_tests` also provides `only_testing` options, so you can split test files in CircleCI and pass parameters.

```yaml
ui_test_parallel:
  parallelism: 2
  macos:
    xcode: 13.3.1
  resource_class: macos.x86.medium.gen2
  steps:
    - checkout
    - macos/preboot-simulator:
        device: iPhone 13
        version: "15.4"
    - attach_workspace:
        at: .
    - ruby/install-deps
    - run:
        name: Split tests and run UITests
        command: |
          CLASSNAMES=$(circleci tests glob "CircleCIDemoUITests/*.swift" \
            | sed 's@/@.@g' \
            | sed 's/.swift//' \
            | circleci tests split --split-by=timings --timings-type=classname)
          FASTLANE_ARGS=$(echo $CLASSNAMES | sed -e 's/\./\//g' -e 's/ /,/g')
          bundle exec fastlane ui_test_without_building tests:$FASTLANE_ARGS
    - store_test_results:
        path: fastlane/test_output/report.junit
```
