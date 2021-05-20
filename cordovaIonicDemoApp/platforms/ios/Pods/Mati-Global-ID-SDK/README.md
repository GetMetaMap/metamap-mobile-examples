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

You now need to place the Mati KYC button inside your App. You have 2 options for that (interface builder vs. code):

You can include `MatiButton` into your view using XCode interface builder
Or
Add using Swift or Objective-C 

### Swift
    
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

          //set params to your button
          matiButton.setParams(clientId: "YOUR_CLIENT_ID", flowId: "YOUR_FLOW_ID", metadata: ["key": "value"])
          
          //set view of button
          matiButton.frame = CGRect(x: 20, y: self.view.frame.size.height/2 - 50, width: view.frame.size.width - 40, height: 50)

          //add button to yours view
          view.addSubview(matiButton)

          //set delegate to get result
          MatiButtonResult.shared.delegate = self
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
          
          //set params to your button
          [self.matiButton setParamsWithClientId:@"YOUR_CLIENT_ID" flowId:@"YOUR_FLOW_ID" metadata:@{@"key":@"value"}];
          
          //set view of button
          self.matiButton.frame = CGRectMake(20, self.view.frame.size.height/2 - 25, self.view.frame.size.width - 40, 50);
          self.matiButton.center = self.view.center;
          
           //add button to yours view
          [self.view addSubview:self.matiButton];

		  //set delegate to get result
          [MatiButtonResult shared].delegate = self;
      }

      - (IBAction)closeButtonAction:(id)sender {
          [self dismissViewControllerAnimated:true completion:nil];
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

