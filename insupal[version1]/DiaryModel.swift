//
//  DiaryModel.swift
//  insupal[version1]
//
//  Created by cherrycat on 2018-07-29.
//  Copyright © 2018 cherrycat. All rights reserved.
//

import Foundation
class DiaryModel{
    var date: String?
    var foodSgrLvl: String?
    
    init(date: String?, foodSgrLvl: String?){
        self.date = date
        self.foodSgrLvl = foodSgrLvl
    }
}
