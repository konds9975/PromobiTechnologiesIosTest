//
//  Constant.swift
//  PromobiTechnologiesIosTest
//
//  Created by Kondya on 02/07/19.
//  Copyright © 2019 Fortune4. All rights reserved.
//

import Foundation

let locationSaveTimeIntervel = 60.0

let deleteconfirmationMessage = "Are you sure to clear all old locations?"

let locationUpdateNotificationIdentifier = Notification.Name("locationUpdateNotification")

class Constant {
    class var shared: Constant {
        struct Static {
            static let instance: Constant = Constant()
        }
        return Static.instance
    }
    func hostCPULoadInfo() -> String {
        
        var cpuuse = ""
        var taskInfo = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }
        if kerr == KERN_SUCCESS {
            let usedMegabytes = taskInfo.resident_size/(1024*1024)
            print("used megabytes: \(usedMegabytes)")
            cpuuse.append("Memory: ")
            cpuuse.append("\(usedMegabytes)")
        } else {
            print("Error with task_info(): " +
                (String(cString: mach_error_string(kerr), encoding: String.Encoding.ascii) ?? "unknown error"))
        }
        
        
        let  HOST_CPU_LOAD_INFO_COUNT = MemoryLayout<host_cpu_load_info>.stride / MemoryLayout<integer_t>.stride
        
        var size = mach_msg_type_number_t(HOST_CPU_LOAD_INFO_COUNT)
        let hostInfo = host_cpu_load_info_t.allocate(capacity: 1)
        
        let result = hostInfo.withMemoryRebound(to: integer_t.self, capacity: HOST_CPU_LOAD_INFO_COUNT) {
            host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, $0, &size)
        }
        
        if result != KERN_SUCCESS{
            print("Error  - \(#file): \(#function) - kern_result_t = \(result)")
            
        }
        let data = hostInfo.move()
        cpuuse.append(", CPU ticks: ")
        cpuuse.append("\(data.cpu_ticks)")
        
        return cpuuse
    }
    
    
}
