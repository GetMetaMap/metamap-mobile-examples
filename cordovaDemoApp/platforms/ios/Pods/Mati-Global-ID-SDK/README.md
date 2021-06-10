# Mati iOS SDK documentation 

![alt text](https://github.com/MatiFace/mati-global-id-sdk/blob/master/readme_pic.png)

## Xcode configurations

### Install Mati SDK using CocoaPods (recommended)

Create Podfile and add pod 'Mati-Global-ID-SDK':
  
    pod 'Mati-Global-ID-SDK'
    
Update your pods from the terminal

    pod install
    
##### ! Dependencies (will be automatically installed with Mati pod)
Starscream, SocketIO

### If you're not using CocoaPods (not recommended)

Download Mati framework from GitHub and add it to your project with all necessary dependencies.

Note: Don't miss to add framework in Embedded Binaries.


## Example

Please take a look at example

https://github.com/GetMati/mati-mobile-examples/tree/main/MatiSDKDemoSwift


## Implemenatation
You now need to place the Mati button inside your App. 

Add using Swift or Objective-C 

### Swift

```swift
import UIKit
import MatiSDK

class ViewController: UIViewController {
    
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setupMatiButton()
	}
    
    private func setupMatiButton() {

      //init button
      let matiButton = MatiButton()

      //add button action
      matiButton.addTarget(self, action: #selector(self.matiButtonAction), for: .touchUpInside)

      //set view of button
      matiButton.frame = CGRect(x: 20, y: self.view.frame.size.height/2 - 50, width: view.frame.size.width - 40, height: 50)

      //add button to yours view
      view.addSubview(matiButton)

      //set delegate to get result
      MatiButtonResult.shared.delegate = self
      
    }
  
      @objc private func matiButtonAction() {
	//set params to showMatiFlow
	MatiSDK.shared.showMatiFlow(clientId: "YOUR_CLIENT_ID",
				flowId: "YOUR_FLOW_ID",
				metadata: ["key1": "value1"])
	}
}

//MARK: MatiButtonResultDelegate
extension ViewController: MatiButtonResultDelegate {
    
	func verificationSuccess(identityId: String) {
		print("Mati Verification Success \(identityId)")
	}

	func verificationCancelled() {
		print("Mati Verification Cancelled")
	}
}
```
   
### Objective-C
    
    #import "ViewController.h"
    #import <MatiSDK/MatiSDK.h>

    @interface ViewController () <MatiButtonResultDelegate>

    @property (nonatomic, strong) MatiButton *matiButton;

    @end

    @implementation ViewController

      - (void)viewDidLoad {
          [super viewDidLoad];
          
          //init button
          self.matiButton = [[MatiButton alloc] init];
          
          //add action to yours button
            [self.matiButton addTarget:self action:@selector(matiButtonAction:) forControlEvents:UIControlEventTouchUpInside];
          
          //set view of button
          self.matiButton.frame = CGRectMake(20, self.view.frame.size.height/2 - 25, self.view.frame.size.width - 40, 50);
          self.matiButton.center = self.view.center;
          
           //add button to yours view
          [self.view addSubview:self.matiButton];

		  //set delegate to get result
          [MatiButtonResult shared].delegate = self;
      }
      
      //add showMatiFlow function with YOURS parameters
      -(void)matiButtonAction:(UIButton *) sender{
      	[MatiSDK.shared showMatiFlowWithClientId:@"YOUR_CLIENT_ID" flowId:@"YOUR_FLOW_ID"  metadata:@{@"key":@"value"}];
	}

    #pragma mark - MatiButtonResultDelegate

      -(void)verificationSuccessWithIdentityId:(NSString *)identityId {
          NSLog(@"Success: $@", identityId);
      }

      - (void)verificationCancelled {
          NSLog(@"Cancelled");
      }

    @end;
    
    

### Info.plist – IMPORTANT add this descriptions to your project
The following permissions are needed to capture video, access the photo gallery and microphone to use voiceliveness feature.

```
<key>NSCameraUsageDescription</key>
<string>Mati needs access to your Camera</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Mati needs access to your media library</string>
<key>NSMicrophoneUsageDescription</key>
<string>Mati needs access to your Microphone</string>
```
    
### Requirements 
   iOS 11.4  
   Xcode 12.0  
   Swift 5.0  

   For Mati SDK below 3.x.x please use this documentation https://github.com/MatiFace/mati-global-id-sdk/blob/master/README_old__2_x_x_.md


## SPECIFIC PARAMETERS

You can use metadata to set specific parameters

##### Fixed selected language and hiding the language selection. (to make it permanent)

key: fixedLanguage
value: locale code of language

###### example

for Spain (it can be any country, if we doesnt support language yet it will be setted to English)

##### fixedLanguage : es

###### full example
```swift
metadata: ["fixedLanguage": "es"]
```
