//
//  DataBaseTool.swift
//  MyChat
//
//  Created by 才文刘 on 2017/11/7.
//  Copyright © 2017年 seven. All rights reserved.
//


import FMDB

private let dbName = "mychat.db"
//数据库工具类
class DataBaseTool {
    /// 单例
    static let shareInstance: DataBaseTool = DataBaseTool()
    //声明全局操作数据的队列对象
    let queue: FMDatabaseQueue
    //私有化构造方法
    private init() {
        //打开数据库连接 创建数据库文件
        //数据库一般存储在沙盒中
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent(dbName)
        //一般使用 FMDatabaseQueue对应的对象操作数据库文件
        //创建数据操作对象 如果数据库文件存在就直接打开数据连接 如果没有就创建该数据库文件并创建连接
        //当前这个连接 一经打开就不需要断开
        queue = FMDatabaseQueue(path: path)
        //创建数据表
        //需要sql语句
        //在使用核心对象调用核心方法 创建数据表
        createTable()
        
        print(path)
    }
    
    /**
      根据需求 创建表
     */
    
    private func createTable(){
        // 1.编写SQL语句
        //创建聊天列表
        let session_sql = "create table if not exists session_tab( \n" +
            "session_id INTEGER PRIMARY KEY AUTOINCREMENT , \n" +
            "session_name TEXT  , \n" +
            "session_userId INTEGER , \n" +
            "session_image TEXT ,\n" +
            "session_last_time TEXT ,\n" +
            "session_count TEXT , \n" +
            "session_last_content ,\n" +
            "session_type INTEGER ,\n" +
            "session_disturb INTEGER \n" +
            ");" +
            "create table if not exists chat_tab(\n" +
            "chat_id INTEGER PRIMARY KEY AUTOINCREMENT ,\n" +
            "chat_sessionId INTEGER,\n " +
            "chat_userId INTEGER , \n" +
            "chat_type INTEGER ,\n" +
            "chat_content TEXT ,\n" +
            "chat_image TEXT, \n" +
            "chat_time INTEGER \n" +
        ");"
        // 2.执行SQL语句
        queue.inDatabase { (db) -> Void in
            if db.executeStatements(session_sql) {
                print("创建数据表成功")
            } else {
                print("创建数据表失败")
            }
        }
    }
    
   

    
    
    
}
