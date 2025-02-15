//
//  ModelItem.swift
//  TextArtReplica
//
//  Created by Mohamed Alwakil on 2025-01-28.
//

import Foundation
import SwiftData

@Model
class Project {

    var id: String = UUID().uuidString
    var name: String
    init(name: String) {
        self.name = name
    }
}

@Model
class Folder {

    var id: String = UUID().uuidString
    var title: String
    @Relationship var modelItems: [ModelItem] = []

    init(title: String, modelItems: [ModelItem]) {
        self.title = title
        self.modelItems = modelItems
    }
}

@Model
class ModelItem{

    var id: String = UUID().uuidString
    @Relationship(deleteRule: .cascade) var project: Project?
    @Relationship(deleteRule: .cascade) var folder: Folder?

    init(project: Project?, folder: Folder?) {
        self.project = project
        self.folder = folder
    }
}

