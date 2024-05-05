//
//  FavoriteCoordinatesDataManager.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 4.05.2024.
//

import Foundation
import CoreData

final class FavoriteLocationsDataManager {
    
    static let instance = FavoriteLocationsDataManager()

    private let container: NSPersistentContainer
    private let containerName: String = "FavoriteLocationsContainer"
    private let entityName: String = "FavoriteLocationsEntity"
    
    @Published private(set) var savedEntities: [FavoriteLocationsEntity] = []
    
    private init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error {
                debugPrint("Error loading Core Data! \(error)")
            }
            self.getSavedFavoriteLocations()
        }
    }
    
    private func getSavedFavoriteLocations() {
        let request = NSFetchRequest<FavoriteLocationsEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
            if savedEntities.isEmpty {
                addNewFavoriteLocation("Istanbul")
            }
        } catch {
            debugPrint("Error fetching Portfolio Entities. \(error)")
        }
    }
}

extension FavoriteLocationsDataManager {
    func addNewFavoriteLocation(_ name: String) {
        let entity = FavoriteLocationsEntity(context: container.viewContext)
        entity.name = name
        applyChanges()
    }

    func removeFavoriteLocation(_ name: String) {
        if let entity = savedEntities.first(where: { $0.name?.lowercased() == name.lowercased() }) {
            delete(entity: entity)
        }
    }
}

extension FavoriteLocationsDataManager {
    private func delete(entity: FavoriteLocationsEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func applyChanges() {
        save()
        getSavedFavoriteLocations()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            debugPrint("Error saving to Core Data. \(error)")
        }
    }
}
