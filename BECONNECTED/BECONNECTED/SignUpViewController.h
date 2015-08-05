//
//  SignUpViewController.h
//  BECONNECTED
//
//  Created by indianic on 03/08/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *btnSelectCountry;

@property (weak, nonatomic) IBOutlet UITextField *txt_SelectCountry;
@property (weak, nonatomic) IBOutlet UIView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *txtCountryCode;
@property (weak, nonatomic) IBOutlet UITextField *txtMobieNumber;

@property (weak, nonatomic) IBOutlet UIButton *btnDone;

@property (weak, nonatomic) IBOutlet UIView *verficationView;
@property (weak, nonatomic) IBOutlet UITextView *termsCondTxtView;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

@property (weak, nonatomic) IBOutlet UILabel *mainHeaderlbl;
@property (weak, nonatomic) IBOutlet UIButton *btnVerificationDone;
@property (weak, nonatomic) IBOutlet UIView *numpadViewVeriyCode;
@property (weak, nonatomic) IBOutlet UITextField *txtVerifyCode;

@end
