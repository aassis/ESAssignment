import UIKit

final class MediaView: UIView {

    private lazy var apiKeyFieldHint: String = {
        ESAssignmentLocalized.MediaView.MediaTextField.apiKeyHint
    }()

    struct Constants {
        static let halfPadding: CGFloat = 4.0
        static let defaultPadding: CGFloat = 8.0
        static let textFieldHeight: CGFloat = 44.0
        static let searchBarHeight: CGFloat = 44.0
    }

    lazy var searchField: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.showsCancelButton = true
        return searchBar
    }()

    lazy var apiKeyField: UITextField = {
        let field = UITextField(frame: .zero)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.clearButtonMode = .whileEditing
        field.returnKeyType = .next
        field.borderStyle = .roundedRect
        field.placeholder = apiKeyFieldHint
        return field
    }()

    lazy var tableView: UITableView = {
        let tableView = MediaTableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .onDrag
        tableView.canCancelContentTouches = true
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension MediaView: ViewCode {
    func setupViewCode() {
        buildHierarchy()
        buildConstraints()
        additionalConfiguration()
    }

    func buildHierarchy() {
        addSubview(apiKeyField)
        addSubview(searchField)
        addSubview(tableView)
    }

    func buildConstraints() {
        let halfPadding = Constants.defaultPadding
        let defaultPadding = Constants.defaultPadding
        let searchBarHeight = Constants.searchBarHeight
        let textFieldHeight = Constants.textFieldHeight

        apiKeyField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        apiKeyField.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: defaultPadding).isActive = true
        apiKeyField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -defaultPadding).isActive = true
        apiKeyField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true

        searchField.topAnchor.constraint(equalTo: apiKeyField.bottomAnchor, constant: halfPadding).isActive = true
        searchField.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        searchField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        searchField.heightAnchor.constraint(equalToConstant: searchBarHeight).isActive = true

        tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    func additionalConfiguration() {
        backgroundColor = .white
    }
}
