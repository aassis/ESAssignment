import UIKit
import AlamofireImage

final class MediaTableCell: UITableViewCell {

    struct Constants {
        static let defaultPadding: CGFloat = 8.0
        static let posterHeight: CGFloat = 200.0
        static let posterWidthRatioMultiplier: CGFloat = 0.75
    }

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
        contentView.addSubview(posterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(yearLabel)
    }

    func buildConstraints() {
        let defaultPadding = Constants.defaultPadding
        let posterHeight = Constants.posterHeight
        let ratioMultiplier = Constants.posterWidthRatioMultiplier

        posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: defaultPadding).isActive = true
        posterImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: defaultPadding).isActive = true
        posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -defaultPadding).isActive = true
        let constraint = posterImage.heightAnchor.constraint(equalToConstant: posterHeight)
        constraint.priority = .defaultHigh
        constraint.isActive = true
        posterImage.widthAnchor.constraint(equalTo: posterImage.heightAnchor, multiplier: ratioMultiplier).isActive = true

        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: defaultPadding).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: defaultPadding).isActive = true
        titleLabel.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -defaultPadding).isActive = true

        yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: defaultPadding).isActive = true
        yearLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
    }

    func additionalConfiguration() {
        self.clipsToBounds = true
    }
}
