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
    
    // TaskManager 인스턴스 생성
    let taskManager = TaskManager.shared

    // Task 데이터 배열 추가
    private var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupUI()
        loadTasks() // 뷰가 로드될 때 데이터 불러오기
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 뷰가 나타날 때마다 데이터 업데이트
        loadTasks()
    }

    func setupNavigationBar() {
        // 네비게이션 바에 "Add" 버튼 추가
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        // 네비게이션 바에 "Edit" 버튼 추가
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        
        // 네비게이션 아이템에 버튼들 추가
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
        // 얼럿 창 생성
        let alertController = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)

        // 입력 필드 추가
        alertController.addTextField { textField in
            textField.placeholder = "Task Title"
        }

        // 추가 버튼 액션
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if let textField = alertController.textFields?.first, let title = textField.text, !title.isEmpty {
                // Task 생성 및 저장
                self?.taskManager.createTask(title: title)
                // 테이블 뷰 리로드
                self?.loadTasks()
            }
        }

        // 취소 버튼 액션
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(addAction)
        alertController.addAction(cancelAction)

        // 얼럿 창 표시
        present(alertController, animated: true, completion: nil)
    }

    // "Edit" 버튼을 눌렀을 때의 액션
    @objc func editButtonTapped() {
        // 수정 모드로 전환
        tableView.setEditing(!tableView.isEditing, animated: true)
    }

    // 데이터 불러오기
    private func loadTasks() {
        tasks = taskManager.fetchTasks()
        // 불러온 데이터로 테이블 뷰 업데이트
        tableView.reloadData()
    }
}



// MARK: - 테이블 뷰 델리게이트
extension ToDoViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 테이블 뷰의 총 행 수를 반환합니다.
        return taskManager.fetchTasks().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 각 행에 표시할 셀을 반환합니다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoTableViewCell

        // TaskManager에서 해당 Task 가져오기
        let tasks = taskManager.fetchTasks()
        let task = tasks[indexPath.row]

        // 셀에 데이터 설정
        cell.titleLabel.text = task.title
        cell.dateLabel.text = "\(task.modifyDate!)"
        cell.toggleSwitch.isOn = task.isCompleted // 토글 스위치의 상태 설정

        

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 특정 행을 선택했을 때의 동작을 처리합니다.
        let alertController = UIAlertController(title: "Edit Task", message: nil, preferredStyle: .alert)

        // 입력 필드 추가
        alertController.addTextField { [weak self] textField in
            textField.placeholder = "Task Title"
            // 선택된 행의 Task 데이터를 텍스트 필드에 기본값으로 설정
            let tasks = self?.taskManager.fetchTasks()
            let task = tasks?[indexPath.row]
            textField.text = task?.title
        }

        // 수정 버튼 액션
        let editAction = UIAlertAction(title: "Edit", style: .default) { [weak self] _ in
            if let textField = alertController.textFields?.first, let title = textField.text, !title.isEmpty {
                // 선택된 행의 Task 가져오기
                let tasks = self?.taskManager.fetchTasks()
                if let task = tasks?[indexPath.row] {
                    // Task 수정
                    self?.taskManager.updateTask(task: task, withTitle: title)
                    // 테이블 뷰 리로드
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
            // 삭제 기능 구현
            let tasks = taskManager.fetchTasks()
            let taskToDelete = tasks[indexPath.row]
            taskManager.deleteTask(task: taskToDelete)
            // 테이블 뷰에서도 삭제
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
