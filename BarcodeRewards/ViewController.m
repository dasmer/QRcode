//
//  ViewController.m
//  BarcodeRewards
//
//  Created by dasmer on 10/26/13.
//  Copyright (c) 2013 Columbia University. All rights reserved.
//

#import "ViewController.h"
#import "Camera.h"


@interface ViewController ()
@property (strong,nonatomic) Camera *camera;



@end

@implementation ViewController{
    BOOL didFindBarcode;
    __weak IBOutlet UIView *_previewView;
    __weak IBOutlet UIImageView *_scannableRegion;
}


- (void) awakeFromNib {
    self.title = @"Scan Barcode";
    self.tabBarItem.image = [UIImage imageNamed:@"tabCameraIcon"];


}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.camera = [[Camera alloc] initWithPreviewView:_previewView ForViewController:self AndScannableRegion:_scannableRegion];
    
    _scannableRegion.image = [UIImage imageNamed:@"tracemark.png"];
    
	// Do any additional setup after loading the view, typically from a nib.    
}


//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.camera startRunning];
//}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.camera startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.camera stopRunning];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) foundBarcodeWithString: (NSString *) barcodeString{
    [self.camera stopRunning];
    double delayInSeconds = 0.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    NSLog(@"TEST:  %@", barcodeString);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[[UIAlertView alloc] initWithTitle:@"QRCode found" message:barcodeString delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    });
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.camera startRunning];

}




- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
