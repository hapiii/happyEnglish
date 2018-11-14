//
//  DocumentModel.h
//  VOA_English
//
//  Created by 王强 on 17/3/9.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "BaseModel.h"

@interface DocumentModel : BaseModel<NSCoding>
//目录模型
ProStr(documentTitle)

@property (nonatomic,strong)NSMutableArray *documentList;

@end
