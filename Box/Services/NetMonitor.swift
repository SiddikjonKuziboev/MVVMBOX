//
//  NetManager.swift
//  Box
//
//  Created by Kuziboev Siddikjon on 11/1/22.
//

import UIKit
import Network

final class NetMonitor {
    
    enum ConnectionType{
        case wifi
        case cellular
        case etherNet
        case unknown
    }
    
    static let shared = NetMonitor()
    private let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown
    
    private init(){
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            self.connectionType = self.getConnectionType(path)
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.7) {
                print(self.isConnected ? "internet yondi" : "Uchdi")
                if self.isConnected {
                    Alert.showAlert(state: .success, duration: 5, message: "Connected")
                }else {
                    Alert.showAlert(state: .error, duration: 5, message: "Not Connected")
                }
            }
        }
        
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)

    }
    
    public func stopMonitor() {
        monitor.cancel()
    }
    
    public func getConnectionType(_ path: NWPath) -> ConnectionType {
        
        if path.usesInterfaceType(.wifi) {
             connectionType = .wifi
            
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        }
        else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .etherNet
        } else {
            connectionType = .unknown
        }
        return connectionType
    }
    
}
