import UIKit
import SwiftUI
import SnapKit

class ToDoViewController: UIViewController {
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: "ToDoCell")
        return tableView
    }()

    private let viewModel = ToDoListViewModel() // 뷰 모델 생성

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func setupNavigationBar() {
        // 네비게이션 바에 "Add" 버튼 추가
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        // 네비게이션 바에 "Edit" 버튼 추가
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        
        navigationItem.rightBarButtonItems = [addButton, editButton]
    }
    
    func setupUI() {
        view.addSubview(contentView)
        contentView.addSubview(tableView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @objc func addButtonTapped() {
        let alertController = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "Task Title"
        }

        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if let textField = alertController.textFields?.first, let title = textField.text, !title.isEmpty {
                self?.viewModel.createTask(title: title)
                self?.tableView.reloadData()
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(addAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    @objc func editButtonTapped() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
}

extension ToDoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoTableViewCell

        let task = viewModel.tasks[indexPath.row]

        cell.configure(with: task.title ?? "", date: "\(task.modifyDate ?? Date())", isCompleted: task.isCompleted)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Edit Task", message: nil, preferredStyle: .alert)

        alertController.addTextField { [weak self] textField in
            textField.placeholder = "Task Title"
            textField.text = self?.viewModel.tasks[indexPath.row].title
        }

        let editAction = UIAlertAction(title: "Edit", style: .default) { [weak self] _ in
            if let textField = alertController.textFields?.first, let title = textField.text, !title.isEmpty {
                self?.viewModel.updateTask(at: indexPath.row, withTitle: title)
                tableView.reloadData()
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(editAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteTask(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

struct ToDoViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        ToDoViewControllerReprsentable().edgesIgnoringSafeArea(.all)
    }
}

struct ToDoViewControllerReprsentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let toDoViewController = ToDoViewController()
        return UINavigationController(rootViewController: toDoViewController)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    typealias UIViewControllerType = UIViewController
}
