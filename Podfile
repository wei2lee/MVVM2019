# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            
            if config.name == 'Debug' || config.name == 'DEV_LOCAL' || config.name == 'DEV_STAGING' || config.name == 'DEV_PRODUCTION'
                other_swift_flags = config.build_settings['OTHER_SWIFT_FLAGS'] || ['$(inherited)']
                other_swift_flags << '-Onone'
                config.build_settings['OTHER_SWIFT_FLAGS'] = other_swift_flags
                config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
                config.build_settings['COPY_PHASE_STRIP'] = 'NO'
                config.build_settings['DEBUG_INFORMATION_FORMAT'] = "dwarf"
                config.build_settings['ENABLE_BITCODE'] = 'NO'
                config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
            else
                config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
                config.build_settings['COPY_PHASE_STRIP'] = 'YES'
                config.build_settings['DEBUG_INFORMATION_FORMAT'] = "dwarf-with-dsym";
                
                if config.name == 'Production' || config.name == 'Release'
                    config.build_settings['ENABLE_BITCODE'] = 'YES'
                else
                    config.build_settings['ENABLE_BITCODE'] = 'NO'
                end
                
                config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
            end
        end
    end
end

target 'MVVM2019June20' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  inhibit_all_warnings!  # ignore all warnings from all pods

  # Pods for MVVM2019June20
    # Dependency Injection
    pod 'Swinject', '~> 2.5.0'

    # Reactive
    pod 'RxSwift', '~> 5.0.0'
    pod 'RxCocoa', '~> 5.0.0'

    # Reactive Utility
    pod 'RxDataSources', '~> 4.0.1'
    pod 'RxGesture', '~> 3.0.0'
    pod 'RxBiBinding', '~> 0.2.3'

    # Date Utility
    pod 'SwiftDate', '~> 5.1.0'

    # Utility
    pod 'SwifterSwift', '~> 4.6.0'
    pod 'SemanticVersioning'

    # UUID Utility
    pod 'FCUUID', '~> 1.3.1'
    pod 'DeviceKit', '~> 2.0'

    # UI
    pod 'MBProgressHUD', '~> 1.1.0'
    pod 'NibDesignable', :git => 'https://github.com/wei2lee/NibDesignable.git'
    pod 'ESPullToRefresh'
    pod 'TagListView', '~> 1.0'

    # Permission
    pod 'Permission/Photos', :git => 'https://github.com/aiaagentapp/Permission'
    pod 'Permission/Camera', :git => 'https://github.com/aiaagentapp/Permission'
    pod 'RxPermission/Photos'
    pod 'RxPermission/Camera'

    # keyboard
    pod 'IQKeyboardManagerSwift', '~> 6.4.0'

    # Network
    pod 'Moya', '~> 12.0.1'

    # Logger
    pod 'XCGLogger', '~> 7.0.0'
    pod 'XCGLogger/UserInfoHelpers'
    pod 'FLEX', '~> 3.0.0'

    # Static Resource Mapping Generator
    #pod 'R.swift', '~> 5.0.3'

    #Persistency
    pod 'SwiftyUserDefaults', '4.0.0-beta.2'
    pod 'CodableExtensions'

    #ImageUtil
    pod 'Kingfisher', '~> 5.3.0'
    
    #Coordinator
    #pod 'XCoordinator', '~> 1.0'
    #pod 'XCoordinator/RxSwift', '~> 1.0'
end

target 'ModuleTests' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  # ignore all warnings from all pods
  inhibit_all_warnings!
  
  # Pods for MVVM2019June20
    # Dependency Injection
    pod 'Swinject', '~> 2.5.0'

    # Reactive
    pod 'RxSwift', '~> 5.0.0'
    pod 'RxCocoa', '~> 5.0.0'

    # Reactive Utility
    pod 'RxDataSources', '~> 4.0.1'
    pod 'RxGesture', '~> 3.0.0'
    pod 'RxBiBinding', '~> 0.2.3'

    # Date Utility
    pod 'SwiftDate', '~> 5.1.0'

    # Utility
    pod 'SwifterSwift', '~> 4.6.0'
    pod 'SemanticVersioning'

    # UUID Utility
    pod 'FCUUID', '~> 1.3.1'
    pod 'DeviceKit', '~> 2.0'

    # UI
    pod 'MBProgressHUD', '~> 1.1.0'
    pod 'NibDesignable', :git => 'https://github.com/wei2lee/NibDesignable.git'
    pod 'ESPullToRefresh'
    pod 'TagListView', '~> 1.0'

    # Permission
    pod 'Permission/Photos', :git => 'https://github.com/aiaagentapp/Permission'
    pod 'Permission/Camera', :git => 'https://github.com/aiaagentapp/Permission'
    pod 'RxPermission/Photos'
    pod 'RxPermission/Camera'

    # keyboard
    pod 'IQKeyboardManagerSwift', '~> 6.4.0'

    # Network
    pod 'Moya', '~> 12.0.1'

    # Logger
    pod 'XCGLogger', '~> 7.0.0'
    pod 'XCGLogger/UserInfoHelpers'
    pod 'FLEX', '~> 3.0.0'

    # Static Resource Mapping Generator
    #pod 'R.swift', '~> 5.0.3'

    #Persistency
    pod 'SwiftyUserDefaults', '4.0.0-beta.2'
    pod 'CodableExtensions'

    #ImageUtil
    pod 'Kingfisher', '~> 5.3.0'
    
    #Coordinator
    #pod 'XCoordinator', '~> 1.0'
    #pod 'XCoordinator/RxSwift', '~> 1.0'
    
    # RxSwift Unit Test Utility
    pod 'RxTest', '~> 5.0.0'
    pod 'RxBlocking', '~> 5.0.0'
    
    # Unit Test
    pod 'Nimble', '~> 8.0.2'
    pod 'Quick', '~> 2.1.0'
end
