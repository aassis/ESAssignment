import UIKit

final class LoadingCell: UITableViewCell {

    struct Constants {
        static let loadIconHeightWidth: CGFloat = 40.0
        static let defaultPadding: CGFloat = 8.0
    }

    private lazy var progressView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        return activityIndicator
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCode()
        progressView.startAnimating()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        progressView.startAnimating()
    }
}

extension LoadingCell: ViewCode {
    func setupViewCode() {
        buildHierarchy()
        buildConstraints()
    }
    
    func buildHierarchy() {
        addSubview(progressView)
    }

    func buildConstraints() {
        let defaultPadding = Constants.defaultPadding
        let loadIconHeightWidth = Constants.loadIconHeightWidth

        progressView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        let constraint = progressView.heightAnchor.constraint(equalToConstant: loadIconHeightWidth)
        constraint.priority = .defaultHigh
        constraint.isActive = true
        progressView.widthAnchor.constraint(equalToConstant: loadIconHeightWidth).isActive = true
        progressView.topAnchor.constraint(equalTo: topAnchor, constant: defaultPadding).isActive = true
        progressView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -defaultPadding).isActive = true
    }
}
