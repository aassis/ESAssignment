import UIKit
import AlamofireImage

final class MediaTableCell: UITableViewCell {

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private lazy var yearLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()

    private lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.clipsToBounds = true
        button.layer.cornerRadius = 10.0
        return button
    }()

    private lazy var posterImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        image.layer.borderWidth = 1.0
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = 8.0
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        return image
    }()

    func setupWith(media: Media) {
        setupViewCode()
        titleLabel.text = media.title
        if let imgUrlString = media.poster,
           let imgUrl = URL(string: imgUrlString),
            imgUrl.isValid() {
            posterImage.af.setImage(withURL: imgUrl, imageTransition: .noTransition)
        }
        yearLabel.text = media.year
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = .none
        posterImage.image = nil
    }

}

extension MediaTableCell: ViewCode {
    func setupViewCode() {
        buildHierarchy()
        buildConstraints()
    }

    func buildHierarchy() {
        addSubview(posterImage)
        addSubview(titleLabel)
        addSubview(yearLabel)
        addSubview(button)
    }

    func buildConstraints() {
        posterImage.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        posterImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 8.0).isActive = true
        posterImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0).isActive = true
        let constraint = posterImage.heightAnchor.constraint(equalToConstant: 200.0)
        constraint.priority = .defaultHigh
        constraint.isActive = true
        posterImage.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75).isActive = true

        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 8.0).isActive = true
        titleLabel.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -8.0).isActive = true

        yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
        yearLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true

        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0).isActive = true
        button.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor, constant: -8.0).isActive = true
    }

    func additionalConfiguration() {
        self.clipsToBounds = true
    }
}
