//
//  NetworkReachability.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

import Foundation
import Network

/// A singleton class that monitors network connectivity status across the application.
class NetworkReachability {
    
    static let shared = NetworkReachability()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    @Published private(set) var isConnected: Bool = true
    
    /// Private initializer to ensure `NetworkReachability` follows the singleton pattern.
    /// This initializer starts monitoring the network path and updates the `isConnected` property whenever there is a change in network status.
    private init() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
               self?.isConnected = (path.status == .satisfied)
            }
        }
    }
}
