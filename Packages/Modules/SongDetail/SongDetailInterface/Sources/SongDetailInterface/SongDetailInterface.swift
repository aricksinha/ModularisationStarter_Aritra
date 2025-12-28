import CommonModels
import UIKit

public protocol SongDetailInterface {
    func makeSongDetailModule(
        navigationController: UINavigationController,
        song: Song
    ) -> UIViewController
}
