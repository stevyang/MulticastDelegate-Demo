//
//  ViewController.m
//  MulticastDelegate-Demo
//
//  Created by yangyang on 15/8/9.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "ViewController.h"
#import "MulticastDelegateBaseObject.h"

//继承自多播委托基类的userInfo类
@interface DataInfo : MulticastDelegateBaseObject
@property (nonatomic,strong)NSString *datavalue;
@end

@implementation DataInfo
-(void)setUserName:(NSString *)value{
    _datavalue=value;
    [multicastDelegate setText:value];//调用多播委托
}
@end


@interface ViewController (){
    DataInfo *dataInfo;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化一个datainfo的实例
    dataInfo=[[DataInfo alloc] init];
    
    //添加一个lable
    UILabel *lable =[[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 30)];
    lable.backgroundColor=[UIColor blueColor];
    lable.textColor=[UIColor blackColor];
    [dataInfo addDelegate:lable delegateQueue:dispatch_get_main_queue()];//向多播委托注册
    [self.view addSubview:lable];
    
    lable =[[UILabel alloc] initWithFrame:CGRectMake(0, 60, 100, 30)];
    lable.backgroundColor=[UIColor blueColor];
    lable.textColor=[UIColor blackColor];
    [dataInfo addDelegate:lable delegateQueue:dispatch_get_main_queue()];
    [self.view addSubview:lable];
    
    
    //添加一个按钮
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(200, 20, 100, 50)];
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn setTitle:@"button1" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnCLicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)btnCLicked:(UIButton *)btn{
    dataInfo.userName=@"test";//给datainfo赋值
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
