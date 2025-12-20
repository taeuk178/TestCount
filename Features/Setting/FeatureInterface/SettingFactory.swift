
import Foundation
import SwiftUI

public protocol SettingFactory {
    func makeView() -> AnyView
}