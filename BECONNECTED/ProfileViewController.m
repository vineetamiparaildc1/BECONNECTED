//
//  ProfileViewController.m
//  BECONNECTED
//
//  Created by indianic on 06/08/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ViewController.h"
#import <TwitterKit/TwitterKit.h>
#import "NotificationsViewController.h"
#import "SignUpViewController.h"

@interface ProfileViewController ()
{
    UIImagePickerController *Picker;
    UIPickerView *singlePicker;
    NSArray *pickerArray;
}
@end

@implementation ProfileViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    singlePicker = [[UIPickerView alloc]init];
    singlePicker.delegate=self;
    singlePicker.dataSource=self;
    
    //Picker Array
    {
        pickerArray = [NSArray arrayWithObjects:@"Canada +1",
                       @"China +86",
                       @"France +33",
                       @"Germany +49",
                       @"India +91",
                       @"Japan +81",
                       @"Pakistan +92",
                       @"United Kingdom +44",
                       @"United States +1",
                       @"Abkhazia +7 840",
                       @"Abkhazia +7 940",
                       @"Afghanistan +93",
                       @"Albania +355",
                       @"Algeria +213",
                       @"American Samoa +1 684",
                       @"Andorra +376",
                       @"Angola +244",
                       @"Anguilla +1 264",
                       @"Antigua and Barbuda +1 268",
                       @"Argentina +54",
                       @"Armenia +374",
                       @"Aruba +297",
                       @"Ascension +247",
                       @"Australia +61",
                       @"Australian External Territories +672",
                       @"Austria +43",
                       @"Azerbaijan +994",
                       @"Bahamas +1 242",
                       @"Bahrain +973",
                       @"Bangladesh +880",
                       @"Barbados +1 246",
                       @"Barbuda +1 268",
                       @"Belarus +375",
                       @"Belgium +32",
                       @"Belize +501",
                       @"Benin +229",
                       @"Bermuda +1 441",
                       @"Bhutan +975",
                       @"Bolivia +591",
                       @"Bosnia and Herzegovina +387",
                       @"Botswana +267",
                       @"Brazil +55",
                       @"British Indian Ocean Territory +246",
                       @"British Virgin Islands +1 284",
                       @"Brunei +673",
                       @"Bulgaria +359",
                       @"Burkina Faso +226",
                       @"Burundi +257",
                       @"Cambodia +855",
                       @"Cameroon +237",
                       @"Canada +1",
                       @"Cape Verde +238",
                       @"Cayman Islands + 345",
                       @"Central African Republic +236",
                       @"Chad +235",
                       @"Chile +56",
                       @"China +86",
                       @"Christmas Island +61",
                       @"Cocos-Keeling Islands +61",
                       @"Colombia +57",
                       @"Comoros +269",
                       @"Congo +242",
                       @"Congo, Dem. Rep. of (Zaire) +243",
                       @"Cook Islands +682",
                       @"Costa Rica +506",
                       @"Ivory Coast +225",
                       @"Croatia +385",
                       @"Cuba +53",
                       @"Curacao +599",
                       @"Cyprus +537",
                       @"Czech Republic +420",
                       @"Denmark +45",
                       @"Diego Garcia +246",
                       @"Djibouti +253",
                       @"Dominica +1 767",
                       @"Dominican Republic +1 809",
                       @"Dominican Republic +1 829",
                       @"Dominican Republic +1 849",
                       @"East Timor +670",
                       @"Easter Island +56",
                       @"Ecuador +593",
                       @"Egypt +20",
                       @"El Salvador +503",
                       @"Equatorial Guinea +240",
                       @"Eritrea +291",
                       @"Estonia +372",
                       @"Ethiopia +251",
                       @"Falkland Islands +500",
                       @"Faroe Islands +298",
                       @"Fiji +679",
                       @"Finland +358",
                       @"France +33",
                       @"French Antilles +596",
                       @"French Guiana +594",
                       @"French Polynesia +689",
                       @"Gabon +241",
                       @"Gambia +220",
                       @"Georgia +995",
                       @"Germany +49",
                       @"Ghana +233",
                       @"Gibraltar +350",
                       @"Greece +30",
                       @"Greenland +299",
                       @"Grenada +1 473",
                       @"Guadeloupe +590",
                       @"Guam +1 671",
                       @"Guatemala +502",
                       @"Guinea +224",
                       @"Guinea-Bissau +245",
                       @"Guyana +595",
                       @"Haiti +509",
                       @"Honduras +504",
                       @"Hong Kong SAR China +852",
                       @"Hungary +36",
                       @"Iceland +354",
                       @"India +91",
                       @"Indonesia +62",
                       @"Iran +98",
                       @"Iraq +964",
                       @"Ireland +353",
                       @"Israel +972",
                       @"Italy +39",
                       @"Jamaica +1 876",
                       @"Japan +81",
                       @"Jordan +962",
                       @"Kazakhstan +7 7",
                       @"Kenya +254",
                       @"Kiribati +686",
                       @"North Korea +850",
                       @"South Korea +82",
                       @"Kuwait +965",
                       @"Kyrgyzstan +996",
                       @"Laos +856",
                       @"Latvia +371",
                       @"Lebanon +961",
                       @"Lesotho +266",
                       @"Liberia +231",
                       @"Libya +218",
                       @"Liechtenstein +423",
                       @"Lithuania +370",
                       @"Luxembourg +352",
                       @"Macau SAR China +853",
                       @"Macedonia +389",
                       @"Madagascar +261",
                       @"Malawi +265",
                       @"Malaysia +60",
                       @"Maldives +960",
                       @"Mali +223",
                       @"Malta +356",
                       @"Marshall Islands +692",
                       @"Martinique +596",
                       @"Mauritania +222",
                       @"Mauritius +230",
                       @"Mayotte +262",
                       @"Mexico +52",
                       @"Micronesia +691",
                       @"Midway Island +1 808",
                       @"Micronesia +691",
                       @"Moldova +373",
                       @"Monaco +377",
                       @"Mongolia +976",
                       @"Montenegro +382",
                       @"Montserrat +1664",
                       @"Morocco +212",
                       @"Myanmar +95",
                       @"Namibia +264",
                       @"Nauru +674",
                       @"Nepal +977",
                       @"Netherlands +31",
                       @"Netherlands Antilles +599",
                       @"Nevis +1 869",
                       @"New Caledonia +687",
                       @"New Zealand +64",
                       @"Nicaragua +505",
                       @"Niger +227",
                       @"Nigeria +234",
                       @"Niue +683",
                       @"Norfolk Island +672",
                       @"Northern Mariana Islands +1 670",
                       @"Norway +47",
                       @"Oman +968",
                       @"Pakistan +92",
                       @"Palau +680",
                       @"Palestinian Territory +970",
                       @"Panama +507",
                       @"Papua New Guinea +675",
                       @"Paraguay +595",
                       @"Peru +51",
                       @"Philippines +63",
                       @"Poland +48",
                       @"Portugal +351",
                       @"Puerto Rico +1 787",
                       @"Puerto Rico +1 939",
                       @"Qatar +974",
                       @"Reunion +262",
                       @"Romania +40",
                       @"Russia +7",
                       @"Rwanda +250",
                       @"Samoa +685",
                       @"San Marino +378",
                       @"Saudi Arabia +966",
                       @"Senegal +221",
                       @"Serbia +381",
                       @"Seychelles +248",
                       @"Sierra Leone +232",
                       @"Singapore +65",
                       @"Slovakia +421",
                       @"Slovenia +386",
                       @"Solomon Islands +677",
                       @"South Africa +27",
                       @"South Georgia and the South Sandwich Islands +500",
                       @"Spain +34",
                       @"Sri Lanka +94",
                       @"Sudan +249",
                       @"Suriname +597",
                       @"Swaziland +268",
                       @"Sweden +46",
                       @"Switzerland +41",
                       @"Syria +963",
                       @"Taiwan +886",
                       @"Tajikistan +992",
                       @"Tanzania +255",
                       @"Thailand +66",
                       @"Timor Leste +670",
                       @"Togo +228",
                       @"Tokelau +690",
                       @"Tonga +676",
                       @"Trinidad and Tobago +1 868",
                       @"Tunisia +216",
                       @"Turkey +90",
                       @"Turkmenistan +993",
                       @"Turks and Caicos Islands +1 649",
                       @"Tuvalu +688",
                       @"Uganda +256",
                       @"Ukraine +380",
                       @"United Arab Emirates +971",
                       @"United Kingdom +44",
                       @"United States +1",
                       @"Uruguay +598",
                       @"U.S. Virgin Islands +1 340",
                       @"Uzbekistan +998",
                       @"Vanuatu +678",
                       @"Venezuela +58",
                       @"Vietnam +84",
                       @"Wake Island +1 808",
                       @"Wallis and Futuna +681",
                       @"Yemen +967",
                       @"Zambia +260",
                       @"Zanzibar +255",
                       @"Zimbabwe +263",nil];
    }
    

    self.scrView.contentSize = CGSizeMake(self.scrView.frame.size.width, 820);
    self.scrView.delegate = self;

    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"LoginProfile"];
    
    
    if([savedValue isEqualToString:@"Facebook"])
    {
        [self getFbInfo];
    }
    else if ([savedValue isEqualToString:@"Twitter"])
    {
        [self getTWInfo];
    }
    
    if([savedValue isEqualToString:@"NewUser"])
    {
        _lblMobileNumber.text=_strMobileNumber;
        _lblMobileNumber.hidden=FALSE;
        _btn_SelectCountry.hidden=TRUE;
        _txt_selectCountry.hidden=TRUE;
        _txtMobileNum.hidden=TRUE;
        
    }
    else
    {
        
        _lblMobileNumber.hidden=TRUE;
        _btn_SelectCountry.hidden=FALSE;
        _txt_selectCountry.hidden=FALSE;
        _txtMobileNum.hidden=FALSE;
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btn_backClicked:(id)sender
{
   /* NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"LoginProfile"];
    
    
    if([savedValue isEqualToString:@"Facebook"] || [savedValue isEqualToString:@"Facebook"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if ([savedValue isEqualToString:@"NewUser"]) {
        
        
    }
    */
    [[NSUserDefaults standardUserDefaults] setObject:@" " forKey:@"LoginProfile"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)UpdateButtonClicked:(id)sender
{
        
    // [self performSegueWithIdentifier:@"pushview" sender:nil];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Required Field" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    if([_txt_selectCountry.text isEqualToString:@" "] || _txt_selectCountry.text.length == 0)
    {
        alert.message=@"Please Enter CountryName";
        [alert show];
    }
    else if([_txtMobileNum.text isEqualToString:@" "] || _txtMobileNum.text.length == 0)
    {
        alert.message=@"Please Enter MobileNumber";
        [alert show];
    }
    else if([_txtFullName.text isEqualToString:@" "] || _txtFullName.text.length == 0)
    {
        alert.message=@"Please Enter FirstName";
        [alert show];
    }
    else if([_txtStatus.text isEqualToString:@" "] || _txtStatus.text.length == 0)
    {
        alert.message=@"Please Enter FirstName";
        [alert show];
    }
    else if ([_txtEmailID.text isEqualToString:@" "] || _txtEmailID.text.length == 0)
    {
        alert.message=@"Please Enter Email-ID";
        [alert show];
    }
    else if ([_txt_UserName.text isEqualToString:@" "] || _txt_UserName.text.length == 0)
    {
        alert.message=@"Please Enter Username";
        [alert show];
    }
    
    else if ([_txt_Password.text isEqualToString:@" "] || _txt_Password.text.length == 0)
    {
        alert.message=@"Please Enter Password";
        [alert show];
    }
    
    else{
        
        //NSDictionary *temp= result;
        PFUser *user=[PFUser user];
        user.username = _txt_UserName.text;
        user.password = _txt_Password.text;
        user.email =  _txtEmailID.text;
        
        
        NSString *Temp = _txt_selectCountry.text;
        NSArray *temparr = [Temp componentsSeparatedByString:@"+"];
        NSLog(@"%@",temparr);
        
        Temp = [NSString stringWithFormat:@"+%@",[temparr objectAtIndex:1]];
        NSLog(@"%@",Temp);
        
        
        
        
        
        [user setObject:[temparr objectAtIndex:0] forKey:@"countryname"];
        [user setObject:Temp forKey:@"countrycode"];
        [user setObject:_txtMobileNum.text forKey:@"mobileno"];
        [user setObject:_txtFullName.text forKey:@"fullname"];
        [user setObject:_txtStatus.text forKey:@"status"];
        
        if (_seg_Gender.selectedSegmentIndex == 0)
        {
            [user setObject:@"Male" forKey:@"gender"];
        }
        else
        {
            [user setObject:@"Female" forKey:@"gender"];
        }
        
        
        
        [user signUpInBackgroundWithBlock:^(BOOL success,NSError *error)
         {
             if (success)
             {
                 NSLog(@"User Saved");
                 {
                     //Getting FBImageUrl From Dictionary Results
                     //                             NSMutableDictionary *DicFbImageUrl = result;
                     //                             DicFbImageUrl = [DicFbImageUrl objectForKey:@"picture"];
                     //                             DicFbImageUrl = [DicFbImageUrl objectForKey:@"data"];
                     //                             NSString *StrFbImageUrl = [DicFbImageUrl objectForKey:@"url"];
                     //
                     //
                     //
                     //                             NSURL *imageURL = [NSURL URLWithString:StrFbImageUrl];
                     //                             NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                     //                             UIImage *image = [UIImage imageWithData:imageData];
                     //
                     //                             [_btnProfilePic setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:StrFbImageUrl]]] forState:(UIControlState)nil];
                     //
                     //
                     //                             //For getting image name for PFFileName
                     //                             NSArray *temparr = [StrFbImageUrl componentsSeparatedByString:@"/"];
                     //                             StrFbImageUrl = [temparr lastObject];
                     //                             temparr = [StrFbImageUrl componentsSeparatedByString:@"?"];
                     
                     UIImage *image = _btnProfilePic.imageView.image;
                     NSData *imageData = UIImageJPEGRepresentation(image,1.0);
                     PFFile *imageFile = [PFFile fileWithName:@"ProfilePic" data:imageData];
                     [user setObject:imageFile forKey:@"profilepic"];
                     
                     
                     [imageFile saveInBackground];
                     
                     [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
                      {
                          if (!error)
                          {
                              ViewController *obj  =[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                            [self presentViewController:obj animated:YES completion:nil];
                              
                          }
                      }];
                     
                     
                     
                 }
                 
             }
             else
             {
                 
                 
             }
             
         }];
        
        
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self scrollViewToCenterOfScreen:textField];
    
        if (textField.tag == 10)
        {
            self.txt_selectCountry.inputView = singlePicker;
            _pickerView.hidden=FALSE;
        }
        if (textField.tag == 11)
        {
            _pickerView.hidden=FALSE;
        }
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerArray.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pickerArray objectAtIndex:row];
}


- (IBAction)btnDoneClicked:(id)sender
{
    
    _pickerView.hidden=TRUE;
    
    if ((_txtMobileNum.keyboardType=UIKeyboardTypePhonePad))
    {
        
    }
    
    if ((_txt_selectCountry.inputView=singlePicker))
    {
        NSInteger row = [singlePicker selectedRowInComponent:0];
        NSString *Temp = [pickerArray objectAtIndex:row];
        
        [_btn_SelectCountry.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_btn_SelectCountry setTitle:Temp forState:UIControlStateNormal];
        _txt_selectCountry.text=Temp;
        
        
    }
    
    [_txt_selectCountry resignFirstResponder];
    [_txtMobileNum resignFirstResponder];
    
}

-(void)scrollViewToCenterOfScreen:(UIView *)theView
{
    CGFloat viewCenterY = theView.center.y;
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    CGFloat availableHeight = applicationFrame.size.height; // Remove area covered by keyboard
    
    CGFloat y = viewCenterY - availableHeight / 2.0;
    if (y < 0) {
        y = 0;
    }
    [_scrView setContentOffset:CGPointMake(0, y) animated:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    [self.scrView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    UIAlertView *AletView = [[UIAlertView alloc]initWithTitle:@"Dear User" message:@"Please Enter Valid Email Address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if ([emailTest evaluateWithObject:_txtEmailID.text] == NO && textField.tag==12)
    {
        [AletView show];
    }
    
    return YES;

}


- (IBAction)btnProfilePicClicked:(id)sender {
    
    Picker = [[UIImagePickerController alloc] init];
    [Picker setDelegate:self];
    Picker.allowsEditing = YES;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take photo", @"Choose Existing", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        Picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    else if (buttonIndex == 0) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    else if (buttonIndex == 1)
    {
        Picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:Picker animated:YES completion:NULL];
    }
    
    
    //[actionSheet release];;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *origionalImage =[info objectForKey:UIImagePickerControllerEditedImage];
    
    [_btnProfilePic setImage:origionalImage forState:(UIControlState)nil];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    NSURL *imageURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    NSLog(@"URL = %@",imageURL);
    
    PFUser *user = [PFUser currentUser];
    NSData *imageData = UIImageJPEGRepresentation(origionalImage,1.0);
    PFFile *imageFile = [PFFile fileWithName:@"ProfilePic.jpg" data:imageData];
    [imageFile saveInBackground];
    
    [user setObject:imageFile forKey:@"profilepic"];
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (!error)
        {
            
            
        }
    }];
    
    
}



-(void)getFbInfo
{
    
    [[[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:@{@"fields":@"id,name,picture.type(large),email,birthday, bio,location"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (!error)
        {
            NSLog(@"Result = %@",result);
            NSMutableDictionary *DicFbImageUrl = result;

            _txt_UserName.text= [DicFbImageUrl objectForKey:@"name"];
            _txt_UserName.enabled=FALSE;
            
            DicFbImageUrl = [DicFbImageUrl objectForKey:@"picture"];
            DicFbImageUrl = [DicFbImageUrl objectForKey:@"data"];
            NSString *StrFbImageUrl = [DicFbImageUrl objectForKey:@"url"];
            
            [_btnProfilePic setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:StrFbImageUrl]]] forState:(UIControlState)nil];
            
        }
    }];
    
}


-(void)getTWInfo
{
    
    [[[Twitter sharedInstance] APIClient] loadUserWithID:[[[Twitter sharedInstance] session] userID]
                                              completion:^(TWTRUser *user,
                                                           NSError *error)
     {
         
         if (![error isEqual:nil])
         {
             
             _txt_UserName.text=[NSString stringWithFormat:@"%@",user];
             _txt_UserName.enabled=FALSE;
             
             _txtFullName.text = user.name;
             _txtFullName.enabled=FALSE;
             
             [_btnProfilePic setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user.profileImageLargeURL]]] forState:(UIControlState)nil];
         }
         
     }];
}

@end
