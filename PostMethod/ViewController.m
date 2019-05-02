//
//  ViewController.m
//  PostMethod
//
//  Created by Monish Chopra on 14/11/18.
//  Copyright © 2018 Monish Chopra. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import <AFNetworking.h>
#import <AFHTTPSessionManager.h>

@interface ViewController ()
{
    NSString *dataString;
    NSString *convertString;
    UIImagePickerController *picker;
    NSData *imageData;
    NSString *TrimBase64String;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    [self.view addSubview:_scrollView];
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size
                                           .width, self.view.frame.size.height * 1.5)];
    [_scrollView addSubview:_txt_firstname];
    [_scrollView addSubview:_txt_lastname];
    [_scrollView addSubview:_txt_email];
    [_scrollView addSubview:_txt_contact];
    [_scrollView addSubview:_txt_password];
    [_scrollView addSubview:_img_user];
    [_scrollView addSubview:_btn_camera];
    [_scrollView addSubview:_btn_signup];
    picker.delegate = self;
    NSLog(@"the sample string is %@",_str);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)postMethod
{
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://photocollage.devmantech.com/ws_users/signup"]];
    NSString *str_firstname = _txt_firstname.text;
    NSString *str_lastname = [_txt_lastname text];
    NSString *str_email = [_txt_email text];
    NSString *int_contact = [_txt_contact text];
    NSString  *str_password = [_txt_password text];
    NSString *int_fcmid = @"123456";
    NSString *userUpdate =[NSString stringWithFormat:@"firstname=%@&lastname=%@&email=%@&contact_no=%@&password=%@&fcm_id=%@&profile_img=%@",str_firstname,str_lastname,str_email,int_contact,str_password,int_fcmid,convertString];
    NSLog(@" body string is %@",userUpdate);
    
    //create the Method "GET" or "POST"
      [urlRequest setHTTPMethod:@"POST"];
    //Convert the String to Data
     NSData *data1 = [userUpdate dataUsingEncoding:NSUTF8StringEncoding];
     [urlRequest setHTTPBody:data1];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSLog(@"The response is - %@",responseDictionary);
            NSInteger success = [[responseDictionary objectForKey:@"success"] integerValue];
            if(success == 1)
            {
                NSLog(@"Login SUCCESS");
           //     [alert1 show];
            }
            else
            {
                NSLog(@"Login FAILURE...%@",httpResponse);
         //       [alert show];
            }
    }];
    [dataTask resume];
}

-(void)post_UpdateClientProfile{
    
    NSString *imgBase64 = dataString;
    NSString *URLString = @"http://photocollage.devmantech.com/ws_users/signup";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_txt_firstname.text,@"firstname",@"last",@"lastname",@"test@test.com",@"email",@"6665745455722",@"contact_no",@"testpass",@"password",@"12345",@"fcm_id",imgBase64,@"profile_img", nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",myTokenString] forHTTPHeaderField: @"Authorization"];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject){
        NSLog(@"%@",responseObject);
        
   //     imgvProfile.image=uploadImage;
        
        NSString *strResponse = [NSString stringWithFormat:@"%@",responseObject];
        if (strResponse.length>0)
        {
            UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Success!", nil)] message:[NSString stringWithFormat:NSLocalizedString(@"Profile Updated Successfully!", nil)] delegate:self cancelButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:NSLocalizedString(@"OK", nil)],nil];
            [alert3 setTag:98];
            [alert3 show];
        }
        else
        {
            UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Warning!", nil)] message:[NSString stringWithFormat:NSLocalizedString(@"Something went wrong. Please try again.", nil)] delegate:self cancelButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:NSLocalizedString(@"OK", nil)],nil];
            [alert3 show];
        }
        
    } failure:^(NSURLSessionDataTask  *sessiontask, NSError *error)  {
        NSLog(@"%@",error.localizedDescription);
        UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Warning!", nil)] message:[NSString stringWithFormat:NSLocalizedString(@"Something went wrong. Please try again.", nil)] delegate:self cancelButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:NSLocalizedString(@"OK", nil)],nil];
        [alert3 show];
        
    }];
    
}

- (IBAction)btn_signup_action:(id)sender
{
     //   [self post_UpdateClientProfile];
          [self postMethod];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_txt_firstname resignFirstResponder];
    [_txt_lastname resignFirstResponder];
    [_txt_password resignFirstResponder];
    [_txt_email resignFirstResponder];
    [_txt_contact resignFirstResponder];
    return YES;
}

- (IBAction)btn_photo_access_action:(id)sender
{
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    CGSize newSizeClient=CGSizeMake(900,900); // I am giving resolution 50*50 , you can change your need
    UIGraphicsBeginImageContext(newSizeClient);
    [chosenImage drawInRect:CGRectMake(0, 0, newSizeClient.width, newSizeClient.height)];
    UIImage* newImageClient = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
      imageData = [[NSData alloc]initWithData:UIImageJPEGRepresentation(newImageClient,0.5)];
      dataString = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
     convertString = [dataString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSLog(@"data string is..%@",convertString);
      NSLog(@"%@",info);
    self.img_user.image = newImageClient;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end


//{
//    UIImagePickerControllerCropRect = "NSRect: {{0, 186}, {750, 750}}";
//    UIImagePickerControllerEditedImage = "<UIImage: 0x282b3c460> size {750, 750} orientation 0 scale 1.000000";
//    UIImagePickerControllerImageURL = "file:///private/var/mobile/Containers/Data/Application/01A7E4CB-8847-40C8-94A2-D95D9B679228/tmp/7532D112-7EEB-47F4-A2F7-546FDCF7E134.png";
//    UIImagePickerControllerMediaType = "public.image";
//    UIImagePickerControllerOriginalImage = "<UIImage: 0x282b3dab0> size {750, 1334} orientation 0 scale 1.000000";
//    UIImagePickerControllerReferenceURL = "assets-library://asset/asset.PNG?id=D79F6FDF-FE27-49A3-B45A-2F171D80EAA8&ext=PNG";

//UIImagePickerControllerImageURL = "file:///private/var/mobile/Containers/Data/Application/F7D9D462-34B1-4A32-818A-CD314F1BC31D/tmp/F18D46B4-7300-46D4-BD33-7821528F7CA7.jpeg";
//UIImagePickerControllerMediaType = "public.image";
//UIImagePickerControllerOriginalImage = "<UIImage: 0x2826cc2a0> size {2448, 3264} orientation 3 scale 1.000000";
//UIImagePickerControllerReferenceURL = "assets-library://asset/asset.JPG?id=369EBC0E-3450-41B9-9BE0-FF4C9144E024&ext=JPG";
