//
//  OOTextKitViewController.m
//  BaseFramework
//
//  Created by Beelin on 16/12/14.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "OOTextKitController.h"

@interface OOTextKitController ()
@property (nonatomic, strong) UITextView * textView;
@end

@implementation OOTextKitController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self exclusionPaths];
}


/**
 路径排除
 */
- (void)exclusionPaths{
    NSString * str1 = @"asfasfa阿斯顿发生大发撒放大离开家撒旦法按时付款就阿里；双方均asfasdfasfdalkjsflakj阿斯顿发生大发撒旦法asdfasdfaasfdaasa撒旦法；拉斯克奖发了奥斯卡奖罚洛杉矶的法律；看见谁发的阿斯利康就发；了数据库等法律按实际开发；阿里就开始放到了；安家费阿里山科技发达了开始将对方拉开始交电费了卡双方的空间啊发送卡飞机阿里开始就放暑假了罚款就是浪费asfasfa阿斯顿发生大发撒放大离开家撒旦法按时付款就阿里；双方均asfasdfasfdalkjsflakj阿斯顿发生大发撒旦法asdfasdfaasfdaasa撒旦法；拉斯克奖发了奥斯卡奖罚洛杉矶的法律；看见谁发的阿斯利康就发；了数据库等法律按实际开发；阿里就开始放到了；安家费阿里山科技发达了开始将对方拉开始交电费了卡双方的空间啊发送卡飞机阿里开始就放暑假了罚款就是浪费asfasfa阿斯顿发生大发撒放大离开家撒旦法按时付款就阿里；双方均asfasdfasfdalkjsflakj阿斯顿发生大发撒旦法asdfasdfaasfdaasa撒旦法；拉斯克奖发了奥斯卡奖罚洛杉矶的法律；看见谁发的阿斯利康就发；了数据库等法律按实际开发；阿里就开始放到了；安家费阿里山科技发达了开始将对方拉开始交电费了卡双方的空间啊发送卡飞机阿里开始就放暑假了罚款就是浪费";
    
    
    //初始化textLabel
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width - 40, [UIScreen mainScreen].bounds.size.height - 40 - 44 - 20)];
    self.textView.backgroundColor = [UIColor cyanColor];
    self.textView.text = str1;
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.editable = NO;
    [self.view addSubview:self.textView];
    
    //图文混排，设置图片的位置
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 120, 100, 110)];
    imageView.image = [UIImage imageNamed:@"placeholder"];
    imageView.backgroundColor = [UIColor redColor];
    [self.textView addSubview:imageView];
    
    //设置环绕的路径
    UIBezierPath * path = [UIBezierPath bezierPathWithRect: imageView.frame];
    UIBezierPath * path1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 300, 150, 150)];
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    
    self.textView.textContainer.exclusionPaths = @[path,path1];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
