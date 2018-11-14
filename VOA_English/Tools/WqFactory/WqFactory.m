//
//  WqFactory.m
//  WQFactory
//
//  Created by 飞雀 on 16/4/27.
//  Copyright © 2016年 hapii. All rights reserved.
//

#import "WqFactory.h"

//#define IOS7   [[UIDevice currentDevice]systemVersion].floatValue>=7.0
@implementation WqFactory



+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text
{
    
    
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    //限制行数
    label.numberOfLines=0;
    //对齐方式
    label.textAlignment=NSTextAlignmentLeft;
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:font];
    //单词折行
    label.lineBreakMode=NSLineBreakByWordWrapping;
    //默认字体颜色是白色
    label.textColor=[UIColor blackColor];
    //自适应（行数~字体大小按照设置大小进行设置）
    label.adjustsFontSizeToFitWidth=YES;
    label.text=text;
    return label;
}
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
   
   
    
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(10,7, frame.size.height-20, frame.size.height-20)];
    iv.image = [UIImage imageNamed:imageName];
    [button addSubview:iv];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iv.frame), 0, frame.size.width-iv.frame.size.width, frame.size.height)];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.text = title;
    label.textColor = [UIColor blackColor];
    
    [button addSubview:label];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
    
}

+(UIBarButtonItem *)createBarButtonItemWithFrame:(CGRect)frame ImageName:(NSString *)imageName Target:(id)target Action:(SEL)action Title:(NSString *)title{
    
    //改变导航条的颜色
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    
    but.frame = frame;
    but.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [but setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    
    
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [but addTarget:target action:(SEL)action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *butItem = [[UIBarButtonItem alloc] initWithCustomView:but];
    
    return butItem;




}

+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName
{
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:frame];
    imageView.image=[UIImage imageNamed:imageName];
    imageView.userInteractionEnabled=YES;
    return imageView ;
}
+(UIView*)viewWithFrame:(CGRect)frame
{
    UIView*view=[[UIView alloc]initWithFrame:frame];
    
    return view ;
    
}

#pragma  mark 适配器方法
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font backgRoundImageName:(NSString*)imageName
{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    //灰色提示框
    textField.placeholder=placeholder;
    //文字对齐方式
    textField.textAlignment=NSTextAlignmentLeft;
    textField.secureTextEntry=YESorNO;
    //边框
    //textField.borderStyle=UITextBorderStyleLine;
    //键盘类型
    textField.keyboardType=UIKeyboardTypeEmailAddress;
    //关闭首字母大写
    textField.autocapitalizationType=NO;
    //清除按钮
    textField.clearButtonMode=YES;
    //左图片
    textField.leftView=imageView;
    textField.leftViewMode=UITextFieldViewModeAlways;
    //右图片
    textField.rightView=rightImageView;
    //编辑状态下一直存在
    textField.rightViewMode=UITextFieldViewModeWhileEditing;
    //自定义键盘
    //textField.inputView
    //字体
    textField.font=[UIFont systemFontOfSize:font];
    //字体颜色
    textField.textColor=[UIColor blackColor];
    
    textField.background=[UIImage imageNamed:imageName];
    return  textField;
    
}

@end
