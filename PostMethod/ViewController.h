//
//  ViewController.h
//  PostMethod
//
//  Created by Monish Chopra on 14/11/18.
//  Copyright © 2018 Monish Chopra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *txt_firstname;
@property (strong, nonatomic) IBOutlet UITextField *txt_lastname;
@property (strong, nonatomic) IBOutlet UITextField *txt_email;
@property (strong, nonatomic) IBOutlet UITextField *txt_contact;
@property (strong, nonatomic) IBOutlet UITextField *txt_password;
- (IBAction)btn_signup_action:(id)sender;

- (IBAction)btn_photo_access_action:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *img_user;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *btn_camera;
@property (strong, nonatomic) IBOutlet UIButton *btn_signup;
@property(strong,nonatomic)NSString *str;

@end

