//
//  CreateWorkout.swift
//
//
//  Created by Raphaël Payet on 04/01/2024.
//

import Fluent

struct CreateWorkout: Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database
            .schema(Constants.WORKOUTS_TABLE)
            .id()
            .field("title", .string, .required)
            .create()
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database
            .schema(Constants.WORKOUTS_TABLE)
            .delete()
    }    
}
