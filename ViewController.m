//
//  ViewController.m
//  Clarify_PhotoAPI
//
//  Created by Tecksky Techonologies on 12/24/16.
//  Copyright © 2016 Tecksky Technologies. All rights reserved.
//

#import "ViewController.h"
#import "ClarifaiApp.h"
#import "TableViewCell.h".
#import "ProgressHUD.h"
#import "CustomIOSAlertView.h"
@interface ViewController ()< UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *tags;
    CustomIOSAlertView *alertView;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;


@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;
@property (weak, nonatomic) IBOutlet UIButton *button;


@property (strong, nonatomic) ClarifaiApp *app;

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrlview.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlview.contentSize = contentRect.size;

    
     tags = [[NSMutableArray alloc] init];
    _button.layer.cornerRadius = 23.0;

    

}

- (IBAction)buttonPressed:(id)sender
{
    alertView = [[CustomIOSAlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"CLOSE", nil]];
    [alertView setDelegate:self];
    [alertView setTintColor:[UIColor redColor]];
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView show];
   // _viewGallary.hidden = NO;
}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}

- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 160)];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 380, 40)];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    title.text = @"CHOOSE IMAGE FROM";
    title.textColor = [UIColor colorWithRed:0/255.0f green:84/255.0f blue:164/255.0f alpha:1.0f];
    
    [demoView addSubview:title];
    
     UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(0, 45, 400, 0.5)];
     [devider setBackgroundColor:[UIColor colorWithRed:0/255.0f green:84/255.0f blue:164/255.0f alpha:1.0f]];
     [demoView addSubview:devider];
    
    UIButton *Camera = [UIButton buttonWithType:UIButtonTypeCustom];
    [Camera setFrame:CGRectMake(10,60 , 380, 40)];
    //Camera.backgroundColor = [UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f];
    [Camera setBackgroundColor:[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]];
     // _border1.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];
    [Camera addTarget:self action:@selector(CameraDialog:) forControlEvents:UIControlEventTouchDown];
    [Camera setTitle:@"CAMERA" forState:UIControlStateNormal];
    [Camera setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Camera.layer setBorderWidth:0];
     Camera.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [Camera.layer setCornerRadius:15];
   
    [demoView addSubview:Camera];
 
    UIButton *Gallary = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [Gallary setFrame:CGRectMake(10,110 , 380, 40)];
     Gallary.layer.backgroundColor = [[UIColor redColor] CGColor];
    [Gallary addTarget:self action:@selector(GallaryDialog:) forControlEvents:UIControlEventTouchDown];
    [Gallary setTitle:@"GALLERY" forState:UIControlStateNormal];
    [Gallary setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Gallary.layer setBorderWidth:0];
    Gallary.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [Gallary.layer setCornerRadius:15];
    [demoView addSubview:Gallary];
    return demoView;
}

- (IBAction)CameraDialog:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        
        [self presentModalViewController:picker animated:YES];
        [alertView setHidden:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Camera Unavailable"
                                                       message:@"Unable to find a camera on your device."
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
        
    }
}

- (IBAction)GallaryDialog:(id)sender
{
    NSLog(@"gallary");
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];

      [alertView setHidden:YES];
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    
//    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
//    self.imageView.image = chosenImage;
//    
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//    
//}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (image) {
        // The user picked an image. Send it to Clarifai for recognition.
        
        self.imageView.image = image;
       // self.textView.text = @"Recognizing...";
        [ProgressHUD show:@"Please wait..."];
        self.button.enabled = NO;
        [self recognizeImage:image];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tags count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.lbltag.text = [NSString stringWithFormat:@"%@",[[tags objectAtIndex:indexPath.row] uppercaseString]];
    _table.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];
    _table.layer.borderWidth= 2.0f;
    _table.layer.cornerRadius = 15.0;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *searchUrl = [NSString stringWithFormat:@"http://www.google.com/#q=%@",[tags objectAtIndex:indexPath.row]];
    
    NSURL *url = [NSURL URLWithString:searchUrl];
    
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }

}
- (void)recognizeImage:(UIImage *)image {
    
    // Initialize the Clarifai app with your app's ID and Secret.
    ClarifaiApp *app = [[ClarifaiApp alloc] initWithAppID:@"VqbRvVMvl4FqbP2b6q3EGOdSwaOGZRAPXMmLRTL5"
                                                appSecret:@"HuplowPo__D60zihpR4k_8JM7aU53_qD8uGCneLd"];
    
    // Fetch Clarifai's general model.
    [app getModelByName:@"general-v1.3" completion:^(ClarifaiModel *model, NSError *error) {
        // Create a Clarifai image from a uiimage.
        ClarifaiImage *clarifaiImage = [[ClarifaiImage alloc] initWithImage:image];
        
        // Use Clarifai's general model to pedict tags for the given image.
        [model predictOnImages:@[clarifaiImage] completion:^(NSArray<ClarifaiOutput *> *outputs, NSError *error) {
            if (!error) {
                ClarifaiOutput *output = outputs[0];
                
                // Loop through predicted concepts (tags), and display them on the screen.
                tags = [NSMutableArray array];
                for (ClarifaiConcept *concept in output.concepts) {
                    [tags addObject:concept.conceptName];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_table reloadData];
                   self.textView.text = @"Tags";
                    
                    self.button.enabled = YES;
                    [ProgressHUD dismiss];
                });
            }
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
