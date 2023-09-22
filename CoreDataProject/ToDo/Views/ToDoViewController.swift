import UIKit
import CoreData
import SwiftUI

class ToDoViewController: UIViewController {

    // 배경 뷰
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // 테이블 뷰
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: "ToDoCell")
        return tableView
    }()
    

    let taskManager = TaskManager.shared


    private var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupUI()
        loadTasks() 
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadTasks()
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
        
        // 배경 뷰
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 테이블 뷰
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // "Add" 버튼을 눌렀을 때의 액션
    @objc func addButtonTapped() {
        let alertController = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "Task Title"
        }

        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if let textField = alertController.textFields?.first, let title = textField.text, !title.isEmpty {
                // Task 생성 및 저장
                self?.taskManager.createTask(title: title)
                // 테이블 뷰 리로드
                self?.loadTasks()
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(addAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    // "Edit" 버튼을 눌렀을 때의 액션
    @objc func editButtonTapped() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }

    private func loadTasks() {
        tasks = taskManager.fetchTasks()
        tableView.reloadData()
    }
}



// MARK: - 테이블 뷰 델리게이트
extension ToDoViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskManager.fetchTasks().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoTableViewCell

        let tasks = taskManager.fetchTasks()
        let task = tasks[indexPath.row]

        // 셀에 데이터 설정
        cell.titleLabel.text = task.title
        cell.dateLabel.text = "\(task.modifyDate!)"
        cell.toggleSwitch.isOn = task.isCompleted

        

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Edit Task", message: nil, preferredStyle: .alert)

        alertController.addTextField { [weak self] textField in
            textField.placeholder = "Task Title"
            let tasks = self?.taskManager.fetchTasks()
            let task = tasks?[indexPath.row]
            textField.text = task?.title
        }

        // 수정 버튼 액션
        let editAction = UIAlertAction(title: "Edit", style: .default) { [weak self] _ in
            if let textField = alertController.textFields?.first, let title = textField.text, !title.isEmpty {
                let tasks = self?.taskManager.fetchTasks()
                if let task = tasks?[indexPath.row] {
                    self?.taskManager.updateTask(task: task, withTitle: title)
                    tableView.reloadData()
                }
            }
        }

        // 취소 버튼 액션
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(editAction)
        alertController.addAction(cancelAction)

        // 얼럿 창 표시
        present(alertController, animated: true, completion: nil)
    }

    // Swipe로 삭제 가능한 기능 추가
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let tasks = taskManager.fetchTasks()
            let taskToDelete = tasks[indexPath.row]
            taskManager.deleteTask(task: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - SwiftUI를 활용한 미리보기
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
