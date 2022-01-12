//
//  Model.swift
//  LENA
//
//  Created by SEAN BLAKE on 1/11/22.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory: CaseIterable {
    case robot
    case furniture
    case clothes
    
    // The lables for each Section
    var label: String {
        get {
            switch self {
            case .robot:
                return "Robots"
            case .furniture:
                return "Furniture"
            case .clothes:
                return "Clothes"
            }
        }
    }
}

class Model {
    var name: String
    var category: ModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    
    private var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
    
    func asyncLoadModelEntity() {
        let filename = self.name + ".usdz"
        
        // to create a publisher
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink( receiveCompletion: { loadCompletion in
                
                switch loadCompletion {
                case .failure(let error): print("Unable to load modelEntity for \(filename). ERROR: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { modelEntity in
                
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scaleCompensation
                
                print("modelEntity for \(self.name) has been loaded.")
                
            })

    }
}

struct Models {
    var all: [Model] = []
    
    init() {
        // Robots
        let robot = Model(name: "andriod", category: .robot, scaleCompensation: 1.0)
        
        self.all += [robot]
        
        // Furniture
        let furniture = Model(name: "chair", category: .furniture, scaleCompensation: 1.0)
        
        self.all += [furniture]
        
        // Clothes
        let clothes = Model(name: "nike", category: .clothes, scaleCompensation: 1.0)
        
        self.all += [clothes]
    }
    
    func get(category: ModelCategory) -> [Model] {
        return all.filter( {$0.category == category })
    }
}
