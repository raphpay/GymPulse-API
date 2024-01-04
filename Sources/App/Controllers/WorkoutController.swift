//
//  WorkoutController.swift
//
//
//  Created by Raphaël Payet on 04/01/2024.
//

import Vapor

struct WorkoutController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        // Create the database route
        let workouts: RoutesBuilder = routes.grouped("workouts")
        // Use the methods
        workouts.post(use: create)
        workouts.get(use: index)
    }
    
    // MARK: - /workouts route
    // MARK: - Create
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let workout: Workout = try req.content.decode(Workout.self)
        
        return workout
            .save(on: req.db)
            .transform(to: .ok)
    }
    
    // MARK: - Read
    func index(req: Request) throws -> EventLoopFuture<[Workout]> {
        Workout.query(on: req.db).all()
    }
}
