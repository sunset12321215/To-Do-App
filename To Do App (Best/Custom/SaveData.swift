//
//  SaveData.swift
//  To Do App
//
//  Created by mac on 9/12/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

//Tạo mảng lưu thông tin

var todoList : [String] = []


// Hàm Lưu mảng 1

func SaveMang(todoList : [String])
{
    UserDefaults.standard.set(todoList, forKey: "todoList")
}


//  Hàm lấy giá trị
func fetchData() -> [String]?
{
    guard
        let ToDo = UserDefaults.standard.array(forKey: "todoList") as? [String] else {return nil}
   
    return ToDo
}
