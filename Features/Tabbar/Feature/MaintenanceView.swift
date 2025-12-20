//
//  MaintenanceView.swift
//  TabbarFeature
//
//  Created by taeuk on 12/20/25.
//

import Foundation
import SwiftUI

public struct MaintenanceView: View {
    
    public init() {}
    
    public var body: some View {
        
        VStack(alignment: .leading, spacing: 32) {
            Text("점검 중이에요")
                .font(.system(size: 36))
            
            VStack(alignment: .leading, spacing: 16) {
                Text("일시: 12/10")
                
                Text("시간: 20:00 ~ 23:00")
            }
        }
    }
}
