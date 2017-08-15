//
//  ViewController.m
//  WXPayDemo
//
//  Created by wjl on 2017/8/14.
//  Copyright © 2017年 wjl. All rights reserved.
//

#import "ViewController.h"
#import "WXApi.h"
#import "AFNetworking.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)wxPay:(id)sender {
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * parmas = [NSMutableDictionary dictionary];
    [parmas setObject:@"大学帮-商城消费" forKey:@"body"];
    [parmas setObject:@"test" forKey:@"detail"];
    [parmas setObject:@"我买商品" forKey:@"attach"];
    [parmas setObject:@"123120170814211851" forKey:@"out_trade_no"];
    [parmas setObject:@(1) forKey:@"total_fee"];
    [manger POST:@"http://119.23.136.162/dxbpay/wechatpay?" parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"result === %@", responseObject);
        PayReq *request = [[PayReq alloc] init];
        request.openID = [responseObject objectForKey:@"appid"];
        request.partnerId = [responseObject objectForKey:@"mch_id"];
        request.prepayId= [responseObject objectForKey:@"prepay_id"];
        request.package = [responseObject objectForKey:@"packageValue"];
        request.nonceStr= [responseObject objectForKey:@"nonce_str"];
        request.timeStamp= (UInt32)[[responseObject objectForKey:@"timestamp"] integerValue];
        request.sign= [responseObject objectForKey:@"sign"];;
        [WXApi sendReq:request];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
