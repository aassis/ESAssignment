import UIKit

final class ErrorCell: UITableViewCell {

    struct Constants {
        static let defaultPadding: CGFloat = 8.0
    }

    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    func setupWith(error: Error) {
        setupViewCode()
        label.text = error.localizedDescription
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension ErrorCell: ViewCode {
    func setupViewCode() {
        buildHierarchy()
        buildConstraints()
    }

    func buildHierarchy() {
        addSubview(label)
    }

    func buildConstraints() {
        let defaultPadding = Constants.defaultPadding

        label.leftAnchor.constraint(equalTo: leftAnchor, constant: defaultPadding).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -defaultPadding).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: defaultPadding).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -defaultPadding).isActive = true
    }
}
