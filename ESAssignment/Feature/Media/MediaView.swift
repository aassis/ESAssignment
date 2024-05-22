import UIKit

final class MediaView: UIView {
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
        field.placeholder = "Insert your API Key!"
        return field
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .onDrag
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
        apiKeyField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        apiKeyField.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8.0).isActive = true
        apiKeyField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -8.0).isActive = true
        apiKeyField.heightAnchor.constraint(equalToConstant: 44.0).isActive = true

        searchField.topAnchor.constraint(equalTo: apiKeyField.bottomAnchor, constant: 4.0).isActive = true
        searchField.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        searchField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        searchField.heightAnchor.constraint(equalToConstant: 44.0).isActive = true

        tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    func additionalConfiguration() {
        backgroundColor = .white
    }
}
