import UIKit
import SwiftUI
import SnapKit

class ToDoViewController: UIViewController {
    private let taskManager = TaskManager.shared
    
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

    private let viewModel = ToDoListViewModel() 

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

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        

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
        let alertController = UIAlertController(title: "할 일 추가하기", message: nil, preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "할 일"
        }

        let addAction = UIAlertAction(title: "추가", style: .default) { [weak self] _ in
            if let textField = alertController.textFields?.first, let title = textField.text, !title.isEmpty {
                self?.viewModel.createTask(title: title)
                self?.tableView.reloadData()
            }
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

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

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분 ss초"

        if let date = task.modifyDate {
            let formattedDate = dateFormatter.string(from: date)
            cell.configure(with: task.title ?? "", date: formattedDate, isCompleted: task.isCompleted)
        } else {
            cell.configure(with: task.title ?? "", date: "", isCompleted: task.isCompleted)
        }

        cell.toggleSwitch.isOn = task.isCompleted

        cell.toggleSwitch.addTarget(self, action: #selector(toggleSwitchChanged(sender:)), for: .valueChanged)

        return cell
    }
    
    @objc func toggleSwitchChanged(sender: UISwitch) {

        if let cell = sender.superview?.superview as? ToDoTableViewCell, let indexPath = tableView.indexPath(for: cell) {
            let task = viewModel.tasks[indexPath.row]
            task.isCompleted = sender.isOn
            taskManager.updateTask(task: task, withTitle: task.title ?? "")
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "할 일 수정", message: nil, preferredStyle: .alert)

        alertController.addTextField { [weak self] textField in
            textField.placeholder = "할 일"
            textField.text = self?.viewModel.tasks[indexPath.row].title
        }

        let editAction = UIAlertAction(title: "수정", style: .default) { [weak self] _ in
            if let textField = alertController.textFields?.first, let title = textField.text, !title.isEmpty {
                self?.viewModel.updateTask(at: indexPath.row, withTitle: title)
                tableView.reloadData()
            }
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

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
