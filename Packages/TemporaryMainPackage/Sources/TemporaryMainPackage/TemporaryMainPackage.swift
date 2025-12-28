import CommonModels
import UIKit

public protocol TemporaryMainPackage {
    func makeSongDetailModule(
        navigationController: UINavigationController,
        song: Song
    ) -> UIViewController
}
