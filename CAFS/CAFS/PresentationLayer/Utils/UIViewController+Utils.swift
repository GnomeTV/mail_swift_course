import Foundation
import UIKit

extension UIViewController {
    static var viewModels: IPresentationAssembly { RootAssembly.shared.presentationAssembly }
}
