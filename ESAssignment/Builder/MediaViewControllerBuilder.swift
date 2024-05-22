import UIKit

final class MediaViewControllerBuilder: BuilderProtocol {
    static func build() -> UIViewController {
        let apiClient = APIClient()
        let viewModel = MediaViewModel(apiClient: apiClient)
        return  MediaViewController(viewModel: viewModel)
    }
}
