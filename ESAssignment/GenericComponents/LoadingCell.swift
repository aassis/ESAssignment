import UIKit

final class LoadingCell: UITableViewCell {

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
        progressView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        let constraint = progressView.heightAnchor.constraint(equalToConstant: 40.0)
        constraint.priority = .defaultHigh
        constraint.isActive = true
        progressView.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        progressView.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        progressView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0).isActive = true
    }
}
