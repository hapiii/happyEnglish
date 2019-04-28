//
//  VELeftViewController.m
//  VOA_English
//
//  Created by 王强 on 17/3/7.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "VELeftViewController.h"

static NSString * const ListCellID = @"ListCellID";
@interface VELeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSArray *dataArr;
@property (nonatomic,strong)UITableView *tb;

@end

@implementation VELeftViewController

- (UITableView *)tb{
    
    if (_tb==nil) {
        _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStylePlain];
        _tb.backgroundColor =  WQRGBColor(250,56,101);
        _tb.separatorStyle = NO;
        _tb.delegate = self;
        _tb.dataSource = self;
    }
    [_tb registerNib:[UINib nibWithNibName:NSStringFromClass([ListCell class]) bundle:nil] forCellReuseIdentifier:ListCellID];//一张图片
    return _tb;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = WQRGBColor(250,56,101);
    
    [self.view addSubview:self.tb];
    [self loadData];
    
}

- (void)loadData{
    
    __block NSArray *array;
    __block NSMutableArray *Muatt = [NSMutableArray new];
    [self dispathLoad:^{
        
        
        array = [[RequestTool shareTool] getTheDoucmentofTheHome];
        if (nil !=array) {///VOA_Standard_1_2.html
            
            //将标题提取出来
            for (DocumentModel *model in array) {
                [Muatt addObject:model.documentTitle];
            }
            [Muatt removeLastObject];
            [Muatt removeLastObject];
            _dataArr = Muatt;
            
        }
    } mainQueue:^{
        if (array.count>0) {
            [self.tb reloadData];
            
        }
        
    }];
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListCell *cell           = [tableView dequeueReusableCellWithIdentifier:ListCellID];
    
  
    cell.ListLabel.text = _dataArr[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectCell) {
        self.selectCell(indexPath.row);
    }
    
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
