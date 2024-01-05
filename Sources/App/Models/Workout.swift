//
//  Workout.swift
//  GymPulse-API
//
//  Created by Raphaël Payet on 04/01/2024.
//

import Fluent
import Vapor

final class Workout: Model, Content {
    static let schema: String = Constants.WORKOUTS_TABLE
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    init() {}
    
    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
}
