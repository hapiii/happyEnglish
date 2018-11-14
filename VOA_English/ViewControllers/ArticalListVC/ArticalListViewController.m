//
//  ArticalListViewController.m
//  VOA_English
//
//  Created by 王强 on 17/3/8.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "ArticalListViewController.h"
//最后一级的列表页，文章列表
@interface ArticalListViewController ()

@end

@implementation ArticalListViewController

- (ArticalTableView *)tb{
    
    if (_tb==nil) {
        _tb = [[ArticalTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT-64) style:UITableViewStylePlain];
    }
    
    __weak typeof(self) wself = self;
    //点击cell跳转
    
    _tb.ArticalTableViewSelectCell = ^(NSString *ListTitle){
//        ArticalListViewController *vc = [[ArticalListViewController alloc] init];
//        vc.ListTitle  = ListTitle;
//        [wself presentViewController:vc animated:YES completion:^{
//            
//        }];
    };
    
    _tb.ListArr = self.dataSource;
    return _tb;
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
  
    [self createNav];
    [self createFresh];
    //http://www.51voa.com/VOA_Standard_1.html
    
    self.dataSource = [[RequestTool shareTool] getTehListofTheUrlType:[NSString stringWithFormat:@"%@%@",VoaEnglish,_Url]];
    
    [self.view addSubview:self.tb];
    
}

- (void)createFresh{
    //上拉刷新
    self.tb.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
    }];
    //下拉加载
    self.tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
    }];
}
- (void)createNav{
    
    NavView *nav = [[NavView alloc] init];
    nav.leftButClick = ^(){
        NSLog(@"点击了左");
    };
    nav.navtitleLabel.text = self.ListTitle;
    nav.rightButClick = ^(){
        NSLog(@"点击了右");
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    [self.view addSubview:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
