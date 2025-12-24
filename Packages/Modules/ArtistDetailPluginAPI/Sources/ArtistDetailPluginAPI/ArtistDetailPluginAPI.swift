import UIKit

public protocol ArtistDetailPluginAPI {
    func makeArtistDetailModule(
        navigationController: UINavigationController?,
        artistIdentifier: String
    ) -> UIViewController
}
