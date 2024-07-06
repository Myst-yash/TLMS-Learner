//
//  CourseCategoriesModel.swift
//  TLMS-learner
//
//  Created by Sumit Prasad on 06/07/24.
//

import Foundation

struct CourseCategory: Identifiable {
    let id = UUID()
    let name: String
    
    static let courseCategories: [CourseCategory] = [
        CourseCategory(name: "Illustration"),
        CourseCategory(name: "Animation"),
        CourseCategory(name: "Fine Art"),
        CourseCategory(name: "Graphic Design"),
        CourseCategory(name: "Lifestyle"),
        CourseCategory(name: "Photography"),
        CourseCategory(name: "Film & Video"),
        CourseCategory(name: "Marketing"),
        CourseCategory(name: "Web Development"),
        CourseCategory(name: "Music"),
        CourseCategory(name: "UI Design"),
        CourseCategory(name: "UX Design"),
        CourseCategory(name: "Business & Management"),
        CourseCategory(name: "Productivity")
    ]

    
}
