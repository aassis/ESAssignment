import UIKit

final class ErrorCell: UITableViewCell {

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
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 8.0).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -8.0).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0).isActive = true
    }
}
