//
//  ViewController.m
//  openSSLDemo
//
//  Created by 范云飞 on 2017/10/28.
//  Copyright © 2017年 范云飞. All rights reserved.
//

#import "ViewController.h"

/* openssl加密 */
#import "OpenSSL.h"


@interface ViewController ()
@property (strong, nonatomic) UITextField * inputTextField;    /* 输入框 */
@property (strong, nonatomic) UILabel * md5Label;              /* md5加密结果 */
@property (strong, nonatomic) UILabel * sh256Label;            /* sh256加密结果 */
@end

@implementation ViewController

#pragma mark - Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self Create_UI];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UI
- (void)Create_UI
{
    self.inputTextField= [[UITextField alloc]init];
    CGRect inputTextFieldFrame = CGRectMake((self.view.frame.size.width - 300)/2, 100, 300, 30);
    self.inputTextField.frame = inputTextFieldFrame;
    self.inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputTextField.placeholder = @"请输入";
    self.inputTextField.returnKeyType = UIReturnKeyDone;
    self.inputTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.inputTextField.backgroundColor = [UIColor whiteColor];
    self.inputTextField.textColor = [UIColor grayColor];
    self.inputTextField.textAlignment = NSTextAlignmentLeft;
    [self.inputTextField addTarget:self action:@selector(calculateHash) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.inputTextField];
    
    self.md5Label = [[UILabel alloc]init];
    CGRect md5LabelFrame = CGRectMake((self.view.frame.size.width - 300)/2, CGRectGetMaxY(self.inputTextField.frame) + 50, 300, 100);
    self.md5Label.frame = md5LabelFrame;
    self.md5Label.text = @"md5加密结果";
    self.md5Label.layer.borderWidth = 1;
    self.md5Label.layer.borderColor = [UIColor blackColor].CGColor;
    self.md5Label.textColor = [UIColor blackColor];
    self.md5Label.numberOfLines = 0;
    self.md5Label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.md5Label];

    self.sh256Label = [[UILabel alloc]init];
    CGRect sh256LabelFrame = CGRectMake((self.view.frame.size.width - 300)/2, CGRectGetMaxY(self.md5Label.frame) + 50, 300, 100);
    self.sh256Label.frame = sh256LabelFrame;
    self.sh256Label.text = @"sh256加密结果";
    self.sh256Label.layer.borderWidth = 1;
    self.sh256Label.layer.borderColor = [UIColor blackColor].CGColor;
    self.sh256Label.textColor = [UIColor blackColor];
    self.sh256Label.numberOfLines = 0;
    self.sh256Label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.sh256Label];
}

#pragma mark - Private
- (void)calculateHash
{
    if (self.inputTextField.text.length != 0)
    {
        self.md5Label.text = [OpenSSL md5FromString:self.inputTextField.text];
        self.sh256Label.text = [OpenSSL sha256FromString:self.inputTextField.text];
        NSLog(@"md5String:%@",self.md5Label.text);
        NSLog(@"sh256String:%@",self.sh256Label.text);
    }
    else
    {
        self.md5Label.text = nil;
        self.sh256Label.text = nil;
    }
}

@end
