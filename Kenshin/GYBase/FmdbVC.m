//
//  FmdbVC.m
//  GYBase
//
//  Created by doit on 16/4/25.
//  Copyright © 2016年 kenshin. All rights reserved.

//  说明： fmdb 更新语句(除了 select之外的语句) 执行后返回 BOOL 只监测与法 和 sql语句本身的与法错误， 不会做其他处理
//  例如删除 一个没有的 数据 where name = @"asdasd" 如果表中没有这行数据 这行代码执行后是不会报错的 如无与法错误 返回 YES

//    select查询语句 返回 result 没有 则返回 nil

#import "FmdbVC.h"
#import "Tools.h"
#import "FMDatabase.h"


@interface FmdbVC ()

@end

@implementation FmdbVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self myDataBase];
    [self initFmdbUI];
    
}

- (void)myDataBase
{
    //1.获取数据库文件路径
    NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [dbPath stringByAppendingPathComponent:@"kenshin.sqlite"];
    
    //2.获得数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    
    //3.使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
    if ([db open])
    {
        //4.创表学生表 t_student
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
        if (result)
        {
            NSLog(@"创建表成功");
        }
    }
    
    //报 野指针
    //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
//    BOOL isSucess = [db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?,?);", @"kenshin", 25];
    
    //2.executeUpdateWithFormat：不确定的参数用%@，%d等来占位 （参数为原始数据类型，执行语句不区分大小写）
//    BOOL isSucess2 = [db executeUpdateWithFormat:@"insert into t_student (name, age) values (%@,%i);", @"范望望", 26];
    
    //3.参数是数组的使用方式
//    BOOL isSucess3 = [db executeUpdate:@"INSERT INTO t_student(name,age) VALUES  (?,?);" withArgumentsInArray:@[@"范特西",@(100)]];
    
//    if (isSucess)NSLog(@"插入成功！   1");
    
//    if (isSucess2)NSLog(@"插入成功！  2");
//    if (isSucess3)NSLog(@"插入成功！  3");
    
    //删除
    //2.不确定的参数用%@，%d等来占位
//    if ([db executeUpdateWithFormat:@"delete from t_student where name = %@;",@"范特西"]) {
//        NSLog(@"删除成功！");
//    }
    
    //修改
    //修改学生的名字
//    if ([db executeUpdate:@"update t_student set name = ? where name = ?",@"范天空",@"www"]) {
//        NSLog(@"成功！");
//    }
    
    //查询
    FMResultSet *result = [db executeQuery:@"select * from t_student"];
    //遍历结果集合
    while ([result  next])
    {
        int idNum = [result intForColumn:@"id"];
        NSString *name = [result objectForColumnName:@"name"];
        int age = [result intForColumn:@"age"];
        NSLog(@"id == %i, name == %@, age == %d", idNum, name, age);
        
    }
    [db close];
}

- (void)initFmdbUI
{
    self.navigationItem.title = @"FMDB";
    self.view.backgroundColor = RGB2Color(253, 246, 247);
    [Tools toast:@"综合运用见 TabBarVC Setting page" andCuView:self.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
