//
//  DetailViewController.m
//  VOA_English
//
//  Created by 王强 on 17/3/13.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "DetailViewController.h"
#import "EnglishPlayer.h"
#import "webView.h"
#define kLeftViewWidth SCREEN_WIDTH*0.6

static NSString * const ListCellID = @"ListCellID";

@interface DetailViewController ()

@end

@implementation DetailViewController{
   
    EnglishPlayer *playerView;
    
}
- (UITableView *)tb{
    
    if (_tb==nil) {
        _tb = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREENH_HEIGHT-44) style:UITableViewStylePlain];
        _tb.dk_backgroundColorPicker = DKColorPickerWithRGB(0xf0f0f0, 0x000000, 0xfafafa);
        _tb.delegate = self;
        _tb.dataSource = self;
        _tb.separatorStyle = NO;//去掉分割线
        _tb.estimatedRowHeight = 379.0f;
        _tb.rowHeight = UITableViewAutomaticDimension;
        _tb.dk_backgroundColorPicker = DKColorPickerWithRGB(0xf0f0f0, 0x000000, 0xfafafa);
        [_tb registerNib:[UINib nibWithNibName:NSStringFromClass([ListCell class]) bundle:nil] forCellReuseIdentifier:ListCellID];//一张图片
        

    }
    return _tb;
}
- (void)viewWillDisappear:(BOOL)animated{
    if (playerView) {
        [playerView.audioPlayer pause];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.dk_backgroundColorPicker = DKColorPickerWithRGB(0xf0f0f0, 0x000000, 0xfafafa);
    [self createNav];
    [self loadData];

}

#pragma mark===加工相关推荐的url
- (NSString *)getTheRelatedUrlAccordUrl:(NSString *)url{
    NSArray *arr = [self.artModel.ArticalUrl componentsSeparatedByString:@"/"];
    NSLog(@"%@",arr);
    NSString *str;
    if (arr.count>3) {
        str  = [NSString stringWithFormat:@"%@/%@/%@",VoaEnglish,arr[3],url];
    }
    return str;
    
}

- (void)loadData{
  
    [self dispathLoad:^{

        self.model = [[RequestTool shareTool] getTheDetailFromTheUrl:self.artModel.ArticalUrl];
        
    } mainQueue:^{
        if (self.model) {
            [self createUI];
            //self.title = self.model.
            self.title = self.artModel.articalTitle;
             [self.tb reloadData];
           
        }
     }];
    
   

}

#pragma mark====伪导航条
- (void)createNav{
    
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(returnButClick)];
    self.navigationItem.leftBarButtonItem = search;
    UILabel *titleLab = [UILabel new];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.text = self.artModel.articalTitle;
    self.navigationItem.titleView = titleLab;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势
    if(self.navigationController.childViewControllers.count == 1)
    {
        return YES;
    }
    
    return YES;
}

- (void)returnButClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createUI{

     self.view.dk_backgroundColorPicker = DKColorPickerWithRGB(0xf0f0f0, 0x000000, 0xfafafa);
    
    [self.view addSubview:self.tb];
    
    if (self.model.mp3Url) {
        
        playerView =  [[[NSBundle mainBundle] loadNibNamed:@"EnglishPlayer" owner:self options:nil] lastObject];
        
        playerView.musicURL = self.model.mp3Url;
        [self.view addSubview:playerView];
        [playerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tb.mas_bottom);
            make.left.right.equalTo(self.tb);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
    
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
   
    if (section==0) {
        return nil;
    }else{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 200, 20)];
        label.text = @"相关推荐:";
        label.dk_textColorPicker = DKColorPickerWithKey(TEXT);
       
        [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        return label;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.01;
    }else{
        return 20;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }else{
        return self.model.relatedArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListCell *cell           = [tableView dequeueReusableCellWithIdentifier:ListCellID];
    ArticalListModel *model = self.model.relatedArr[indexPath.row];
    
    if (indexPath.section==0) {
        cell.ListLabel.text = self.model.contentsStr;
        cell.selectionStyle = NO;
    }else{
        cell.ListLabel.text = model.articalTitle;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return;
    }
    ArticalListModel *model = self.model.relatedArr[indexPath.row];
   
    [self.view removeAllSubviews];
    [playerView.audioPlayer pause];

    self.model = nil;

    self.artModel.ArticalUrl = [self getTheRelatedUrlAccordUrl:model.ArticalUrl];
    self.artModel.articalTitle = model.articalTitle;
    
    [self loadData];

}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    //隐藏导航条
    [self hideNavBar:velocity.y > 0];
    
}

#pragma mark====是否隐藏导航条
- (void)hideNavBar:(BOOL)ishide{
    
  
    
    [self.navigationController setNavigationBarHidden:ishide animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
