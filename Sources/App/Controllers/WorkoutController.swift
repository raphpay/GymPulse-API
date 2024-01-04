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
        workouts.put(use: update)
        workouts.group(":\(Constants.WORKOUT_ID_ROUTE)") { workout in
            workout.delete(use: delete)
        }
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
    
    // MARK: - Update
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let workout: Workout = try req.content.decode(Workout.self)
        
        return Workout
            .find(workout.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.title = workout.title
                return $0
                    .update(on: req.db)
                    .transform(to: .ok)
            }
    }
    
    // MARK: - Delete
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        Workout
            .find(req.parameters.get(Constants.WORKOUT_ID_ROUTE), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
